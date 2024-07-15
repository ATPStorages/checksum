with Interfaces; use Interfaces;

package Checksum is

   Full_8  : constant Unsigned_32 := 16#FF#;
   Full_16 : constant Unsigned_32 := 16#FFFF#;
   Full_32 : constant Unsigned_32 := 16#FFFFFFFF#;

   type Byte_Array is array (Unsigned_32 range <>) of Unsigned_8;

end Checksum;
