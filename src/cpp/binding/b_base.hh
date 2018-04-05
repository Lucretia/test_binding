#include "base.hh"

extern "C" {
typedef void *Ada_Base;  // Pointer to the Ada object for this instantiation.

typedef const void (*ThunkPtr_DoOne_Type)(Ada_Base);
typedef const void (*ThunkPtr_DoTwo_Type)(Ada_Base);
}

class B_Base : public Base {
public:
  B_Base(Ada_Base b);
  B_Base(Ada_Base b, const int v);
  virtual ~B_Base();

  virtual void DoOne();  // Calls thunk below.
  virtual void DoTwo();  // Calls thunk below.

private:
  static ThunkPtr_DoOne_Type ThunkPtr_DoOne;
  static ThunkPtr_DoTwo_Type ThunkPtr_DoTwo;

  Ada_Base Ada_Base_Self;  // Pointer to the Ada derived object.
};

extern "C" {
  B_Base *Base_ctor(Ada_Base Ada_Self);
  void Base_dtor(B_Base *Self);

  void Base_DoOne(B_Base *Self);
  void Base_DoTwo(B_Base *Self);

  int Base_Value(const B_Base *Self);
  void Base_SetValue(B_Base *Self, const int v);
};
