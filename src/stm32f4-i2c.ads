-- Chapter 27 - Inter-integrated circuit (I2C) interface
-- STMicroelectronic RM0090 Reference Manual

with System; use System;

package STM32F4.I2C with Preelaborate is

   private


   ----------------------
   -- MEMORY ADDRESSES --
   ----------------------

   I2C_BASE_ADDRESS     : constant := 16#4000_5400#;
   I2C_OFFSET_ADDRESS   : constant := 16#400#;

   CR1_OFFSET_ADDRESS   : constant := 16#00#;
   CR2_OFFSET_ADDRESS   : constant := 16#04#;
   OAR1_OFFSET_ADDRESS  : constant := 16#08#;
   OAR2_OFFSET_ADDRESS  : constant := 16#0C#;
   DR_OFFSET_ADDRESS    : constant := 16#10#;
   SR1_OFFSET_ADDRESS   : constant := 16#14#;
   SR2_OFFSET_ADDRESS   : constant := 16#18#;
   CCR_OFFSET_ADDRESS   : constant := 16#1C#;
   TRISE_OFFSET_ADDRESS : constant := 16#20#;
   FLTR_OFFSET_ADDRESS  : constant := 16#24#;


   ---------------
   -- REGISTERS --
   ---------------

   --
   -- Control register 1
   --

   -- Register type
   type CR1_register is record
      SWRST     : Unsigned_1;
      ALERT     : Unsigned_1;
      PEC       : Unsigned_1;
      POS       : Unsigned_1;
      ACK       : Unsigned_1;
      STOP      : Unsigned_1;
      START     : Unsigned_1;
      NOSTRETCH : Unsigned_1;
      ENGC      : Unsigned_1;
      ENPEC     : Unsigned_1;
      ENARP     : Unsigned_1;
      SMBTYPE   : Unsigned_1;
      SMBUS     : Unsigned_1;
      PE        : Unsigned_1;
   end record;

   -- Hardware representation
   for CR1_register use record
      SWRST     at 0 range 15 .. 15;
      ALERT     at 0 range 13 .. 13;
      PEC       at 0 range 12 .. 12;
      POS       at 0 range 11 .. 11;
      ACK       at 0 range 10 .. 10;
      STOP      at 0 range 9 .. 9;
      START     at 0 range 8 .. 8;
      NOSTRETCH at 0 range 7 .. 7;
      ENGC      at 0 range 6 .. 6;
      ENPEC     at 0 range 5 .. 5;
      ENARP     at 0 range 4 .. 4;
      SMBTYPE   at 0 range 3 .. 3;
      SMBUS     at 0 range 1 .. 1;
      PE        at 0 range 0 .. 0;
   end record;


   --
   -- Control register 2
   --

   -- Register type
   type CR2_register is record
      LAST    : Unsigned_1;
      DMAEN   : Unsigned_1;
      ITBUFEN : Unsigned_1;
      ITEVTEN : Unsigned_1;
      ITERREN : Unsigned_1;
      FREQ    : Unsigned_6;
   end record;

   -- Hardware representation
   for CR2_register use record
      LAST    at 0 range 12 .. 12;
      DMAEN   at 0 range 11 .. 11;
      ITBUFEN at 0 range 10 .. 10;
      ITEVTEN at 0 range 9 .. 9;
      ITERREN at 0 range 8 .. 8;
      FREQ    at 0 range 0 .. 5;
   end record;


   --
   -- Own address register 1
   --

   -- Register type
   type OAR1_register is record
      ADDMODE : Unsigned_1;
      ADD     : Unsigned_10;
   end record;

   -- Hardware representation
   for OAR1_register use record
      ADDMODE at 0 range 15 .. 15;
      ADD     at 0 range 0 .. 9;
   end record;


   --
   -- Own address register 2
   --

   -- Register type
   type OAR2_register is record
      ADD2   : Unsigned_7;
      ENDUAL : Unsigned_1;
   end record;

   -- Hardware representation
   for OAR2_register use record
      ADD2   at 0 range 1 .. 7;
      ENDUAL at 0 range 0 .. 0;
   end record;


   --
   -- Data register
   --

   -- Register type
   type DR_register is record
      DR : Unsigned_8;
   end record;

   -- Hardware representation
   for DR_register use record
      DR at 0 range 0 .. 7;
   end record;

   
   --
   -- Status register 1
   --

   -- Register type
   type SR1_register is record
      SMBALERT : Unsigned_1;
      TIMEOUT  : Unsigned_1;
      PECERR   : Unsigned_1;
      OVR      : Unsigned_1;
      AF       : Unsigned_1;
      ARLO     : Unsigned_1;
      BERR     : Unsigned_1;
      TxE      : Unsigned_1;
      RxNE     : Unsigned_1;
      STOPF    : Unsigned_1;
      ADD10    : Unsigned_1;
      BTF      : Unsigned_1;
      ADDR     : Unsigned_1;
      SB       : Unsigned_1;
   end record;

   -- Hardware representation
   for SR1_register use record
      SMBALERT at 0 range 15 .. 15;
      TIMEOUT  at 0 range 14 .. 14;
      PECERR   at 0 range 12 .. 12;
      OVR      at 0 range 11 .. 11;
      AF       at 0 range 10 .. 10;
      ARLO     at 0 range 9 .. 9;
      BERR     at 0 range 8 .. 8;
      TxE      at 0 range 7 .. 7;
      RxNE     at 0 range 6 .. 6;
      STOPF    at 0 range 4 .. 4;
      ADD10    at 0 range 3 .. 3;
      BTF      at 0 range 2 .. 2;
      ADDR     at 0 range 1 .. 1;
      SB       at 0 range 0 .. 0;
   end record;


   --
   -- Status register 2
   --

   -- Register type
   type SR2_register is record
      PEC        : Unsigned_8;
      DUALF      : Unsigned_1;
      SMBHOST    : Unsigned_1;
      SMBDEFAULT : Unsigned_1;
      GENCALL    : Unsigned_1;
      TRA        : Unsigned_1;
      BUSY       : Unsigned_1;
      MSL        : Unsigned_1;
   end record;

   -- Hardware representation
   for SR2_register use record
      PEC        at 0 range 8 .. 15;
      DUALF      at 0 range 7 .. 7;
      SMBHOST    at 0 range 6 .. 6;
      SMBDEFAULT at 0 range 5 .. 5;
      GENCALL    at 0 range 4 .. 4;
      TRA        at 0 range 2 .. 2;
      BUSY       at 0 range 1 .. 1;
      MSL        at 0 range 0 .. 0;
   end record;


   --
   -- Clock control register
   --

   -- Register type
   type CCR_register is record
      FS   : Unsigned_1;
      DUTY : Unsigned_1;
      CCR  : Unsigned_12;
   end record;

   -- Hardware representation
   for CCR_register use record
      FS   at 0 range 15 .. 15;
      DUTY at 0 range 14 .. 14;
      CCR  at 0 range 0 .. 11;
   end record;


   --
   -- TRISE register
   --

   -- Register type
   type TRISE_register is record
      TRISE : Unsigned_6;
   end record;

   -- Hardware representation
   for TRISE_register use record
      TRISE at 0 range 0 .. 5;
   end record;


   --
   -- FLTR register
   --

   -- Register type
   type FLTR_register is record
      ANOFF : Unsigned_1;
      DNF   : Unsigned_4;
   end record;

   -- Hardware representation
   for FLTR_register use record
      ANOFF at 0 range 4 .. 4;
      DNF   at 0 range 0 .. 3;
   end record;


   ------------------
   -- REGISTER MAP --
   ------------------

   -- Register type
   type I2C_Register_Map is record
      CR1   : CR1_register;
      CR2   : CR2_register;
      OAR1  : OAR1_register;
      OAR2  : OAR2_register;
      DR    : DR_register;
      SR1   : SR1_register;
      SR2   : SR2_register;
      CCR   : CCR_register;
      TRISE : TRISE_register;
      FLTR  : FLTR_register;
   end record;

   -- Hardware representation
   for I2C_Register_Map use record
      CR1   at CR1_OFFSET_ADDRESS   range 0 .. 15;
      CR2   at CR2_OFFSET_ADDRESS   range 0 .. 12;
      OAR1  at OAR1_OFFSET_ADDRESS  range 0 .. 15;
      OAR2  at OAR2_OFFSET_ADDRESS  range 0 .. 7;
      DR    at DR_OFFSET_ADDRESS    range 0 .. 7;
      SR1   at SR1_OFFSET_ADDRESS   range 0 .. 15;
      SR2   at SR2_OFFSET_ADDRESS   range 0 .. 15;
      CCR   at CCR_OFFSET_ADDRESS   range 0 .. 15;
      TRISE at TRISE_OFFSET_ADDRESS range 0 .. 5;
      FLTR  at FLTR_OFFSET_ADDRESS  range 0 .. 4;
   end record;


   -----------------------------
   -- HARDWARE REPRESENTATION --
   -----------------------------

   type I2C_Ports is range 1 .. 3;

   pragma Warnings (Off, "*component of*");
   type I2C_Port_Set is array (I2C_Ports) of I2C_Register_Map
      with Volatile_Components, Component_Size => I2C_OFFSET_ADDRESS * Storage_Unit;
   pragma Warnings (On, "*component of*");

   I2C : I2C_Port_Set
      with Volatile, Address => System'To_Address (I2C_BASE_ADDRESS);

end STM32F4.I2C;