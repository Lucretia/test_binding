with Interfaces.C;
with System;

private  package Binding.Derived1s.API is
   --    B_Derived1 *Derived1_ctor(Ada_Derived1 Ada_Self);
   function ctor (Ada_Self : in System.Address) return System.Address with
     Import        => True,
     Convention    => C,
     External_Name => "Derived1_ctor";

  --     B_Derived1 *Derived1_ctor(Ada_Derived1 Ada_Self, const int v);
   function ctor (Ada_Self : in System.Address; Value : in Interfaces.C.int) return System.Address with
     Import        => True,
     Convention    => C,
     External_Name => "Derived1_ctor1";

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

   --    Derived1 *Derived1_Ten()
   function Ten return System.Address with
     Import        => True,
     Convention    => C,
     External_Name => "Derived1_Ten";
end Binding.Derived1s.API;
