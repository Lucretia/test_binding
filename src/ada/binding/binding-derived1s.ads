with Ada.Finalization;
with Interfaces.C;
with System;
with Binding.Bases;

package Binding.Derived1s is
   type Derived1 is new Binding.Bases.Base with private;
   type Derived1_Ptr is access all Derived1;

   type Derived1_Ref (Self : access Derived1) is limited null record with
     Implicit_Dereference => Self;

   overriding
   procedure Do_One (Self : in out Derived1);

   overriding
   procedure Do_Two (Self : in out Derived1);
private
   type Derived1 is new Binding.Bases.Base with null record;

   procedure Initialize (Object : in out Derived1);
   procedure Adjust (Object : in out Derived1);
   procedure Finalize (Object : in out Derived1);
end Binding.Derived1s;
