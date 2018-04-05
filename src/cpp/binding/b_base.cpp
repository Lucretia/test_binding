#include "b_base.hh"
#include <iostream>

// Thunk functions.
extern "C" {
  extern const void Thunk_Base_Do_One(Ada_Base);  // Exported from Ada.
  extern const void Thunk_Base_Do_Two(Ada_Base);  // Exported from Ada.
}

ThunkPtr_DoOne_Type B_Base::ThunkPtr_DoOne = Thunk_Base_Do_One;
ThunkPtr_DoTwo_Type B_Base::ThunkPtr_DoTwo = Thunk_Base_Do_Two;

// C++ Class methods.
B_Base::B_Base(Ada_Base b) : Base(), Ada_Base_Self(b) {
  std::cout << "  (C++)\tB_Base::B_Base" << std::endl;
}

B_Base::B_Base(Ada_Base b, const int v) : Base(v), Ada_Base_Self(b) {
  std::cout << "  (C++)\tB_Base::B_Base(" << v << ")" << std::endl;
}

B_Base::~B_Base() {
  std::cout << "  (C++)\tB_Base::~B_Base" << std::endl;
}

void B_Base::DoOne() {
  std::cout << "  (C++)\tB_Base::DoOne" << std::endl;

  (*ThunkPtr_DoOne)(Ada_Base_Self);
}

void B_Base::DoTwo() {
  std::cout << "  (C++)\tB_Base::DoTwo" << std::endl;

  (*ThunkPtr_DoTwo)(Ada_Base_Self);
}

// C binding functions.
extern "C" {
  B_Base *Base_ctor(Ada_Base Ada_Self) {
    std::cout << "  (C)\tBase_ctor" << std::endl;

    return new B_Base(Ada_Self);
  }

  void Base_dtor(B_Base *Self) {
    std::cout << "  (C)\tBase_dtor" << std::endl;

    delete Self;

    Self = nullptr;
  }

/*   void Base_DoOne(B_Base *Self) { */
/*     std::cout << "  (C)\tBase_DoOne" << std::endl; */

/*     Self->Base::DoOne(); */
/*   } */

  void Base_DoTwo(B_Base *Self) {
    std::cout << "  (C)\tBase_DoTwo" << std::endl;

    // Call the base class' DoTwo(), not this class' version, as that would then dispatch to Ada causing an
    // infinite loop.
    Self->Base::DoTwo();
  }

  int Base_Value(const B_Base *Self) {
    std::cout << "  (C)\tBase_Value" << std::endl;

    return Self->Value();
  }

  void Base_SetValue(B_Base *Self, const int v) {
    std::cout << "  (C)\tBase_SetValue" << std::endl;

    Self->SetValue(v);
  }
};
