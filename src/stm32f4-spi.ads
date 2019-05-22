-- Chapter 28 - Serial peripheral interface (SPI)
-- STMicroelectronic RM0090 Reference Manual

with System; use System;

package STM32F4.SPI with Preelaborate is

   private


   ----------------------
   -- MEMORY ADDRESSES --
   ----------------------

   SPI_1_BASE_ADDRESS : constant := 16#4001_3000#;
   SPI_2_BASE_ADDRESS : constant := 16#4000_3800#;
   SPI_3_BASE_ADDRESS : constant := 16#4000_3C00#;
   SPI_4_BASE_ADDRESS : constant := 16#4001_3400#;
   SPI_5_BASE_ADDRESS : constant := 16#4001_5000#;
   SPI_6_BASE_ADDRESS : constant := 16#4001_5400#;

   CR1_OFFSET_ADDRESS     : constant := 16#00#;
   CR2_OFFSET_ADDRESS     : constant := 16#04#;
   SR_OFFSET_ADDRESS      : constant := 16#08#;
   DR_OFFSET_ADDRESS      : constant := 16#0C#;
   CRCPR_OFFSET_ADDRESS   : constant := 16#10#;
   RXCRCR_OFFSET_ADDRESS  : constant := 16#14#;
   TXCRCR_OFFSET_ADDRESS  : constant := 16#18#;
   I2SCFGR_OFFSET_ADDRESS : constant := 16#1C#;
   I2SPR_OFFSET_ADDRESS   : constant := 16#20#;


   ---------------
   -- REGISTERS --
   ---------------

   --
   -- Control register 1
   --

   -- Register type
   type CR1_register is record
      BIDIMODE : Unsigned_1;
      BIDIOE   : Unsigned_1;
      CRCEN    : Unsigned_1;
      CRCNEXT  : Unsigned_1;
      DFF      : Unsigned_1;
      RXONLY   : Unsigned_1;
      SSM      : Unsigned_1;
      SSI      : Unsigned_1;
      LSBFIRST : Unsigned_1;
      SPE      : Unsigned_1;
      BR       : Unsigned_3;
      MSTR     : Unsigned_1;
      CPOL     : Unsigned_1;
      CPHA     : Unsigned_1;
   end record;

   -- Hardware representation
   for CR1_register use record
      BIDIMODE at 0 range 15 .. 15;
      BIDIOE   at 0 range 14 .. 14;
      CRCEN    at 0 range 13 .. 13;
      CRCNEXT  at 0 range 12 .. 12;
      DFF      at 0 range 11 .. 11;
      RXONLY   at 0 range 10 .. 10;
      SSM      at 0 range 9 .. 9;
      SSI      at 0 range 8 .. 8;
      LSBFIRST at 0 range 7 .. 7;
      SPE      at 0 range 6 .. 6;
      BR       at 0 range 3 .. 5;
      MSTR     at 0 range 2 .. 2;
      CPOL     at 0 range 1 .. 1;
      CPHA     at 0 range 0 .. 0;
   end record;


   --
   -- Control register 2
   --

   -- Register type
   type CR2_register is record
      TXEIE   : Unsigned_1;
      RXNEIE  : Unsigned_1;
      ERRIE   : Unsigned_1;
      FRF     : Unsigned_1;
      SSOE    : Unsigned_1;
      TXDMAEN : Unsigned_1;
      RXDMAEN : Unsigned_1;
   end record;

   -- Hardware representation
   for CR2_register use record
      TXEIE   at 0 range 7 .. 7;
      RXNEIE  at 0 range 6 .. 6;
      ERRIE   at 0 range 5 .. 5;
      FRF     at 0 range 4 .. 4;
      SSOE    at 0 range 2 .. 2;
      TXDMAEN at 0 range 1 .. 1;
      RXDMAEN at 0 range 0 .. 0;
   end record;


   --
   -- Status register
   --

   -- Register type
   type SR_register is record
      FRE    : Unsigned_1;
      BSY    : Unsigned_1;
      OVR    : Unsigned_1;
      MODF   : Unsigned_1;
      CRCERR : Unsigned_1;
      UDR    : Unsigned_1;
      CHSIDE : Unsigned_1;
      TXE    : Unsigned_1;
      RXNE   : Unsigned_1;
   end record;

   -- Hardware representation
   for SR_register use record
      FRE    at 0 range 8 .. 8;
      BSY    at 0 range 7 .. 7;
      OVR    at 0 range 6 .. 6;
      MODF   at 0 range 5 .. 5;
      CRCERR at 0 range 4 .. 4;
      UDR    at 0 range 3 .. 3;
      CHSIDE at 0 range 2 .. 2;
      TXE    at 0 range 1 .. 1;
      RXNE   at 0 range 0 .. 0;
   end record;


   --
   -- Data register
   --

   -- Register type
   type DR_register is record
      DR : Unsigned_16;
   end record;

   -- Hardware representation
   for DR_register use record
      DR at 0 range 0 .. 15;
   end record;


   --
   -- CRC polynomial register
   --

   -- Register type
   type CRCPR_register is record
      CRCPOLY : Unsigned_16;
   end record;

   -- Hardware representation
   for CRCPR_register use record
      CRCPOLY at 0 range 0 .. 15;
   end record;


   --
   -- CRC polynomial register
   --

   -- Register type
   type RXCRCR_register is record
      RXCRC : Unsigned_16;
   end record;

   -- Hardware representation
   for RXCRCR_register use record
      RXCRC at 0 range 0 .. 15;
   end record;


   --
   -- CRC polynomial register
   --

   -- Register type
   type TXCRCR_register is record
      TXCRC : Unsigned_16;
   end record;

   -- Hardware representation
   for TXCRCR_register use record
      TXCRC at 0 range 0 .. 15;
   end record;


   --
   -- I2S configuration register
   --

   -- Register type
   type I2SCFGR_register is record
      I2SMOD  : Unsigned_1;
      I2SE    : Unsigned_1;
      I2SCFG  : Unsigned_2;
      PCMSYNC : Unsigned_1;
      I2SSTD  : Unsigned_2;
      CKPOL   : Unsigned_1;
      DATLEN  : Unsigned_2;
      CHLEN   : Unsigned_1;
   end record;

   -- Hardware representation
   for I2SCFGR_register use record
      I2SMOD  at 0 range 11 .. 11;
      I2SE    at 0 range 10 .. 10;
      I2SCFG  at 0 range 8 .. 9;
      PCMSYNC at 0 range 7 .. 7;
      I2SSTD  at 0 range 4 .. 5;
      CKPOL   at 0 range 3 .. 3;
      DATLEN  at 0 range 1 .. 2;
      CHLEN   at 0 range 0 .. 0;
   end record;


   --
   -- I2S prescaler register
   --

   -- Register type
   type I2SPR_register is record
      MCKOE  : Unsigned_1;
      ODD    : Unsigned_1;
      I2SDIV : Unsigned_8;
   end record;

   -- Hardware representation
   for I2SPR_register use record
      MCKOE  at 0 range 9 .. 9;
      ODD    at 0 range 8 .. 8;
      I2SDIV at 0 range 0 .. 7;
   end record;


   ------------------
   -- REGISTER MAP --
   ------------------

   -- Register type
   type SPI_Register_Map is record
      CR1     : CR1_register;
      CR2     : CR2_register;
      SR      : SR_register;
      DR      : DR_register;
      CRCPR   : CRCPR_register;
      RXCRCR  : RXCRCR_register;
      TXCRCR  : TXCRCR_register;
      I2SCFGR : I2SCFGR_register;
      I2SPR   : I2SPR_register;
   end record;

   -- Hardware representation
   for SPI_Register_Map use record
      CR1     at CR1_OFFSET_ADDRESS     range 0 .. 15;
      CR2     at CR2_OFFSET_ADDRESS     range 0 .. 7;
      SR      at SR_OFFSET_ADDRESS      range 0 .. 8;
      DR      at DR_OFFSET_ADDRESS      range 0 .. 15;
      CRCPR   at CRCPR_OFFSET_ADDRESS   range 0 .. 15;
      RXCRCR  at RXCRCR_OFFSET_ADDRESS  range 0 .. 15;
      TXCRCR  at TXCRCR_OFFSET_ADDRESS  range 0 .. 15;
      I2SCFGR at I2SCFGR_OFFSET_ADDRESS range 0 .. 11;
      I2SPR   at I2SPR_OFFSET_ADDRESS   range 0 .. 9;
   end record;


   -----------------------------
   -- HARDWARE REPRESENTATION --
   -----------------------------

   type SPI_Ports is range 1 .. 6;
   type SPI_access is array (SPI_Ports) of access SPI_Register_Map;

   SPI_1 : aliased SPI_Register_Map
      with Address => System'To_Address (SPI_1_BASE_ADDRESS);
   
   SPI_2 : aliased SPI_Register_Map
      with Address => System'To_Address (SPI_2_BASE_ADDRESS);
   
   SPI_3 : aliased SPI_Register_Map
      with Address => System'To_Address (SPI_3_BASE_ADDRESS);
   
   SPI_4 : aliased SPI_Register_Map
      with Address => System'To_Address (SPI_4_BASE_ADDRESS);
   
   SPI_5 : aliased SPI_Register_Map
      with Address => System'To_Address (SPI_5_BASE_ADDRESS);
   
   SPI_6 : aliased SPI_Register_Map
      with Address => System'To_Address (SPI_6_BASE_ADDRESS);

   SPI : SPI_access := (1 => SPI_1'Access,
                        2 => SPI_2'Access,
                        3 => SPI_3'Access,
                        4 => SPI_4'Access,
                        5 => SPI_5'Access,
                        6 => SPI_6'Access);

end STM32F4.SPI;
