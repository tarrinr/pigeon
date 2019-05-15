--
--  Access to the STM32F407 I2C registers
--

--  For register details see:
--  Chapter 27 - Inter-integrated circuit (I2C) interface,
--  STMicroelectronic RM0090 Reference Manual

with System; use System;

package ST.STM32F4.I2C with Preelaborate is

   --------------------------
   -- I2C Memory Addresses --
   --------------------------

   RCC_Base_Address         : constant := 16#4000_5400#;
   CR1_Offset_Address       : constant := 16#00#;
   CR2_Offset_Address       : constant := 16#04#;
   OAR1_Offset_Address      : constant := 16#08#;
   OAR2_Offset_Address      : constant := 16#0C#;
   DR_Offset_Address        : constant := 16#10#;
   SR1_Offset_Address       : constant := 16#14#;
   SR2_Offset_Address       : constant := 16#18#;
   CCR_Offset_Address       : constant := 16#1C#;
   TRISE_Offset_Address     : constant := 16#20#;
   FLTR_Offset_Address      : constant := 16#24#;

   -----------------------
   -- Hardware Features --
   -----------------------

   type I2C_Ports is (Port_1, Port_2, Port_3);

   type SMBus_Mode is (I2C_Mode, SMBus_Mode);
   type SMBus_Type is (SMBus_Device, SMBus_Host);
   type POS_Type is (Current_Byte, Next_Byte);
   type SMBus_Alert_Type is (SMBA_High, SMBA_Low);

   type Clock_Freq is mod 2 ** 6;

   type Interface_Address_Type is mod 2 ** 10;
   type Address_Mode_Type is (7_Bit_Address, 10_Bit_Address);

   type Dual_Interface_Address_Type is mod 2 ** 7;

   type Data_Type is mod 2 ** 8;

   type PEC_Type is mod 2 ** 8;

   type CCR_Type is mod 2 ** 12;
   type Duty_Cycle_Mode is (Fm_Mode_2, Fm_Mode_16_9);
   type Master_Mode_Type is (Sm_Mode, Fm_Mode);

   type Rise_Time_Type is mod 2 ** 6;

   type Digital_Noise_Filter_Type is (Disable, Enable_TPCLK_1, Enable_TPCLK_2, Enable_TPCLK_3,
                                      Enable_TPCLK_4, Enable_TPCLK_5, Enable_TPCLK_6,
                                      Enable_TPCLK_7, Enable_TPCLK_8, Enable_TPCLK_9,
                                      Enable_TPCLK_10, Enable_TPCLK_11, Enable_TPCLK_12,
                                      Enable_TPCLK_13, Enable_TPCLK_14, Enable_TPCLK_15);
   --------------------
   -- Register Types --
   --------------------

   type Control_1 is record
      Software_Reset        : Reset_Type;
      SMBus_Alert           : SMBus_Alert_Type;
      Packet_Error_Checking : Enable_Type;
      ACK_PEC_Position      : POS_Type;
      Acknowledge_Enable    : Enable_Type;
      Stop_Generation       : Enable_Type;
      Start_Generation      : Enable_Type;
      Clock_Stretch_Disable : Enable_Type;
      General_Call_Enable   : Enable_Type;
      PEC_Enable            : Enable_Type;
      ARP_Enable            : Enable_Type;
      SMBus_Type            : SMBus_Type_Type;
      SMBus_Mode            : SMBus_Mode_Type;
      Peripheral_Enable     : Enable_Type;
   end record;

   type Control_2 is record
      DMA_Last_Transfer          : Enable_Type;
      DMA_Request_Enable         : Enable_Type;
      Buffer_Interrupt_Enable    : Enable_Type;
      Event_Interrupt_Enable     : Enable_Type;
      Error_Interrupt_Enable     : Enable_Type;
      Peripheral_Clock_Frequency : Clock_Freq;
   end record;

   type Own_Address_1 is record
      Address_Mode      : Address_Mode_Type;
      Interface_Address : Interface_Address_Type;
   end record;

   type Own_Address_2 is record
      Interface_Address   : Dual_Interface_Address_Type;
      Dual_Address_Enable : Enable_Type;
   end record;

   type Data is record
      Data_Buffer : Data_Type;
   end record;

   type Status_1 is record
      SMBus_Alert          : Enabled_Type;
      Timeout              : Enabled_Type;
      PEC_Error            : Enabled_Type;
      Overrun_Underrun     : Enabled_Type;
      Acknowledge_Fail     : Enabled_Type;
      Arbitration_Lost     : Enabled_Type;
      Bus_Error            : Enabled_Type;
      DR_TX_Empty          : Enabled_Type;
      DR_RX_Not_Empty      : Enabled_Type;
      Stop_Detected        : Enabled_Type;
      Header_Sent          : Enabled_Type;
      Byte_Transfer_Done   : Enabled_Type;
      Address_Sent_Matched : Enabled_Type;
      Start_Bit            : Enabled_Type;
   end record;

   type Status_2 is record
      PEC                : PEC_Type;
      Dual_Address       : Enabled_Type;
      SMBus_Host_Address : Enabled_Type;
      SMBus_Default      : Enabled_Type;
      General_Call       : Enabled_Type;
      Data_Transmitted   : Enabled_Type;
      Bus_Busy           : Enabled_Type;
      Master_Mode        : Enabled_Type;
   end record;

   type Clock_Control is record
      Master_Mode : Master_Mode_Type;
      Duty_Cycle  : Duty_Cycle_Mode;
      CCR         : CCR_Type;
   end record;

   type TRISE is record
      Max_Rise_Time : Rise_Time_Type;
   end record;

   type FLTR is record
      Analog_Noise_Filter_Disable : Enable_Type;
      Digital_Noise_Filter        : Digital_Noise_Filter_Type;
   end record;

   type I2C_Port_Registers is record
      Control_1_Register     : Control_1;
      Control_2_Register     : Control_2;
      Own_Address_1_Register : Own_Address_1;
      Own_Address_2_Register : Own_Address_2;
      Data_Register          : Data;
      Status_1_Register      : Status_1;
      Status_2_Register      : Status_2;
      Clock_Control_Register : Clock_Control;
      TRISE_Register         : TRISE;
      FLTR_Register          : FLTR;
   end record;

   ------------------------------
   -- Hardware Representations --
   ------------------------------

   for Control_1 use record
      Software_Reset        at 0 range 15 .. 15;
      SMBus_Alert           at 0 range 13 .. 13;
      Packet_Error_Checking at 0 range 12 .. 12;
      ACK_PEC_Position      at 0 range 11 .. 11;
      Acknowledge_Enable    at 0 range 10 .. 10;
      Stop_Generation       at 0 range 9 .. 9;
      Start_Generation      at 0 range 8 .. 8;
      Clock_Stretch_Disable at 0 range 7 .. 7;
      General_Call_Enable   at 0 range 6 .. 6;
      PEC_Enable            at 0 range 5 .. 5;
      ARP_Enable            at 0 range 4 .. 4;
      SMBus_Type            at 0 range 3 .. 3;
      SMBus_Mode            at 0 range 1 .. 1;
      Peripheral_Enable     at 0 range 0 .. 0;
   end record;

   for Control_2 use record
      DMA_Last_Transfer          at 0 range 12 .. 12;
      DMA_Request_Enable         at 0 range 11 .. 11;
      Buffer_Interrupt_Enable    at 0 range 10 .. 10;
      Event_Interrupt_Enable     at 0 range 9 .. 9;
      Error_Interrupt_Enable     at 0 range 8 .. 8;
      Peripheral_Clock_Frequency at 0 range 0 .. 5;
   end record;

   for Own_Address_1 use record
      Address_Mode      at 0 range 15 .. 15;
      Interface_Address at 0 range 0 .. 9;
   end record;

   for Own_Address_2 use record
      Interface_Address   at 0 range 1 .. 7;
      Dual_Address_Enable at 0 range 0 .. 0;
   end record;

   for Data use record
      Data_Buffer at 0 range 0 .. 7;
   end record;

   for Status_1 use record
      SMBus_Alert          at 0 range 15 .. 15;
      Timeout              at 0 range 14 .. 14;
      PEC_Error            at 0 range 12 .. 12;
      Overrun_Underrun     at 0 range 11 .. 11;
      Acknowledge_Fail     at 0 range 10 .. 10;
      Arbitration_Lost     at 0 range 9 .. 9;
      Bus_Error            at 0 range 8 .. 8;
      DR_TX_Empty          at 0 range 7 .. 7;
      DR_RX_Not_Empty      at 0 range 6 .. 6;
      Stop_Detected        at 0 range 4 .. 4;
      Header_Sent          at 0 range 3 .. 3;
      Byte_Transfer_Done   at 0 range 2 .. 2;
      Address_Sent_Matched at 0 range 1 .. 1;
      Start_Bit            at 0 range 0 .. 0;
   end record;

   for Status_2 use record
      PEC                at 0 range 8 .. 15;
      Dual_Address       at 0 range 7 .. 7;
      SMBus_Host_Address at 0 range 6 .. 6;
      SMBus_Default      at 0 range 5 .. 5;
      General_Call       at 0 range 4 .. 4;
      Data_Transmitted   at 0 range 2 .. 2;
      Bus_Busy           at 0 range 1 .. 1;
      Master_Mode        at 0 range 0 .. 0;
   end record;

   for Clock_Control use record
      Master_Mode at 0 range 15 .. 15;
      Duty_Cycle  at 0 range 14 .. 14;
      CCR         at 0 range 0 .. 11;
   end record;

   for TRISE use record
      Max_Rise_Time at 0 range 0 .. 5;
   end record;


   for FLTR use record
      Analog_Noise_Filter_Disable at 0 range 4 .. 4;
      Digital_Noise_Filter        at 0 range 0 .. 3;
   end record;

   for I2C_Port_Registers use record
      Control_1_Register     at CR1_Offset_Address   range 0 .. 15;
      Control_2_Register     at CR2_Offset_Address   range 0 .. 12;
      Own_Address_1_Register at OAR1_Offset_Address  range 0 .. 15;
      Own_Address_2_Register at OAR2_Offset_Address  range 0 .. 7;
      Data_Register          at DR_Offset_Address    range 0 .. 7;
      Status_1_Register      at SR1_Offset_Address   range 0 .. 15;
      Status_2_Register      at SR2_Offset_Address   range 0 .. 15;
      Clock_Control_Register at CCR_Offset_Address   range 0 .. 15;
      TRISE_Register         at TRISE_Offset_Address range 0 .. 5;
      FLTR_Register          at FLTR_Offset_Address  range 0 .. 4;
   end record;

   -------------------
   -- I2C Registers --
   -------------------

   pragma Warnings (Off, "*component of*");
   type I2C_Port_Set is array (GPIO_Ports) of GPIO_Port_Registers
     with Volatile_Components, Component_Size => 16#400# * Storage_Unit;
   pragma Warnings (On, "*component of*");

   I2C_Port_Register : I2C_Port_Set
   with Address => System'To_Address (I2C_Base_Address);

end ST.STM32F4.I2C;
