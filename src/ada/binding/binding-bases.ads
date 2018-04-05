with Ada.Finalization;
with Interfaces.C;
with System;

package Binding.Bases is
   type Base is abstract new Root with private;
   type Base_Ptr is access all Base;

   type Base_Ref (Self : access Base) is limited null record with
     Implicit_Dereference => Self;

   procedure Do_One (Self : in out Base) is abstract;
   procedure Do_Two (Self : in out Base);

   function Value (Self : in Base) return Interfaces.C.int;
   procedure Set_Value (Self : in Base; Value : in Interfaces.C.int);
private
   type Base is abstract new Root with null record;
--        record
--           CPP_Self  : System.Address := System.Null_Address;
--           Ref_Count : Natural        := Natural'First;
--        end record;

   procedure Initialize (Object : in out Base);
   procedure Adjust (Object : in out Base);
   procedure Finalize (Object : in out Base);
end Binding.Bases;
