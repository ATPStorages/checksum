package body Checksum.CRC is

   --  Adapted from https://www.w3.org/TR/png-3/#samplecrc

   procedure Compute_CRC_Table (T : out CRC_Array)
   is
      C : Unsigned_32;
   begin
      for N in T'Range loop
         C := Unsigned_32 (N);
         for K in 0 .. 7 loop
            if (C and 1) = 1 then
               C := 16#EDB88320# xor (Shift_Right (@, 1));
            else
               C := Shift_Right (@, 1);
            end if;
         end loop;
         T (N) := C;
      end loop;
   end Compute_CRC_Table;

   procedure Update_CRC (CRC : in out Unsigned_32;
                         T : CRC_Array;
                         D : Byte_Array)
   is
   begin
      for Index in D'Range loop
         CRC :=
           T (Unsigned_8 ((@ xor Unsigned_32 (D (Index))) and Full_8))
           xor (Shift_Right (@, 8));
      end loop;
   end Update_CRC;

   function Compute_CRC (T : CRC_Array;
                         D : Byte_Array) return Unsigned_32
   is
      New_CRC : Unsigned_32 := Full_32;
   begin
      Update_CRC (New_CRC, T, D);
      return New_CRC xor Full_32;
   end Compute_CRC;

end Checksum.CRC;
