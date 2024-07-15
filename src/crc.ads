with Interfaces; use Interfaces;

package CRC is

   type CRC_Array is array (Unsigned_32 range 1 .. 256) of Unsigned_32;

   Table : CRC_Array;

   procedure Compute_CRC_Table (T : out CRC_Array);

   type Byte_Array is array (Unsigned_32 range <>) of Unsigned_8;

   procedure Update_CRC (CRC : in out Unsigned_32;
                        T : CRC_Array;
                        D : Byte_Array);

   function Compute_CRC (T : CRC_Array;
                         D : Byte_Array) return Unsigned_32;

end CRC;
