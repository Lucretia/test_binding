#include "derived1.hh"
#include <iostream>

Derived1::Derived1() : Base()
{
  std::cout << "  (C++)\tDerived1::Derived1()" << std::endl;
}

Derived1::Derived1(const int v) : Base(v)
{
  std::cout << "  (C++)\tDerived1::Derived1(" << v << ")" << std::endl;
}

Derived1::~Derived1()
{
  std::cout << "  (C++)\tDerived1::~Derived1()" << std::endl;
}

void Derived1::DoOne()
{
  std::cout << "  (C++)\tDerived1::DoOne()" << std::endl;
}

void Derived1::DoTwo()
{
  std::cout << "  (C++)\tDerived1::DoTwo()" << std::endl;
}
