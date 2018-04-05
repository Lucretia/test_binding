with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Latin_1;
with Ada.Unchecked_Conversion;
with System;
with Binding.Bases.API;

package body Binding.Bases is
   package L1 renames Ada.Characters.Latin_1;

--     procedure Do_One (Self : in out Base) is
--     begin
--        Put_Line ("  (Ada)" & L1.HT & "Binding.Bases.Do_One");
--     end Do_One;

   procedure Do_Two (Self : in out Base) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Bases.Do_Two");

      Binding.Bases.API.DoTwo (Self.CPP_Self);
   end Do_Two;

   function Value (Self : in Base) return Interfaces.C.int is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Bases.Value");

      return Binding.Bases.API.Value (Self.CPP_Self);
   end Value;

   procedure Set_Value (Self : in Base; Value : in Interfaces.C.int) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Bases.Set_Value");

      Binding.Bases.API.Set_Value (Self.CPP_Self, Value);
   end Set_Value;

   ---------------------------------------------------------------------------------------------------------------------
   -- Private subprograms.
   procedure Initialize (Object : in out Base) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Bases.Initialize");
   end Initialize;

   procedure Adjust (Object : in out Base) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Bases.Adjust");

      Object.Ref_Count := Object.Ref_Count + 1;
   end Adjust;

   procedure Finalize (Object : in out Base) is
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Bases.Finalize (start)");

      if Object.Ref_Count > Natural'First then
         Object.Ref_Count := Object.Ref_Count - 1;

         if Object.Ref_Count = Natural'First and Object.Owns_Ref then
            Put_Line ("  (Ada)" & L1.HT & "Binding.Bases.Finalize (deleting)");

            Binding.Bases.API.dtor (Object.CPP_Self);

            Object.CPP_Self := System.Null_Address;
         end if;
      end if;

      Put_Line ("  (Ada)" & L1.HT & "Binding.Bases.Finalize (finish)");
   end Finalize;

   ---------------------------------------------------------------------------------------------------------------------
   --  Thunks.
   function To_Base_Class is new Ada.Unchecked_Conversion (Source => System.Address, Target => Base'Class);

   procedure Thunk_Do_One (Self : in out System.Address) with
     Export        => True,
     Convention    => C,
     External_Name => "Thunk_Base_Do_One";

   procedure Thunk_Do_Two (Self : in out System.Address) with
     Export        => True,
     Convention    => C,
     External_Name => "Thunk_Base_Do_Two";

   procedure Thunk_Do_One (Self : in out System.Address) is
      B : Base'Class := To_Base_Class (Self);
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Bases.Thunk_Do_One");

      --  Dispatch to correct version of primitive.
      B.Do_One;
   end Thunk_Do_One;

   procedure Thunk_Do_Two (Self : in out System.Address) is
      B : Base'Class := To_Base_Class (Self);
   begin
      Put_Line ("  (Ada)" & L1.HT & "Binding.Bases.Thunk_Do_Two");

      --  Dispatch to correct version of primitive.
      B.Do_Two;
   end Thunk_Do_Two;
end Binding.Bases;
