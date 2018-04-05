#include "base.hh"

class Derived1 : public Base {
public:
  Derived1();
  Derived1(const int v);
  virtual ~Derived1();

  virtual void DoOne();
  virtual void DoTwo();

  static Derived1 Ten;
};
