#include "base.hh"
#include <iostream>

Base::Base() : val(10)
{
  std::cout << "  (C++)\tBase::Base()" << std::endl;
}

Base::~Base()
{
  std::cout << "  (C++)\tBase::~Base()" << std::endl;
}


void Base::DoTwo()
{
  std::cout << "  (C++)\tBase::DoTwo()" << std::endl;
}

int Base::Value() const
{
  std::cout << "  (C++)\tBase::Value()" << std::endl;

  return val;
}

void Base::SetValue(const int v)
{
  std::cout << "  (C++)\tBase::SetValue()" << std::endl;

  val = v;
}

// TODO: Add a static object
// static Base Base::Ten();
