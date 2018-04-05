with Interfaces.C;
with System;

private  package Binding.Bases.API is
   --    B_Base *Base_ctor(Ada_Base Ada_Self);
   function ctor (Ada_Self : in System.Address) return System.Address with
     Import        => True,
     Convention    => C,
     External_Name => "Base_ctor";

   --    void Base_dtor(B_Base *Self);
   procedure dtor (Self : in System.Address) with
     Import        => True,
     Convention    => C,
     External_Name => "Base_dtor";

   --    void Base_DoTwo(B_Base *Self);
   procedure DoTwo (Self : in System.Address) with
     Import        => True,
     Convention    => C,
     External_Name => "Base_DoTwo";

   --    int Base_Value(const B_Base *Self);
   function Value (Self : in System.Address) return Interfaces.C.int with
     Import        => True,
     Convention    => C,
     External_Name => "Base_Value";

   --    void Base_SetValue(B_Base *Self, const int v);
   procedure Set_Value (Self : in System.Address; Value : in Interfaces.C.int) with
     Import        => True,
     Convention    => C,
     External_Name => "Base_SetValue";
end Binding.Bases.API;
