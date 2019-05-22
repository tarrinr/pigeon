-- Chapter 8 - General-Purpose I/Os (GPIO)
-- STMicroelectronic RM0090 Reference Manual

with System; use System;

package STM32F4.GPIO with Preelaborate is

   private


   ----------------------
   -- MEMORY ADDRESSES --
   ----------------------

   GPIO_BASE_ADDRESS      : constant := 16#4002_0000#;
   GPIO_OFFSET_ADDRESS    : constant := 16#400#;

   MODER_OFFSET_ADDRESS   : constant := 16#00#;
   OTYPER_OFFSET_ADDRESS  : constant := 16#04#;
   OSPEEDR_OFFSET_ADDRESS : constant := 16#08#;
   PUPDR_OFFSET_ADDRESS   : constant := 16#0C#;
   IDR_OFFSET_ADDRESS     : constant := 16#10#;
   ODR_OFFSET_ADDRESS     : constant := 16#14#;
   BSRR_OFFSET_ADDRESS    : constant := 16#18#;
   LCKR_OFFSET_ADDRESS    : constant := 16#1C#;
   AFRL_OFFSET_ADDRESS    : constant := 16#20#;
   AFRH_OFFSET_ADDRESS    : constant := 16#24#;


   ---------------
   -- REGISTERS --
   ---------------


   --
   -- Port mode register
   --

   -- Register type
   type MODER_register is new Unsigned_16_2;


   --
   -- Port output type register
   --

   -- Register type
   type OTYPER_register is new Unsigned_16_1;


   --
   -- Port output speed register
   --

   -- Register type
   type OSPEEDR_register is new Unsigned_16_2;


   --
   -- Port pull-up/pull-down register
   --

   -- Register type
   type PUPDR_register is new Unsigned_16_2;


   --
   -- Port input data register
   --

   -- Register type
   type IDR_register is new Unsigned_16_1;


   --
   -- Port output data register
   --

   -- Register type
   type ODR_register is new Unsigned_16_1;


   --
   -- Port bit set/reset register
   --

   -- Register type
   type BSRR_register is record
      BR : Unsigned_16_1;
      BS : Unsigned_16_1;
   end record;

   -- Hardware representation
   for BSRR_register use record
      BR at 0 range 16 .. 31;
      BS at 0 range 0 .. 15;
   end record;


   --
   -- Port configuration lock register
   --

   -- Register type
   type LCKR_register is record
      LCKK : Unsigned_1;
      LCK  : Unsigned_16_1;
   end record;

   -- Hardware representation
   for LCKR_register use record
      LCKK at 0 range 16 .. 16;
      LCK  at 0 range 0 .. 15;
   end record;


   --
   -- Alternate function low register
   --

   -- Register type
   type AFRL_register is new Unsigned_8_4;


   --
   -- Alternate function high register
   --

   -- Register type
   type AFRH_register is new Unsigned_8_4;



   ------------------
   -- REGISTER MAP --
   ------------------

   -- Register type
   type GPIO_Register_Map is record
      MODER   : MODER_register;
      OTYPER  : OTYPER_register;
      OSPEEDR : OSPEEDR_register;
      PUPDR   : PUPDR_register;
      IDR     : IDR_register;
      ODR     : ODR_register;
      BSRR    : BSRR_register;
      LCKR    : LCKR_register;
      AFRL    : AFRL_register;
      AFRH    : AFRH_register;
   end record;

   -- Hardware representation
   for GPIO_Register_Map use record
      MODER   at MODER_OFFSET_ADDRESS   range 0 .. 31;
      OTYPER  at OTYPER_OFFSET_ADDRESS  range 0 .. 15;
      OSPEEDR at OSPEEDR_OFFSET_ADDRESS range 0 .. 31;
      PUPDR   at PUPDR_OFFSET_ADDRESS   range 0 .. 31;
      IDR     at IDR_OFFSET_ADDRESS     range 0 .. 15;
      ODR     at ODR_OFFSET_ADDRESS     range 0 .. 15;
      BSRR    at BSRR_OFFSET_ADDRESS    range 0 .. 31;
      LCKR    at LCKR_OFFSET_ADDRESS    range 0 .. 16;
      AFRL    at AFRL_OFFSET_ADDRESS    range 0 .. 31;
      AFRH    at AFRH_OFFSET_ADDRESS    range 0 .. 31;
   end record;


   -----------------------------
   -- HARDWARE REPRESENTATION --
   -----------------------------

   type GPIO_Ports is (A, B, C, D, E, F, G, H, I, J, K);

   pragma Warnings (Off, "*component of*");
   type GPIO_Port_Set is array (GPIO_Ports) of GPIO_Register_Map
      with Volatile_Components, Component_Size => GPIO_OFFSET_ADDRESS * Storage_Unit;
   pragma Warnings (On, "*component of*");

   GPIO : GPIO_Port_Set
      with Volatile, Address => System'To_Address (GPIO_BASE_ADDRESS);

end STM32F4.GPIO;