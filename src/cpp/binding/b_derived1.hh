#include "derived1.hh"

extern "C" {
typedef void *Ada_Derived1;  // Pointer to the Ada object for this instantiation.

typedef const void (*ThunkPtr_DoOne_Type)(Ada_Derived1);
typedef const void (*ThunkPtr_DoTwo_Type)(Ada_Derived1);
}

class B_Derived1 : public Derived1 {
public:
  B_Derived1(Ada_Derived1 d);
  B_Derived1(Ada_Derived1 d, const int v);
  virtual ~B_Derived1();

  virtual void DoOne();  // Calls thunk below.
  virtual void DoTwo();  // Calls thunk below.

private:
  static ThunkPtr_DoOne_Type ThunkPtr_DoOne;
  static ThunkPtr_DoTwo_Type ThunkPtr_DoTwo;

  Ada_Derived1 Ada_Derived1_Self;  // Pointer to the Ada derived object.
};

extern "C" {
  B_Derived1 *Derived1_ctor(Ada_Derived1 Ada_Self);
  B_Derived1 *Derived1_ctor1(Ada_Derived1 Ada_Self, const int v);
  void Derived1_dtor(B_Derived1 *Self);

  void Derived1_DoOne(B_Derived1 *Self);
  void Derived1_DoTwo(B_Derived1 *Self);
};
