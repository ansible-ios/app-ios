import { assert } from "./assert.js";

// The host's internal calls must not invoke an attacker-controlled `.call`
// property on the mapper or iterator. This runs the regenerated native builtin.
let escaped = 0;
const mapper = (value, index) => value + index;
mapper.call = () => { escaped++; throw Error("mapper.call escaped"); };
const method = function () { return [3, 4][Symbol.iterator](); };
method.call = () => { escaped++; throw Error("iterator.call escaped"); };
const values = await Array.fromAsync({ [Symbol.iterator]: method }, mapper);
assert(values.length, 2); assert(values[0], 3); assert(values[1], 5);
assert(escaped, 0);
