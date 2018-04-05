with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Latin_1;
with Interfaces.C;
with Binding.Bases;
with Binding.Derived1s.Makers;

procedure Test_Binding is
   package C  renames Interfaces.C;
   package L1 renames Ada.Characters.Latin_1;
begin
   Put_Line ("  (Ada)" & L1.HT & "Test_Binding (start)");

   Test : declare
      D, D2 : Binding.Derived1s.Derived1;
      B : Binding.Bases.Base'Class := D;
   begin
      Put_Line ("  (Ada)" & L1.HT & "Test_Binding (declare start)");

      Binding.Derived1s.Makers.New_Derived1 (D);

      D.Do_One;
      D.Do_Two;

      Put_Line ("  (Ada)" & L1.HT & "Value: " & C.int'Image (D.Value));

      D.Set_Value (100);

      Put_Line ("  (Ada)" & L1.HT & "Value: " & C.int'Image (D.Value));

      Put_Line ("  (Ada)" & L1.HT & "Testing dispatching");

      B.Do_One;
      B.Do_Two;

      New_Line;

      Binding.Derived1s.Makers.New_Derived1 (D2, 59);

      Put_Line ("  (Ada)" & L1.HT & "Value: " & C.int'Image (D2.Value));
      Put_Line ("  (Ada)" & L1.HT & "Test_Binding (declare finish)");
   end Test;

   New_Line;

   Put_Line ("  (Ada)" & L1.HT & "Ten - Value: " & C.int'Image (Binding.Derived1s.Makers.Ten.Value));

   Put_Line ("  (Ada)" & L1.HT & "Test_Binding (finish)");
end Test_Binding;
