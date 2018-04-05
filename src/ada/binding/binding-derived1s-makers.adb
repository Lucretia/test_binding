with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Latin_1;
with Ada.Unchecked_Conversion;
with System.Address_To_Access_Conversions;
with Binding.Derived1s.API;

package body Binding.Derived1s.Makers is
   package L1 renames Ada.Characters.Latin_1;

   package Conversions is new System.Address_To_Access_Conversions (Derived1);
   function To is new Ada.Unchecked_Conversion (Source => Derived1_Ptr, Target => Conversions.Object_Pointer);

   procedure New_Derived1 (Object : in out Derived1) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Makers.New_Derived1 (start)");

      Object.CPP_Self  := Binding.Derived1s.API.ctor (Object'Address);
      Object.Ref_Count := Object.Ref_Count + 1;

      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Makers.New_Derived1 (finish)");
   end New_Derived1;

   procedure New_Derived1 (Object : in out Derived1; Value : in Interfaces.C.int) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Makers.New_Derived1 (" &
                  Interfaces.C.int'Image (Value) & ") (start)");

      Object.CPP_Self  := Binding.Derived1s.API.ctor (Object'Address, Value);
      Object.Ref_Count := Object.Ref_Count + 1;

      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Makers.New_Derived1 (" &
                  Interfaces.C.int'Image (Value) & ") (finish)");
   end New_Derived1;

   function Ten return Derived1 is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Ten");

      return D : Derived1 do
         D.CPP_Self  := Binding.Derived1s.API.Ten;
         D.Owns_Ref  := False;
         D.Ref_Count := 1;
      end return;
   end Ten;
end Binding.Derived1s.Makers;
