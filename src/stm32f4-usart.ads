-- Chapter 30 - Universal synchronous asynchronous receiver transmitter (USART)
-- STMicroelectronic RM0090 Reference Manual

with System; use System;

package STM32F4.USART with Preelaborate is

   --type SR_register is private;
   --type DR_register is private;
   --type BRR_register is private;
   --type CR1_register is private;
   --type CR2_register is private;
   --type CR3_register is private;
   --type GTPR_register is private;

   type USART_Register_Map is private;
   type USART_access is private;

   USART : USART_access := (1 => USART_1'Access,
                            2 => USART_2'Access,
                            3 => USART_3'Access,
                            4 => UART_4'Access,
                            5 => UART_5'Access,
                            6 => USART_6'Access,
                            7 => UART_7'Access,
                            8 => UART_8'Access);

   private

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

   SR_OFFSET_ADDRESS   : constant := 16#00#;
   DR_OFFSET_ADDRESS   : constant := 16#04#;
   BRR_OFFSET_ADDRESS  : constant := 16#08#;
   CR1_OFFSET_ADDRESS  : constant := 16#0C#;
   CR2_OFFSET_ADDRESS  : constant := 16#10#;
   CR3_OFFSET_ADDRESS  : constant := 16#14#;
   GTPR_OFFSET_ADDRESS : constant := 16#18#;


   ---------------
   -- REGISTERS --
   ---------------

   --
   -- Status register
   --

   -- Register type
   type SR_register is record
      CTS  : Unsigned_1;
      LBD  : Unsigned_1;
      TXE  : Unsigned_1;
      TC   : Unsigned_1;
      RXNE : Unsigned_1;
      IDLE : Unsigned_1;
      ORE  : Unsigned_1;
      NF   : Unsigned_1;
      FE   : Unsigned_1;
      PE   : Unsigned_1;
   end record;

   -- Hardware representation
   for SR_register use record
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
   type DR_register is record
      DR : Unsigned_9;
   end record;

   -- Hardware representation
   for DR_register use record
      DR at 0 range 0 .. 8;
   end record;


   --
   -- Baud rate register
   --

   -- Register type
   type BRR_register is record
      DIV_MANTISSA : Unsigned_12;
      DIV_FRACTION : Unsigned_4;
   end record;

   -- Hardware representation
   for BRR_register use record
      DIV_MANTISSA at 0 range 4 .. 15;
      DIV_FRACTION at 0 range 0 .. 3;
   end record;


   --
   -- Control register 1
   --

   -- Register type
   type CR1_register is record
      OVER8  : Unsigned_1;
      UE     : Unsigned_1;
      M      : Unsigned_1;
      WAKE   : Unsigned_1;
      PCE    : Unsigned_1;
      PS     : Unsigned_1;
      PEIE   : Unsigned_1;
      TXEIE  : Unsigned_1;
      TCIE   : Unsigned_1;
      RXNEIE : Unsigned_1;
      IDLEIE : Unsigned_1;
      TE     : Unsigned_1;
      RE     : Unsigned_1;
      RWU    : Unsigned_1;
      SBK    : Unsigned_1;
   end record;

   -- Hardware representation
   for CR1_register use record
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
   type CR2_register is record
      LINEN : Unsigned_1;
      STOP  : Unsigned_2;
      CLKEN : Unsigned_1;
      CPOL  : Unsigned_1;
      CPHA  : Unsigned_1;
      LBCL  : Unsigned_1;
      LBDIE : Unsigned_1;
      LBDL  : Unsigned_1;
      ADD   : Unsigned_4;
   end record;

   -- Hardware representation
   for CR2_register use record
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
   type CR3_register is record
      ONEBIT : Unsigned_1;
      CTSIE  : Unsigned_1;
      CTSE   : Unsigned_1;
      RTSE   : Unsigned_1;
      DMAT   : Unsigned_1;
      DMAR   : Unsigned_1;
      SCEN   : Unsigned_1;
      NACK   : Unsigned_1;
      HDSEL  : Unsigned_1;
      IRLP   : Unsigned_1;
      IREN   : Unsigned_1;
      EIE    : Unsigned_1;
   end record;

   -- Hardware representation
   for CR3_register use record
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
   type GTPR_register is record
      GT  : Unsigned_8;
      PSC : Unsigned_8;
   end record;

   -- Hardware representation
   for GTPR_register use record
      GT  at 0 range 8 .. 15;
      PSC at 0 range 0 .. 7;
   end record;


   ------------------
   -- REGISTER MAP --
   ------------------

   -- Register type
   type USART_Register_Map is record
      SR   : SR_register;
      DR   : DR_register;
      BRR  : BRR_register;
      CR1  : CR1_register;
      CR2  : CR2_register;
      CR3  : CR3_register;
      GTPR : GTPR_register;
   end record;

   -- Hardware representation
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

   type USART_Ports is range 1 .. 8;
   type USART_access is array (USART_Ports) of access USART_Register_Map;

   USART_1 : aliased USART_Register_Map
      with Address => System'To_Address (USART_1_BASE_ADDRESS);
   
   USART_2 : aliased USART_Register_Map
      with Address => System'To_Address (USART_2_BASE_ADDRESS);
   
   USART_3 : aliased USART_Register_Map
      with Address => System'To_Address (USART_3_BASE_ADDRESS);
   
   UART_4 : aliased USART_Register_Map
      with Address => System'To_Address (UART_4_BASE_ADDRESS);
   
   UART_5 : aliased USART_Register_Map
      with Address => System'To_Address (UART_5_BASE_ADDRESS);
   
   USART_6 : aliased USART_Register_Map
      with Address => System'To_Address (USART_6_BASE_ADDRESS);
   
   UART_7 : aliased USART_Register_Map
      with Address => System'To_Address (UART_7_BASE_ADDRESS);
   
   UART_8 : aliased USART_Register_Map
      with Address => System'To_Address (UART_8_BASE_ADDRESS);

end STM32F4.USART;
