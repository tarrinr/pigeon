-- Chapter 12 - Interrupts and events
-- STMicroelectronic RM0090 Reference Manual

with System; use System;

package STM32F4.EXTI with Preelaborate is


   ----------------------
   -- MEMORY ADDRESSES --
   ----------------------

   EXTI_BASE_ADDRESS    : constant := 16#4001_3C00#;

   IMR_OFFSET_ADDRESS   : constant := 16#00#;
   EMR_OFFSET_ADDRESS   : constant := 16#04#;
   RTSR_OFFSET_ADDRESS  : constant := 16#08#;
   FTSR_OFFSET_ADDRESS  : constant := 16#0C#;
   SWIER_OFFSET_ADDRESS : constant := 16#10#;
   PR_OFFSET_ADDRESS    : constant := 16#14#;


   ---------------
   -- REGISTERS --
   ---------------

   --
   -- Interrupt mask register
   --

   -- Register type
   type IMR_register is array (mod 23) of mod 2 ** 1 with Pack;


   --
   -- Event mask register
   --

   -- Register type
   type EMR_register is array (mod 23) of mod 2 ** 1 with Pack;


   --
   -- Rising trigger selection register
   --

   -- Register type
   type RTSR_register is array (mod 23) of mod 2 ** 1 with Pack;


   --
   -- Falling trigger selection register
   --

   -- Register type
   type FTSR_register is array (mod 23) of mod 2 ** 1 with Pack;


   --
   -- Software interrupt event register
   --

   -- Register type
   type SWIER_register is array (mod 23) of mod 2 ** 1 with Pack;


   --
   -- Pending register
   --

   -- Register type
   type PR_register is array (mod 23) of mod 2 ** 1 with Pack;


   ------------------
   -- REGISTER MAP --
   ------------------

   -- Register type
   type EXTI_Register_Map is record
      IMR   : IMR_register;
      EMR   : EMR_register;
      RTSR  : RTSR_register;
      FTSR  : FTSR_register;
      SWIER : SWIER_register;
      PR    : PR_register;
   end record;

   -- Hardware representation
   for EXTI_Register_Map use record
      IMR   at IMR_OFFSET_ADDRESS   range 0 .. 22;
      EMR   at EMR_OFFSET_ADDRESS   range 0 .. 22;
      RTSR  at RTSR_OFFSET_ADDRESS  range 0 .. 22;
      FTSR  at FTSR_OFFSET_ADDRESS  range 0 .. 22;
      SWIER at SWIER_OFFSET_ADDRESS range 0 .. 22;
      PR    at PR_OFFSET_ADDRESS    range 0 .. 22;
   end record;


   -----------------------------
   -- HARDWARE REPRESENTATION --
   -----------------------------

   EXTI : EXTI_Register_Map
      with Volatile, Address => System'To_Address (EXTI_BASE_ADDRESS);

end STM32F4.EXTI;