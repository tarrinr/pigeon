
--  Chapter 27 - Inter-integrated circuit (I2C) interface
--  STMicroelectronic RM0090 Reference Manual

with System; use System;

package STM32F4.I2C with Preelaborate is


   ----------------------
   -- MEMORY ADDRESSES --
   ----------------------

   RCC_BASE_ADDRESS     : constant := 16#4000_5400#;

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


   ------------------
   -- REGISTER MAP --
   ------------------

   --
   -- Control register 1
   --

   -- Data types
   type SWRST_type     is mod 2 ** 1;
   type ALERT_type     is mod 2 ** 1;
   type PEC_type       is mod 2 ** 1;
   type POS_type       is mod 2 ** 1;
   type ACK_type       is mod 2 ** 1;
   type STOP_type      is mod 2 ** 1;
   type START_type     is mod 2 ** 1;
   type NOSTRETCH_type is mod 2 ** 1;
   type ENGC_type      is mod 2 ** 1;
   type ENPEC_type     is mod 2 ** 1;
   type ENARP_type     is mod 2 ** 1;
   type SMBTYPE_type   is mod 2 ** 1;
   type SMBUS_type     is mod 2 ** 1;
   type PE_type        is mod 2 ** 1;

   -- Register type
   type CR1 is record
      SWRST     : SWRST_type;
      ALERT     : ALERT_type;
      PEC       : PEC_type;
      POS       : POS_type;
      ACK       : ACK_type;
      STOP      : STOP_type;
      START     : START_type;
      NOSTRETCH : NOSTRETCH_type;
      ENGC      : ENGC_type;
      ENPEC     : ENPEC_type;
      ENARP     : ENARP_type;
      SMBTYPE   : SMBTYPE_type;
      SMBUS     : SMBUS_type;
      PE        : PE_type;
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

   -- Data types
   type LAST_type    is mod 2 ** 1;
   type DMAEN_type   is mod 2 ** 1;
   type ITBUFEN_type is mod 2 ** 1;
   type ITEVTEN_type is mod 2 ** 1;
   type ITERREN_type is mod 2 ** 1;
   type FREQ_type    is mod 2 ** 6;

   -- Register type
   type CR2 is record
      LAST    : LAST_type;
      DMAEN   : DMAEN_type;
      ITBUFEN : ITBUFEN_type;
      ITEVTEN : ITEVTEN_type;
      ITERREN : ITERREN_type;
      FREQ    : FREQ_type;
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

   -- Data types
   type ADDMODE_type is mod 2 ** 1;
   type ADD_type     is mod 2 ** 10;

   -- Register type
   type OAR1 is record
      ADDMODE : ADDMODE_type;
      ADD     : ADD_type;
   end record;

   -- Hardware representation
   for OAR1 use record
      ADDMODE at 0 range 15 .. 15;
      ADD     at 0 range 0 .. 9;
   end record;


   --
   -- Own address register 2
   --

   -- Data types
   type ADD2_type   is mod 2 ** 7;
   type ENDUAL_type is mod 2 ** 1;

   -- Register type
   type OAR2 is record
      ADD2   : ADD2_type;
      ENDUAL : ENDUAL_type;
   end record;

   -- Hardware representation
   for OAR1 use record
      ADD2   at 0 range 1 .. 7;
      ENDUAL at 0 range 0 .. 0;
   end record;


   --
   -- Data register
   --

   -- Data types
   type DR_type is mod 2 ** 8;

   -- Register type
   type DR is record
      DR : DR_type;
   end record;

   -- Hardware representation
   for DR use record
      DR at 0 range 0 .. 7;
   end record;

   
   --
   -- Status register 1
   --

   -- Data types
   type SMBALERT_type is mod 2 ** 1;
   type TIMEOUT_type  is mod 2 ** 1;
   type PECERR_type   is mod 2 ** 1;
   type OVR_type      is mod 2 ** 1;
   type AF_type       is mod 2 ** 1;
   type ARLO_type     is mod 2 ** 1;
   type BERR_type     is mod 2 ** 1;
   type TxE_type      is mod 2 ** 1;
   type RxNE_type     is mod 2 ** 1;
   type STOPF_type    is mod 2 ** 1;
   type ADD10_type    is mod 2 ** 1;
   type BTF_type      is mod 2 ** 1;
   type ADDR_type     is mod 2 ** 1;
   type SB_type       is mod 2 ** 1;

   -- Register type
   type SR1 is record
      SMBALERT : SMBALERT_type;
      TIMEOUT  : TIMEOUT_type;
      PECERR   : PECERR_type;
      OVR      : OVR_type;
      AF       : AF_type;
      ARLO     : ARLO_type;
      BERR     : BERR_type;
      TxE      : TxE_type;
      RxNE     : RxNE_type;
      STOPF    : STOPF_type;
      ADD10    : ADD10_type;
      BTF      : BTF_type;
      ADDR     : ADDR_type;
      SB       : SB_type;
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
      SMBus_Alert          : Occurred_Type;
      Timeout              : Occurred_Type;
      PEC_Error            : Occurred_Type;
      Overrun_Underrun     : Occurred_Type;
      Acknowledge_Fail     : Occurred_Type;
      Arbitration_Lost     : Occurred_Type;
      Bus_Error            : Occurred_Type;
      DR_TX_Empty          : Occurred_Type;
      DR_RX_Not_Empty      : Occurred_Type;
      Stop_Detected        : Occurred_Type;
      Header_Sent          : Occurred_Type;
      Byte_Transfer_Done   : Occurred_Type;
      Address_Sent_Matched : Occurred_Type;
      Start_Bit            : Occurred_Type;
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
      Control_1_Register     at CR1_OFFSET_ADDRESS   range 0 .. 15;
      Control_2_Register     at CR2_OFFSET_ADDRESS   range 0 .. 12;
      Own_Address_1_Register at OAR1_OFFSET_ADDRESS  range 0 .. 15;
      Own_Address_2_Register at OAR2_OFFSET_ADDRESS  range 0 .. 7;
      Data_Register          at DR_OFFSET_ADDRESS    range 0 .. 7;
      Status_1_Register      at SR1_OFFSET_ADDRESS   range 0 .. 15;
      Status_2_Register      at SR2_OFFSET_ADDRESS   range 0 .. 15;
      Clock_Control_Register at CCR_OFFSET_ADDRESS   range 0 .. 15;
      TRISE_Register         at TRISE_OFFSET_ADDRESS range 0 .. 5;
      FLTR_Register          at FLTR_OFFSET_ADDRESS  range 0 .. 4;
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
