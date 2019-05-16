--
--  Access to the STM32F407 Universal synchronous asynchronous receiver
--  transmitter (USART) registers
--

--  For register details see:
--  Chapter 30 - Universal synchronous asynchronous receiver
--  transmitter (USART), STMicroelectronic RM0090 Reference Manual

with System; use System;

package ST.STM32F4.USART with Preelaborate is

   ----------------------------
   -- USART Memory Addresses --
   ----------------------------

   USART_1_Base_Address     : constant := 16#4001_1000#;
   USART_2_Base_Address     : constant := 16#4000_4400#;
   USART_3_Base_Address     : constant := 16#4000_4800#;
   UART_4_Base_Address      : constant := 16#4000_4C00#;
   UART_5_Base_Address      : constant := 16#4000_5000#;
   USART_6_Base_Address     : constant := 16#4001_1400#;
   SR_Offset_Address        : constant := 16#00#;
   DR_Offset_Address        : constant := 16#04#;
   BRR_Offset_Address       : constant := 16#08#;
   CR1_Offset_Address       : constant := 16#0C#;
   CR2_Offset_Address       : constant := 16#10#;
   CR3_Offset_Address       : constant := 16#14#;
   GTPR_Offset_Address      : constant := 16#18#;

   -----------------------
   -- Hardware Features --
   -----------------------

   type Data_Type is mod 2 ** 8;

   type Mantissa_Type is mod 2 ** 12;
   type Fraction_Type is mod 2 ** 4;

   type Oversampling_Type is (Oversampling_16, Oversampling_8);
   type Word_Length_Type is (Databits_8, Databits_9);
   type Wakeup_Type is (Idle_Line, Address_Mark);
   type Parity_Type is (Even, Odd);
   type RX_Wakeup_Type is (Active_Mode, Mute_Mode);
   type Stop_Bits_Type is (Stop_Bit_1, Stop_Bit_0_5, Stop_Bit_2, Stop_Bit_1_5);
   type Clock_Polarity_Type is (Steady_High, Steady_Low);

   --------------------
   -- Register Types --
   --------------------

   type Status is record
      CTS_Changed           : Occurred_Type;
      Line_Break            : Occurred_Type;
      DR_TX_Empty           : Occurred_Type;
      Transmission_Complete : Occurred_Type;
      DR_RX_Not_Empty       : Occurred_Type;
      Idle_Line             : Occurred_Type;
      Overrun_Error         : Occurred_Type;
      Noise_Detected        : Occurred_Type;
      Framing_Error         : Occurred_Type;
      Parity_Error          : Occurred_Type;
   end record;

   type Data is record
      Data_Buffer : Data_Type;
   end record

   type Baud_Rate is record
      DIV_Mantissa : Mantissa_Type;
      DIV_Fraction : Fraction_Type;
   end record;

   type Control_1 is record
      Oversampling_Mode     : Oversampling_Type;
      USART_Enable          : Enable_Type;
      Word_Length           : Word_Length_Type;
      Wakeup_Method         : Wakeup_Type;
      Parity_Control        : Enable_Type;
      Parity_Selection      : Parity_Type;
      PE_Interrupt          : Enable_Type;
      TXE_Interrupt         : Enable_Type;
      TX_Complete_Interrupt : Enable_Type;
      RXNE_Interrupt        : Enable_Type;
      IDLE_Interrupt        : Enable_Type;
      Transmitter_Enable    : Enable_Type;
      Receiver_Enable       : Enable_Type;
      Receiver_Wakeup       : RX_Wakeup_Type;
      Send_Break            : Enable_Type;
   end record;

   type Control_2 is record
      LIN_Enable     : Enable_Type;
      Stop_Bits      : Stop_Bits_Type;
      Clock_Enable   : Enable_Type;
      Clock_Polarity : Clock_Polarity_Type;
   end record;

   ------------------------------
   -- Hardware Representations --
   ------------------------------

   for Clock_Control use record
      PLL_I2S_Locked                        at 0 range 27 .. 27;
      PLL_I2S                               at 0 range 26 .. 26;
      PLL_Main_Locked                       at 0 range 25 .. 25;
      PLL_Main                              at 0 range 24 .. 24;
      Clock_Security_System                 at 0 range 19 .. 19;
      High_Speed_External_Clock_Bypass      at 0 range 18 .. 18;
      High_Speed_External_Clock_Ready       at 0 range 17 .. 17;
      High_Speed_External_Clock             at 0 range 16 .. 16;
      High_Speed_Internal_Clock_Calibration at 0 range  8 .. 15;
      High_Speed_Internal_Clock_Trimming    at 0 range  3 .. 7;
      High_Speed_Internal_Clock_Ready       at 0 range  1 .. 1;
      High_Speed_Internal_Clock             at 0 range  0 .. 0;
   end record;
   --  The record representations follow the format of the STM32F4 reference
   --  manual where the bits of the record are documented in decreasing bit
   --  order.

   for PLL_Configuration use record
      Peripheral_Clock_Divider at 0 range 24 .. 27;
      Clock_Source             at 0 range 22 .. 22;
      System_Clock_Divider     at 0 range 16 .. 17;
      VCO_Multiplier           at 0 range  6 .. 14;
      Input_Clock_Divider      at 0 range  0 .. 5;
   end record;

   for MCO_Prescale_Factor use (No_Division => 0,
                                Divide_By_2 => 2#100#,
                                Divide_By_3 => 2#101#,
                                Divide_By_4 => 2#110#,
                                Divide_By_5 => 2#111#);
   --  GNAT assigns sequential codes to the enumeration values in the order
   --  they appear within a type, with the first enumeration value assigned the
   --  code 0. For most enumeration representations these representations are
   --  not strictly necessary as the GNAT behaviour achieves the assignment
   --  required by the hardware. However, if there are gaps in an enumerated
   --  type's code, then a representation is required for the type. The bit
   --  representation can be express in binary (as commonly described by
   --  a microcontroller's reference manual).

   for APB_Prescale_Factor use (No_Division   => 0,
                                Divide_By_2   => 4,
                                Divide_By_4   => 5,
                                Divide_By_8   => 6,
                                Divide_By_16  => 7);
   --  Or as decimals if more convenient.

   for AHB_Prescale_Factor use (No_Division   => 0,
                                Divide_By_2   => 8,
                                Divide_By_4   => 9,
                                Divide_By_8   => 10,
                                Divide_By_16  => 11,
                                Divide_By_64  => 12,
                                Divide_By_128 => 13,
                                Divide_By_256 => 14,
                                Divide_By_512 => 15);

   for Clock_Configuration use record
      Microcontroller_Clock_Output_2           at 0 range 30 .. 31;
      Microcontroller_Clock_Output_2_Prescaler at 0 range 27 .. 29;
      Microcontroller_Clock_Output_1_Prescaler at 0 range 24 .. 26;
      I2S_Clock_Selection                      at 0 range 23 .. 23;
      Microcontroller_Clock_Output_1           at 0 range 21 .. 22;
      HSE_Clock_Divider_For_RTC                at 0 range 16 .. 20;
      APB2_Prescaler                           at 0 range 13 .. 15;
      APB1_Prescaler                           at 0 range 10 .. 12;
      AHB_Prescaler                            at 0 range  4 .. 7;
      System_Clock_Status                      at 0 range  2 .. 3;
      System_Clock_Source                      at 0 range  0 .. 1;
   end record;

   for Clock_Interrupt use record
      Clock_Security_System_Clear            at 0 range 23 .. 23;
      PLL_I2S_Ready_Clear                    at 0 range 21 .. 21;
      Main_PLL_Ready_Clear                   at 0 range 20 .. 20;
      High_Speed_External_Clock_Ready_Clear  at 0 range 19 .. 19;
      High_Speed_Internal_Clock_Ready_Clear  at 0 range 18 .. 18;
      Low_Speed_External_Clock_Ready_Clear   at 0 range 17 .. 17;
      Low_Speed_Internal_Clock_Ready_Clear   at 0 range 16 .. 16;
      PLL_I2S_Ready_Enable                   at 0 range 13 .. 13;
      Main_PLL_Read_Enable                   at 0 range 12 .. 12;
      High_Speed_External_Clock_Ready_Enable at 0 range 11 .. 11;
      High_Speed_Internal_Clock_Ready_Enable at 0 range 10 .. 10;
      Low_Speed_External_Clock_Ready_Enable  at 0 range  9 .. 9;
      Low_Speed_Internal_Clock_Ready_Enable  at 0 range  8 .. 8;
      Clock_Security_System                  at 0 range  7 .. 7;
      PLL_I2S_Ready                          at 0 range  5 .. 5;
      Main_PLL_Ready                         at 0 range  4 .. 4;
      High_Speed_External_Clock_Ready        at 0 range  3 .. 3;
      High_Speed_Internal_Clock_Ready        at 0 range  2 .. 2;
      Low_Speed_External_Clock_Ready         at 0 range  1 .. 1;
      Low_Speed_Internal_Clock_Ready         at 0 range  0 .. 0;
   end record;

   for AHB1_Peripheral_Reset use record
      USB_OTG_HS   at 0 range 29 .. 29;
      Ethernet_Mac at 0 range 25 .. 25;
      DMA2         at 0 range 22 .. 22;
      DMA1         at 0 range 21 .. 21;
      CRC          at 0 range 12 .. 12;
      IO_Port_I    at 0 range  8 .. 8;
      IO_Port_H    at 0 range  7 .. 7;
      IO_Port_G    at 0 range  6 .. 6;
      IO_Port_F    at 0 range  5 .. 5;
      IO_Port_E    at 0 range  4 .. 4;
      IO_Port_D    at 0 range  3 .. 3;
      IO_Port_C    at 0 range  2 .. 2;
      IO_Port_B    at 0 range  1 .. 1;
      IO_Port_A    at 0 range  0 .. 0;
   end record;

   for AHB2_Peripheral_Reset use record
      USB_OTG_FS              at 0 range 7 .. 7;
      Random_Number_Generator at 0 range 6 .. 6;
      Hash                    at 0 range 5 .. 5;
      Cryptographic           at 0 range 4 .. 4;
      Camera_Interface        at 0 range 0 .. 0;
   end record;

   for AHB3_Peripheral_Reset use record
      Flexible_Static_Memory_Controller at 0 range 0 .. 0;
   end record;

   for APB1_Peripheral_Reset use record
      DAC             at 0 range 29 .. 29;
      Power_Interface at 0 range 28 .. 28;
      CAN2            at 0 range 26 .. 26;
      CAN1            at 0 range 25 .. 25;
      I2C3            at 0 range 23 .. 23;
      I2C2            at 0 range 22 .. 22;
      I2C1            at 0 range 21 .. 21;
      UART5           at 0 range 20 .. 20;
      UART4           at 0 range 19 .. 19;
      UART3           at 0 range 18 .. 18;
      UART2           at 0 range 17 .. 17;
      SPI3            at 0 range 15 .. 15;
      SPI2            at 0 range 14 .. 14;
      Window_Watchdog at 0 range 11 .. 11;
      TIM14           at 0 range  8 .. 8;
      TIM13           at 0 range  7 .. 7;
      TIM12           at 0 range  6 .. 6;
      TIM7            at 0 range  5 .. 5;
      TIM6            at 0 range  4 .. 4;
      TIM5            at 0 range  3 .. 3;
      TIM4            at 0 range  2 .. 2;
      TIM3            at 0 range  1 .. 1;
      TIM2            at 0 range  0 .. 0;
   end record;

   for APB2_Peripheral_Reset use record
      TIM11                           at 0 range 18 .. 18;
      TIM10                           at 0 range 17 .. 17;
      TIM9                            at 0 range 16 .. 16;
      System_Configuration_Controller at 0 range 14 .. 14;
      SPI1                            at 0 range 12 .. 12;
      SDIO                            at 0 range 11 .. 11;
      ADC                             at 0 range  8 .. 8;
      USART6                          at 0 range  5 .. 5;
      USART1                          at 0 range  4 .. 4;
      TIM8                            at 0 range  1 .. 1;
      TIM1                            at 0 range  0 .. 0;
   end record;

   for AHB1_Peripheral_Clock_Enable use record
      USB_OTG_HS_ULPI       at 0 range 30 .. 30;
      USB_OTG_HS            at 0 range 29 .. 29;
      Ethernet_PTP          at 0 range 28 .. 28;
      Ethernet_Reception    at 0 range 27 .. 27;
      Ethernet_Transmission at 0 range 26 .. 26;
      Ethernet_Mac          at 0 range 25 .. 25;
      DMA2                  at 0 range 22 .. 22;
      DMA1                  at 0 range 21 .. 21;
      CCM_Data_Ram          at 0 range 20 .. 20;
      Backup_SRAM           at 0 range 18 .. 18;
      CRC                   at 0 range 12 .. 12;
      IO_Port_I             at 0 range  8 .. 8;
      IO_Port_H             at 0 range  7 .. 7;
      IO_Port_G             at 0 range  6 .. 6;
      IO_Port_F             at 0 range  5 .. 5;
      IO_Port_E             at 0 range  4 .. 4;
      IO_Port_D             at 0 range  3 .. 3;
      IO_Port_C             at 0 range  2 .. 2;
      IO_Port_B             at 0 range  1 .. 1;
      IO_Port_A             at 0 range  0 .. 0;
   end record;

   for AHB2_Peripheral_Clock_Enable use record
      USB_OTG_FS              at 0 range 7 .. 7;
      Random_Number_Generator at 0 range 6 .. 6;
      Hash                    at 0 range 5 .. 5;
      Cryptographic           at 0 range 4 .. 4;
      Camera_Interface        at 0 range 0 .. 0;
   end record;

   for AHB3_Peripheral_Clock_Enable use record
      Flexible_Static_Memory_Controller at 0 range 0 .. 0;
   end record;

   for APB1_Peripheral_Clock_Enable use record
      DAC             at 0 range 29 .. 29;
      Power_Interface at 0 range 28 .. 28;
      CAN2            at 0 range 26 .. 26;
      CAN1            at 0 range 25 .. 25;
      I2C3            at 0 range 23 .. 23;
      I2C2            at 0 range 22 .. 22;
      I2C1            at 0 range 21 .. 21;
      UART5           at 0 range 20 .. 20;
      UART4           at 0 range 19 .. 19;
      UART3           at 0 range 18 .. 18;
      UART2           at 0 range 17 .. 17;
      SPI3            at 0 range 15 .. 15;
      SPI2            at 0 range 14 .. 14;
      Window_Watchdog at 0 range 11 .. 11;
      TIM14           at 0 range  8 .. 8;
      TIM13           at 0 range  7 .. 7;
      TIM12           at 0 range  6 .. 6;
      TIM7            at 0 range  5 .. 5;
      TIM6            at 0 range  4 .. 4;
      TIM5            at 0 range  3 .. 3;
      TIM4            at 0 range  2 .. 2;
      TIM3            at 0 range  1 .. 1;
      TIM2            at 0 range  0 .. 0;
   end record;

   for APB2_Peripheral_Clock_Enable use record
      TIM11                           at 0 range 18 .. 18;
      TIM10                           at 0 range 17 .. 17;
      TIM9                            at 0 range 16 .. 16;
      System_Configuration_Controller at 0 range 14 .. 14;
      SPI1                            at 0 range 12 .. 12;
      SDIO                            at 0 range 11 .. 11;
      ADC3                            at 0 range 10 .. 10;
      ADC2                            at 0 range  9 .. 9;
      ADC1                            at 0 range  8 .. 8;
      USART6                          at 0 range  5 .. 5;
      USART1                          at 0 range  4 .. 4;
      TIM8                            at 0 range  1 .. 1;
      TIM1                            at 0 range  0 .. 0;
   end record;

   for Backup_Domain_Control use record
      Reset                           at 0 range 16 .. 16;
      RTC_Clock                       at 0 range 15 .. 15;
      RTC_Clock_Source                at 0 range  8 .. 9;
      Low_Speed_External_Clock_Bypass at 0 range  2 .. 2;
      Low_Speed_External_Clock_Ready  at 0 range  1 .. 1;
      Low_Speed_External_Clock        at 0 range  0 .. 0;
   end record;

   for Clock_Control_And_Status use record
      Low_Power_Reset                at 0 range 31 .. 31;
      Window_Watchdog_Reset          at 0 range 30 .. 30;
      Independent_Watchdog_Reset     at 0 range 29 .. 29;
      Software_Reset                 at 0 range 28 .. 28;
      POR_PDR_Reset                  at 0 range 27 .. 27;
      PIN_Reset                      at 0 range 26 .. 26;
      BOR_Reset                      at 0 range 25 .. 25;
      Remove_Reset_Flag              at 0 range 24 .. 24;
      Low_Speed_Internal_Clock_Ready at 0 range  1 .. 1;
      Low_Speed_Internal_Clock       at 0 range  0 .. 0;
   end record;

   for Spread_Spectrum_Clock_Generation use record
      Spread_Spectrum_Modulation at 0 range 31 .. 31;
      Spread                     at 0 range 30 .. 30;
      Incrementation_Step        at 0 range 13 .. 27;
      Modulation_Period          at 0 range  0 .. 12;
   end record;

   for PLL_I2S_Configuration use record
      I2S_Clocks_Divider at 0 range 28 .. 30;
      VCO_Multiplier     at 0 range  6 .. 14;
   end record;

   -------------------
   -- RCC Registers --
   -------------------

   --  This section defines the RCC registers that are accessed as record
   --  objects.

   --  Here we use System'To_Address to do the conversion from memory address
   --  constant to a System.Address object, because the usually used
   --  System.Storage_Elements.To_Address function is dynamic.

   Clock_Control_Register : Clock_Control
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + CR_Offset_Address);

   PLL_Configuration_Register : PLL_Configuration
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + PLLCFGR_Offset_Address);

   Clock_Configuration_Register : Clock_Configuration
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + CFGR_Offset_Address);

   Clock_Interrupt_Register : Clock_Interrupt
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + CIR_Offset_Address);

   AHB1_Peripheral_Reset_Register : AHB1_Peripheral_Reset
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + AHB1RSTR_Offset_Address);

   AHB2_Peripheral_Reset_Register : AHB2_Peripheral_Reset
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + AHB2RSTR_Offset_Address);

   AHB3_Peripheral_Reset_Register : AHB3_Peripheral_Reset
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + AHB3RSTR_Offset_Address);

   APB1_Peripheral_Reset_Register : APB1_Peripheral_Reset
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + APB1RSTR_Offset_Address);

   APB2_Peripheral_Reset_Register : APB2_Peripheral_Reset
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + APB2RSTR_Offset_Address);

   AHB1_Peripheral_Clock_Enable_Register : AHB1_Peripheral_Clock_Enable
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + AHB1ENR_Offset_Address);

   AHB2_Peripheral_Clock_Enable_Register : AHB2_Peripheral_Clock_Enable
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + AHB2ENR_Offset_Address);

   AHB3_Peripheral_Clock_Enable_Register : AHB3_Peripheral_Clock_Enable
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + AHB3ENR_Offset_Address);

   APB1_Peripheral_Clock_Enable_Register : APB1_Peripheral_Clock_Enable
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + APB1ENR_Offset_Address);

   APB2_Peripheral_Clock_Enable_Register : APB2_Peripheral_Clock_Enable
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + APB2ENR_Offset_Address);

   AHB1_Peripheral_Clock_In_Sleep_Mode_Register : AHB1_Peripheral_Clock_Enable
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + AHB1LPENR_Offset_Address);

   AHB2_Peripheral_Clock_In_Sleep_Mode_Register : AHB2_Peripheral_Clock_Enable
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + AHB2LPENR_Offset_Address);

   AHB3_Peripheral_Clock_In_Sleep_Mode_Register : AHB3_Peripheral_Clock_Enable
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + AHB3LPENR_Offset_Address);

   APB1_Peripheral_Clock_In_Sleep_Mode_Register : APB1_Peripheral_Clock_Enable
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + APB1LPENR_Offset_Address);

   APB2_Peripheral_Clock_In_Sleep_Mode_Register : APB2_Peripheral_Clock_Enable
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + APB2LPENR_Offset_Address);

   Backup_Domain_Control_Register : Backup_Domain_Control
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + BDCR_Offset_Address);

   Clock_Control_And_Status_Register : Clock_Control_And_Status
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + CSR_Offset_Address);

   Spread_Spectrum_Clock_Generation_Register : Spread_Spectrum_Clock_Generation
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + SSCGR_Offset_Address);

   PLL_I2S_Configuration_Register : PLL_I2S_Configuration
     with Volatile, Address =>
       System'To_Address (RCC_Base_Address + PLLI2SCF_Offset_Address);
end ST.STM32F4.RCC;
