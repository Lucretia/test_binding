#include "base.hh"

class Derived1 : public Base {
public:
  Derived1();
  virtual ~Derived1();

  virtual void DoOne();
  virtual void DoTwo();
};
