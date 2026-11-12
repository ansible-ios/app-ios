#include "quickjs.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char *read_source(const char *path, size_t *length) {
    FILE *file = fopen(path, "rb"); if (!file) return NULL;
    if (fseek(file, 0, SEEK_END)) { fclose(file); return NULL; }
    long size = ftell(file); if (size < 0 || fseek(file, 0, SEEK_SET)) { fclose(file); return NULL; }
    char *text = malloc((size_t)size + 1);
    if (!text || fread(text, 1, size, file) != (size_t)size) { free(text); fclose(file); return NULL; }
    fclose(file); text[size] = 0; *length = size; return text;
}
static const char *assert_source_path;
static JSModuleDef *assert_module(JSContext *context, const char *name, void *opaque) {
    (void)opaque;
    const char *base = strrchr(name, '/'); base = base ? base + 1 : name;
    if (strcmp(base, "assert.js")) { JS_ThrowReferenceError(context, "Test module not allowed"); return NULL; }
    size_t length = 0; char *source = read_source(assert_source_path, &length);
    if (!source) { JS_ThrowReferenceError(context, "Missing upstream assert module"); return NULL; }
    JSValue value = JS_Eval(context, source, length, name, JS_EVAL_TYPE_MODULE | JS_EVAL_FLAG_COMPILE_ONLY);
    free(source); if (JS_IsException(value)) return NULL;
    JSModuleDef *module = JS_VALUE_GET_PTR(value); JS_FreeValue(context, value); return module;
}
static void dump_error(JSContext *context, JSValueConst error) {
    const char *text = JS_ToCString(context, error);
    fprintf(stderr, "%s\n", text ? text : "JavaScript exception"); JS_FreeCString(context, text);
    JSValue stack = JS_GetPropertyStr(context, error, "stack");
    if (JS_IsString(stack)) { text = JS_ToCString(context, stack); fprintf(stderr, "%s\n", text ? text : ""); JS_FreeCString(context, text); }
    JS_FreeValue(context, stack);
}
int main(int argc, char **argv) {
    if (argc < 3) return 2;
    assert_source_path = argv[1];
    int failures = 0;
    for (int i = 2; i < argc; i++) {
        JSRuntime *runtime = JS_NewRuntime(); JS_SetMemoryLimit(runtime, 512 * 1024 * 1024); JS_SetMaxStackSize(runtime, 8 * 1024 * 1024);
        JS_SetModuleLoaderFunc(runtime, NULL, assert_module, NULL);
        JSContext *context = JS_NewContext(runtime);
        size_t length = 0; char *source = read_source(argv[i], &length);
        if (!source) return 2;
        JSValue result = JS_Eval(context, source, length, argv[i], JS_EVAL_TYPE_MODULE); free(source);
        int failed = JS_IsException(result);
        if (failed) { JSValue error = JS_GetException(context); dump_error(context, error); JS_FreeValue(context, error); }
        int jobs; JSContext *job_context;
        while (!failed && (jobs = JS_ExecutePendingJob(runtime, &job_context)) != 0) {
            if (jobs < 0) { JSValue error = JS_GetException(job_context); dump_error(job_context, error); JS_FreeValue(job_context, error); failed = 1; }
        }
        if (!failed && JS_PromiseState(context, result) == JS_PROMISE_REJECTED) {
            JSValue error = JS_PromiseResult(context, result); dump_error(context, error); JS_FreeValue(context, error); failed = 1;
        }
        JS_FreeValue(context, result); JS_FreeContext(context); JS_FreeRuntime(runtime);
        printf("%s %s\n", failed ? "FAIL" : "PASS", argv[i]); fflush(stdout); failures += failed;
    }
    return failures ? 1 : 0;
}
