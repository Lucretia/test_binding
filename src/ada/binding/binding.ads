with Ada.Finalization;
with System;

package Binding is
   pragma Pure;

   type Root is abstract new Ada.Finalization.Controlled with
      record
         CPP_Self  : System.Address := System.Null_Address;
         Ref_Count : Natural        := Natural'First;
      end record;
end Binding;
