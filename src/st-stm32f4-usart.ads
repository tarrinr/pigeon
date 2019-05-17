-- Chapter 30 - Universal synchronous asynchronous receiver transmitter (USART)
-- STMicroelectronic RM0090 Reference Manual

with System; use System;

package STM32F4.USART with Preelaborate is


   ----------------------
   -- MEMORY ADDRESSES --
   ----------------------

   USART_1_BASE_ADDRESS : constant := 16#4001_1000#;
   USART_2_BASE_ADDRESS : constant := 16#4000_4400#;
   USART_3_BASE_ADDRESS : constant := 16#4000_4800#;
   UART_4_BASE_ADDRESS  : constant := 16#4000_4C00#;
   UART_5_BASE_ADDRESS  : constant := 16#4000_5000#;
   USART_6_BASE_ADDRESS : constant := 16#4001_1400#;
   UART_7_BASE_ADDRESS  : constant := 16#4000_7800#;
   UART_8_BASE_ADDRESS  : constant := 16#4000_7C00#;

   SR_OFFSET_ADDRESS    : constant := 16#00#;
   DR_OFFSET_ADDRESS    : constant := 16#04#;
   BRR_OFFSET_ADDRESS   : constant := 16#08#;
   CR1_OFFSET_ADDRESS   : constant := 16#0C#;
   CR2_OFFSET_ADDRESS   : constant := 16#10#;
   CR3_OFFSET_ADDRESS   : constant := 16#14#;
   GTPR_OFFSET_ADDRESS  : constant := 16#18#;


   ---------------
   -- REGISTERS --
   ---------------


   --
   -- Status register
   --

   -- Register type
   type SR is record
      CTS  : mod 2 ** 1;
      LBD  : mod 2 ** 1;
      TXE  : mod 2 ** 1;
      TC   : mod 2 ** 1;
      RXNE : mod 2 ** 1;
      IDLE : mod 2 ** 1;
      ORE  : mod 2 ** 1;
      NF   : mod 2 ** 1;
      FE   : mod 2 ** 1;
      PE   : mod 2 ** 1;
   end record;

   -- Hardware representation
   for SR use record
      CTS  at 0 range 9 .. 9;
      LBD  at 0 range 8 .. 8;
      TXE  at 0 range 7 .. 7;
      TC   at 0 range 6 .. 6;
      RXNE at 0 range 5 .. 5;
      IDLE at 0 range 4 .. 4;
      ORE  at 0 range 3 .. 3;
      NF   at 0 range 2 .. 2;
      FE   at 0 range 1 .. 1;
      PE   at 0 range 0 .. 0;
   end record;


   --
   -- Data register
   --

   -- Register type
   type DR is mod 2 ** 8;


   --
   -- Baud rate register
   --

   -- Register type
   type BRR is record
      DIV_MANTISSA : mod 2 ** 12;
      DIV_FRACTION : mod 2 ** 4;
   end record;

   -- Hardware representation
   for BRR use record
      DIV_MANTISSA at 0 range 4 .. 15;
      DIV_FRACTION at 0 range 0 .. 3;
   end record;


   --
   -- Control register 1
   --

   -- Register type
   type CR1 is record
      OVER8  : mod 2 ** 1;
      UE     : mod 2 ** 1;
      M      : mod 2 ** 1;
      WAKE   : mod 2 ** 1;
      PCE    : mod 2 ** 1;
      PS     : mod 2 ** 1;
      PEIE   : mod 2 ** 1;
      TXEIE  : mod 2 ** 1;
      TCIE   : mod 2 ** 1;
      RXNEIE : mod 2 ** 1;
      IDLEIE : mod 2 ** 1;
      TE     : mod 2 ** 1;
      RE     : mod 2 ** 1;
      RWU    : mod 2 ** 1;
      SBK    : mod 2 ** 1;
   end record;

   -- Hardware representation
   for CR1 use record
      OVER8  at 0 range 15 .. 15;
      UE     at 0 range 13 .. 13;
      M      at 0 range 12 .. 12;
      WAKE   at 0 range 11 .. 11;
      PCE    at 0 range 10 .. 10;
      PS     at 0 range 9 .. 9;
      PEIE   at 0 range 8 .. 8;
      TXEIE  at 0 range 7 .. 7;
      TCIE   at 0 range 6 .. 6;
      RXNEIE at 0 range 5 .. 5;
      IDLEIE at 0 range 4 .. 4;
      TE     at 0 range 3 .. 3;
      RE     at 0 range 2 .. 2;
      RWU    at 0 range 1 .. 1;
      SBK    at 0 range 0 .. 0;
   end record;


   --
   -- Control register 2
   --

   -- Register type
   type CR2 is record
      LINEN : mod 2 ** 1;
      STOP  : mod 2 ** 2;
      CLKEN : mod 2 ** 1;
      CPOL  : mod 2 ** 1;
      CPHA  : mod 2 ** 1;
      LBCL  : mod 2 ** 1;
      LBDIE : mod 2 ** 1;
      LBDL  : mod 2 ** 1;
      ADD   : mod 2 ** 4;
   end record;

   -- Hardware representation
   for CR2 use record
      LINEN at 0 range 14 .. 14;
      STOP  at 0 range 12 .. 13;
      CLKEN at 0 range 11 .. 11;
      CPOL  at 0 range 10 .. 10;
      CPHA  at 0 range 9 .. 9;
      LBCL  at 0 range 8 .. 8;
      LBDIE at 0 range 6 .. 6;
      LBDL  at 0 range 5 .. 5;
      ADD   at 0 range 0 .. 3;
   end record;


   --
   -- Control register 3
   --

   -- Register type
   type CR3 is record
      ONEBIT : mod 2 ** 1;
      CTSIE  : mod 2 ** 1;
      CTSE   : mod 2 ** 1;
      RTSE   : mod 2 ** 1;
      DMAT   : mod 2 ** 1;
      DMAR   : mod 2 ** 1;
      SCEN   : mod 2 ** 1;
      NACK   : mod 2 ** 1;
      HDSEL  : mod 2 ** 1;
      IRLP   : mod 2 ** 1;
      IREN   : mod 2 ** 1;
      EIE    : mod 2 ** 1;
   end record;

   -- Hardware representation
   for CR3 use record
      ONEBIT at 0 range 11 .. 11;
      CTSIE  at 0 range 10 .. 10;
      CTSE   at 0 range 9 .. 9;
      RTSE   at 0 range 8 .. 8;
      DMAT   at 0 range 7 .. 7;
      DMAR   at 0 range 6 .. 6;
      SCEN   at 0 range 5 .. 5;
      NACK   at 0 range 4 .. 4;
      HDSEL  at 0 range 3 .. 3;
      IRLP   at 0 range 2 .. 2;
      IREN   at 0 range 1 .. 1;
      EIE    at 0 range 0 .. 0;
   end record;


   --
   -- Guard time and prescaler register
   --

   -- Register type
   type GTPR is record
      GT  : mod 2 ** 8;
      PSC : mod 2 ** 8;
   end record;

   -- Hardware representation
   for GTPR use record
      GT  at 0 range 8 .. 15;
      PSC at 0 range 0 .. 7;
   end record;


   ------------------
   -- REGISTER MAP --
   ------------------

   for USART_Register_Map use record
      SR   at SR_OFFSET_ADDRESS   range 0 .. 9;
      DR   at DR_OFFSET_ADDRESS   range 0 .. 8;
      BRR  at BRR_OFFSET_ADDRESS  range 0 .. 15;
      CR1  at CR1_OFFSET_ADDRESS  range 0 .. 15;
      CR2  at CR2_OFFSET_ADDRESS  range 0 .. 14;
      CR3  at CR3_OFFSET_ADDRESS  range 0 .. 11;
      GTPR at GTPR_OFFSET_ADDRESS range 0 .. 15;
   end record;


   -----------------------------
   -- HARDWARE REPRESENTATION --
   -----------------------------

end STM32F4.USART;
