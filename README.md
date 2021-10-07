# Overview

This is a BetterC datastructure library that aims to be easy to use yet customisable.

**Disclaimer:** I'm not very academically or algorithmcally gifted, so there's 100% issues with the implementations and overall algorithms.

## Copyable and non-copyable types

Container types such as arrays and hashmaps have support for copyable and non-copyable types.

For non-copyable types, an explicit move constructor operator **must** be created otherwise the datastructures
will assume that the type cannot be moved:

```d
struct MyStruct
{
    @disable this(this){}

    void opPostMove(scope ref const MyStruct src){}
}
```

For non-copyable types, all operations that would normally copy a value, will instead move the value. **Please bear this in mind**.

Unless specified and barring bugs, dtors should also be called when appropriate.

## Allocators

Since std.experimental.allocator doesn't fully work under BetterC, this library provides its own very barebones allocators.

Currently there's only `Malloc` which uses `calloc`, `free`, and `realloc`.

Allocators can inject state into datastructures, as well as modify their constructor parameter lists, in order to fully
integrate with any given data structure.

Allocators also provide metadata such as whether they're ok with the datastructure being copyable or not.

Allocators are also given lifetime hooks, to help them manage their internal injected state.

## String

An SSO-capable string.

The `String` datastructure is a classic, always null-terminated, string with Small String Optimization on x86_64 platforms.

`String` is a copyable struct, where it will completely clone its data on copy. This isn't too bad for `String`s in the "small string" state, but can be a big performance hit for "big strings", so take a note out of C++'s footsteps on how to manage these strings.

There's not really much to say about it, since a string is a string is a string.

## Array

A flat memory array.

The `Array` datastructure is a bit more interesting. The actual implementation is in `ArrayBase` which allows the user to specify:

* Which allocator to use
* What the initial capacity is
* A function that determines what size to grow to if the array needs more capacity
* A function that determines what size to shrink to if the array needs to shrink
* A function to determine when the array should shrink

While a niche feature, this can be nice for certain use cases such as disabling automatic shrinking of the internal array buffer,
when you know that you'll be reusing that memory soon enough.

The defaults are:

* Use Malloc
* Initial size of 8
* Grow(len, cap) = max(len, cap) * 2
* Shrink(len, cap) = cap / 2
* ShrinkWhen(len, cap) = len < cap / 2

`Array` also fully supports copyable and moveable types.

It *should* have all the classic array operators overloaded, unless I missed some.

It provides a built-in `remove` function, so it can properly support moveable types.

`Array` uses different data transfer algorithms depending on whether a type is: POD, has a copy ctor, has a move operator.

## RobinHoodHashMap - aliased to HashMap

A HashMap using Robin Hood (backwards shift variant) hashing.

Similar to `Array`, this is a customisable datastructure:

* Select which allocator to use.
* What the initial capacity is.
* A function that determines what size to grow to once the load factor has been surpassed.
* A function to determine the load factor, expressed as a concrete value rather than a percentage.
* Which hash function to use.

The defaults are:

* Use Malloc
* Initial size of 8
* Grow(len, cap) = cap * 2
* LoadFactor(len, cap) = cap * 0.8
* Hash(k) = MurmurHash3(k)

Since this is the default HashMap implementation, it is aliased to `HashMap`.

`HashMap` fully supports copyable types, but not moveable types (it's such a PITA, so it's a *maybe in the future* kind of thing).