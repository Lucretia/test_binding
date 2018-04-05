with Ada.Finalization;
with System;

package Binding is
   pragma Pure;

   type Root is abstract new Ada.Finalization.Controlled with
      record
         CPP_Self  : System.Address := System.Null_Address; --  Pointer to the C++ class.
         Owns_Ref  : Boolean        := True;                --  Was this object created by calling a ctor?
         Ref_Count : Natural        := Natural'First;
      end record;
end Binding;
