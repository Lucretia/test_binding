#include "b_derived1.hh"
#include <iostream>

// Thunk functions.
extern "C"
{
  extern const void Thunk_Derived1_Do_One(Ada_Derived1);  // Exported from Ada.
  extern const void Thunk_Derived1_Do_Two(Ada_Derived1);  // Exported from Ada.
}

ThunkPtr_DoOne_Type B_Derived1::ThunkPtr_DoOne = Thunk_Derived1_Do_One;
ThunkPtr_DoTwo_Type B_Derived1::ThunkPtr_DoTwo = Thunk_Derived1_Do_Two;

// C++ Class methods.
B_Derived1::B_Derived1(Ada_Derived1 d) : Derived1(), Ada_Derived1_Self(d)
{
  std::cout << "  (C++)\tB_Derived1::B_Derived1" << std::endl;
}

B_Derived1::B_Derived1(Ada_Derived1 d, const int v) : Derived1(v), Ada_Derived1_Self(d)
{
  std::cout << "  (C++)\tB_Derived1::B_Derived1(" << v << ")" << std::endl;
}

B_Derived1::~B_Derived1()
{
  std::cout << "  (C++)\tB_Derived1::~B_Derived1" << std::endl;
}

void B_Derived1::DoOne()
{
  std::cout << "  (C++)\tB_Derived1::DoOne" << std::endl;

  (*this->ThunkPtr_DoOne)(Ada_Derived1_Self);
}

void B_Derived1::DoTwo()
{
  std::cout << "  (C++)\tB_Derived1::DoTwo" << std::endl;

  (*this->ThunkPtr_DoTwo)(Ada_Derived1_Self);
}

// C binding functions.
extern "C"
{
  B_Derived1 *Derived1_ctor(Ada_Derived1 Ada_Self)
  {
    std::cout << "  (C)\tDerived1_ctor" << std::endl;

    return new B_Derived1(Ada_Self);
  }

  B_Derived1 *Derived1_ctor1(Ada_Derived1 Ada_Self, const int v)
  {
    std::cout << "  (C)\tDerived1_ctor(" << v << ")" << std::endl;

    return new B_Derived1(Ada_Self, v);
  }

  void Derived1_dtor(B_Derived1 *Self)
  {
    std::cout << "  (C)\tDerived1_dtor" << std::endl;

    delete Self;

    Self = nullptr;
  }

  void Derived1_DoOne(B_Derived1 *Self)
  {
    std::cout << "  (C)\tDerived1_DoOne" << std::endl;

    // Call the base class' DoOne(), not this class' version, as that would then dispatch to Ada causing an
    // infinite loop.
    Self->Derived1::DoOne();
  }

  void Derived1_DoTwo(B_Derived1 *Self)
  {
    std::cout << "  (C)\tDerived1_DoTwo" << std::endl;

    // Call the base class' DoTwo(), not this class' version, as that would then dispatch to Ada causing an
    // infinite loop.
    Self->Derived1::DoTwo();
  }
};
