with Interfaces.C;

package Binding.Derived1s.Makers is
   procedure New_Derived1 (Object : in out Derived1);
   procedure New_Derived1 (Object : in out Derived1; Value : in Interfaces.C.int);

   function Ten return Derived1;
end Binding.Derived1s.Makers;
