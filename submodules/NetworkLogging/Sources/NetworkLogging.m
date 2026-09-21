#import <NetworkLogging/NetworkLogging.h>

#import <Foundation/Foundation.h>
#import <MtProtoKit/MTLogging.h>

static void (*bridgingTrace)(NSString *, NSString *);
void setBridgingTraceFunction(void (*f)(NSString *, NSString *)) {
    bridgingTrace = f;
}

static void (*bridgingShortTrace)(NSString *, NSString *);
void setBridgingShortTraceFunction(void (*f)(NSString *, NSString *)) {
    bridgingShortTrace = f;
}

static void TGIosappLoggingFunction(NSString *format) {
    if (bridgingTrace) {
        bridgingTrace(@"MT", format);
    }
}

static void TGIosappShortLoggingFunction(NSString *format) {
    if (bridgingShortTrace) {
        bridgingShortTrace(@"MT", format);
    }
}

void NetworkRegisterLoggingFunction() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MTLogSetLoggingFunction(&TGIosappLoggingFunction);
        MTLogSetShortLoggingFunction(&TGIosappShortLoggingFunction);
    });
}

void NetworkSetLoggingEnabled(bool value) {
    MTLogSetEnabled(value);
}
