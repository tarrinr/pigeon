-- Chapter 27 - Inter-integrated circuit (I2C) interface
-- STMicroelectronic RM0090 Reference Manual

with System; use System;

package STM32F4.I2C with Preelaborate is


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
   type CR1 is record
      SWRST     : mod 2 ** 1;
      ALERT     : mod 2 ** 1;
      PEC       : mod 2 ** 1;
      POS       : mod 2 ** 1;
      ACK       : mod 2 ** 1;
      STOP      : mod 2 ** 1;
      START     : mod 2 ** 1;
      NOSTRETCH : mod 2 ** 1;
      ENGC      : mod 2 ** 1;
      ENPEC     : mod 2 ** 1;
      ENARP     : mod 2 ** 1;
      SMBTYPE   : mod 2 ** 1;
      SMBUS     : mod 2 ** 1;
      PE        : mod 2 ** 1;
   end record;

   -- Hardware representation
   for CR1 use record
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
   type CR2 is record
      LAST    : is mod 2 ** 1;
      DMAEN   : is mod 2 ** 1;
      ITBUFEN : is mod 2 ** 1;
      ITEVTEN : is mod 2 ** 1;
      ITERREN : is mod 2 ** 1;
      FREQ    : is mod 2 ** 6;
   end record;

   -- Hardware representation
   for CR2 use record
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
   type OAR1 is record
      ADDMODE : mod 2 ** 1;
      ADD     : mod 2 ** 10;
   end record;

   -- Hardware representation
   for OAR1 use record
      ADDMODE at 0 range 15 .. 15;
      ADD     at 0 range 0 .. 9;
   end record;


   --
   -- Own address register 2
   --

   -- Register type
   type OAR2 is record
      ADD2   : mod 2 ** 7;
      ENDUAL : mod 2 ** 1;
   end record;

   -- Hardware representation
   for OAR1 use record
      ADD2   at 0 range 1 .. 7;
      ENDUAL at 0 range 0 .. 0;
   end record;


   --
   -- Data register
   --

   -- Register type
   type DR is mod 2 ** 8;
   end record;

   
   --
   -- Status register 1
   --

   -- Register type
   type SR1 is record
      SMBALERT : mod 2 ** 1;
      TIMEOUT  : mod 2 ** 1;
      PECERR   : mod 2 ** 1;
      OVR      : mod 2 ** 1;
      AF       : mod 2 ** 1;
      ARLO     : mod 2 ** 1;
      BERR     : mod 2 ** 1;
      TxE      : mod 2 ** 1;
      RxNE     : mod 2 ** 1;
      STOPF    : mod 2 ** 1;
      ADD10    : mod 2 ** 1;
      BTF      : mod 2 ** 1;
      ADDR     : mod 2 ** 1;
      SB       : mod 2 ** 1;
   end record;

   -- Hardware representation
   for SR1 use record
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
   type SR2 is record
      PEC        : mod 2 ** 8;
      DUALF      : mod 2 ** 1;
      SMBHOST    : mod 2 ** 1;
      SMBDEFAULT : mod 2 ** 1;
      GENCALL    : mod 2 ** 1;
      TRA        : mod 2 ** 1;
      BUSY       : mod 2 ** 1;
      MSL        : mod 2 ** 1;
   end record;

   -- Hardware representation
   for SR2 use record
      PEC                at 0 range 8 .. 15;
      Dual_Address       at 0 range 7 .. 7;
      SMBus_Host_Address at 0 range 6 .. 6;
      SMBus_Default      at 0 range 5 .. 5;
      General_Call       at 0 range 4 .. 4;
      Data_Transmitted   at 0 range 2 .. 2;
      Bus_Busy           at 0 range 1 .. 1;
      Master_Mode        at 0 range 0 .. 0;
   end record;


   --
   -- Clock control register
   --

   -- Register type
   type CCR is record
      FS   : mod 2 ** 1;
      DUTY : mod 2 ** 1;
      CCR  : mod 2 ** 12;
   end record;

   -- Hardware representation
   for CCR use record
      FS   at 0 range 15 .. 15;
      DUTY at 0 range 14 .. 14;
      CCR  at 0 range 0 .. 11;
   end record;


   --
   -- TRISE register
   --

   -- Register type
   type TRISE is mod 2 ** 6;


   --
   -- FLTR register
   --

   -- Register type
   type FLTR is record
      ANOFF : mod 2 ** 1;
      DNF   : mod 2 ** 4;
   end record;

   -- Hardware representation
   for FLTR use record
      ANOFF at 0 range 4 .. 4;
      DNF   at 0 range 0 .. 3;
   end record;


   ------------------
   -- REGISTER MAP --
   ------------------

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

   type I2C_Ports is (1, 2, 3);

   pragma Warnings (Off, "*component of*");
   type I2C_Port_Set is array (I2C_Ports) of I2C_Register_Map
      with Volatile_Components, Component_Size => I2C_OFFSET_ADDRESS * Storage_Unit;
   pragma Warnings (On, "*component of*");

   I2C : I2C_Port_Set
      with Address => System'To_Address (I2C_Base_Address);

end STM32F4.I2C;