with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Latin_1;
with Ada.Unchecked_Conversion;
with System;
with Binding.Derived1s.API;

package body Binding.Derived1s is
   package L1 renames Ada.Characters.Latin_1;

   procedure Do_One (Self : in out Derived1) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Do_One");

      Binding.Derived1s.API.DoOne (Self.CPP_Self);
   end Do_One;

   procedure Do_Two (Self : in out Derived1) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Do_Two");

      Binding.Derived1s.API.DoTwo (Self.CPP_Self);
   end Do_Two;

   ---------------------------------------------------------------------------------------------------------------------
   -- Private subprograms.
   use Binding.Bases;

   procedure Initialize (Object : in out Derived1) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Initialize");

      Initialize (Base (Object));
   end Initialize;

   procedure Adjust (Object : in out Derived1) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Adjust");

      Adjust (Base (Object));
   end Adjust;

   procedure Finalize (Object : in out Derived1) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Finalize");

      Finalize (Base (Object));
   end Finalize;

   ---------------------------------------------------------------------------------------------------------------------
   --  Thunks.
   function To_Derived1_Class is new Ada.Unchecked_Conversion (Source => System.Address, Target => Derived1'Class);

   procedure Thunk_Do_One (Self : in out System.Address) with
     Export        => True,
     Convention    => C,
     External_Name => "Thunk_Derived1_Do_One";

   procedure Thunk_Do_Two (Self : in out System.Address) with
     Export        => True,
     Convention    => C,
     External_Name => "Thunk_Derived1_Do_Two";

   procedure Thunk_Do_One (Self : in out System.Address) is
      B : Derived1'Class := To_Derived1_Class (Self);
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Thunk_Do_One");

      --  Dispatch to correct version of primitive.
      B.Do_One;
   end Thunk_Do_One;

   procedure Thunk_Do_Two (Self : in out System.Address) is
      B : Derived1'Class := To_Derived1_Class (Self);
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Derived1s.Thunk_Do_Two");

      --  Dispatch to correct version of primitive.
      B.Do_Two;
   end Thunk_Do_Two;
end Binding.Derived1s;
