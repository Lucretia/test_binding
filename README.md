# Binding

This small project is a demonstration on how you can bind to C++ classes using C wrappers from Ada.

The source is organised as follows:

* An untouchable library that is stored in ```src/cpp/untouchable/```, this represents a library you cannot modify, but
  you want to use from Ada.
* A C and C++ binding layer which exports a set of C functions which is stored in ```src/cpp/binding/```, this is the
  interface to the Ada language.
* An Ada binding which maps Ada tagged types and interfaces onto the C++ class hierarchy, stored in
  ```src/ada/binding/```.
* A test program stored in ```src/ada/```.

## Virtuals

There are two cases we need to map onto when binding to C++:

1. The library you are binding has been passed an Ada object and the library calls a virtual method on this objects
   bound to C++ instantiation, i.e. Button->Draw() => ends up calling Button.Draw in Ada.
2. The Ada user code overrides a C++ virtual and then wants to call the base class' version of that method.

We cannot instantiate anything from a virtual base. In Ada we would have an abstract or interface type to map
onto the C++ virtual Base class. We need a proxy class to sit between C++ and Ada which will call the Ada equivalent
of DoOne() and DoTwo(). If We have an Ada derived type and the C++ code side calls DoOne(), it needs to call the
correct Ada primitive. The "class" hierarchy looks like the following:

```
Some_Derived (Application - Ada)
      |
    Base     (Binding - Ada)
      |
   B_Base    (Binding - C/C++)
      |
    Base     (Untouchable - C++ class)
```

We can use the idea of a "thunk" which is a pointer to a function. This can be implemented as a static constant
pointer to a function in the C/C++ binding, which is initialised at link-time to an Ada subprogram which takes a
class-wide parameter, i.e. "Self : access Base'Class" which will then dispatch to the correct Ada primitive in the
type hierarchy.

[1] Here is a function call sequence diagram to show this thunk in action, to make things clearer.

```
 (C++ class -
  dispatches via vtable)
  1. base_ptr->DoOne()    (C/C++ binding)
| -------------------> | 2. B_Base::DoOne()         (Ada binding)
|                      | -----------------> | 3. B_Base::ThunkPtr_DoOne   (Ada binding - dispatches)
|                      |                    | ------------------------> | 4. Base'Class(Self.Do_One)  (Ada derived type)
|                      |                    |                           | -------------------------> | 5. Derived.Do_One
|                      |                    |                           |                            |                   |
|                      |                    |                           |                            | <---------------- |
|                      |                    |                           | <------------------------- |
|                      |                    | <------------------------ |
|                      | <----------------- |
| <------------------- |
```

This is quite long-winded and unfortunately, the nature of wrapping C++ in another language. Ideally, direct
binding to C++ would be the best way forward, but this is not an option right now due to bugs in the compiler.

Due to this thunk calling into the Ada code, the C++ class needs to be able to say which Ada object it is calling
into. Therefore, the Ada binding needs to supply an address of the Ada object to the C/C++ layer when it is created.

From the Ada side, there is a case where the primitive, Base.Do_Two, should call the actual Base::DoTwo() when it is
called without any vtable dispatching from the C/C++ side of the binding. If there was vtable dispatching, this would
then call into the Ada side again and cause and infinite call loop and stack overflow, which is not what we want.

For C++ virtuals which are not pure, we need two C function calls to bind to, a dispatching function and a
non-dispatching function. The dispatching case is the same case as that above in [1], the non-dispatching case is
as follows in [2] and is used for calling back down to the C++ base class.

[2]

```
  (Ada derived type)
  1. Derived.Do_Two     (C/C++ binding)
| ----------------> | 2. Base_DoTwo(self)        (C/C++ binding)
|                   | ------------------> | 3. ((Base *)self)->DoTwo()
|                   |                     |                            |
|                   |                     | <------------------------- |
|                   | <------------------ |
| <---------------- |
```

In the case where the very base object has a virtual which does something, in this case Base::DoTwo(), if from the
Ada side the user were to call Base (Object).Do_Two, the actual Base::DoTwo() needs to be called. This is usually
done from within Derived.Do_Two as an extra step to make sure the base has been called.

```
  (Ada derived type)
  1. Derived.Do_Two    (Ada binding)
| ----------------> | 2. Base.Do_Two   (C/C++ binding)
|                   | -------------> | 3. Base_DoTwo()     (C++ binding)
|                   |                | --------------> | 4. B_Base::DoTwo()       (C++ class)
|                   |                |                 | -----------------> | 5. Base::DoTwo()
|                   |                |                 |                    |
|                   |                |                 | <----------------- |
|                   |                | <-------------- |
|                   | <------------- |
| <---------------- |
```
