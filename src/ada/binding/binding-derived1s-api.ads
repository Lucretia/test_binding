with Interfaces.C;
with System;

private  package Binding.Derived1s.API is
   --    B_Derived1 *Derived1_ctor(Ada_Derived1 Ada_Self);
   function ctor (Ada_Self : in System.Address) return System.Address with
     Import        => True,
     Convention    => C,
     External_Name => "Derived1_ctor";

   --    void Derived1_dtor(B_Derived1 *Self);
   procedure dtor (Self : in System.Address) with
     Import        => True,
     Convention    => C,
     External_Name => "Derived1_dtor";

   --    void Derived1_DoOne(B_Derived1 *Self);
   procedure DoOne (Self : in System.Address) with
     Import        => True,
     Convention    => C,
     External_Name => "Derived1_DoOne";

   --    void Derived1_DoTwo(B_Derived1 *Self);
   procedure DoTwo (Self : in System.Address) with
     Import        => True,
     Convention    => C,
     External_Name => "Derived1_DoTwo";
end Binding.Derived1s.API;
