package body Checksum.Adler is

   --  Adapted from https://github.com/madler/zlib/blob/develop/adler32.c
   
   Base : constant Unsigned_32 := 65521;
   
   procedure Update_Adler (Adler : in out Unsigned_32; Data : Byte_Array)
   is
      Sum_2 : Unsigned_32 := Shift_Right (Adler, 16) and Full_16;
   begin
      Adler := @ and Full_16;
      
      case Data'Length is
         when 0 =>
            Adler := 1;
         when 1 =>
            Adler := @ + Unsigned_32 (Data (0));
            if Adler >= Base then
               Adler := @ - Base;
            end if;
         
            Sum_2 := @ + Adler;
            if Sum_2 >= Base then
               Sum_2 := @ - Base;
            end if;
         
            Adler := @ or Shift_Left (Sum_2, 16);
         when 2 .. 15 =>
            for Index in Data'Range loop
               Adler := @ + Unsigned_32 (Data (Index)); --  ??
               Sum_2 := @ + Adler;
            end loop;
            
            if Adler >= Base then
               Adler := @ - Base;
            end if;
            
            Adler := @ or Shift_Left ((Sum_2 rem Base), 16);
         when others =>
            --  Rvw 97-124
            null;
      end case;
      
   end Update_Adler;

end Checksum.Adler;
