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
   type IMR is array (mod 23) of mod 2 ** 1 with Pack;


   --
   -- Event mask register
   --

   -- Register type
   type EMR is array (mod 23) of mod 2 ** 1 with Pack;


   --
   -- Rising trigger selection register
   --

   -- Register type
   type RTSR is array (mod 23) of mod 2 ** 1 with Pack;


   --
   -- Falling trigger selection register
   --

   -- Register type
   type FTSR is array (mod 23) of mod 2 ** 1 with Pack;


   --
   -- Software interrupt event register
   --

   -- Register type
   type SWIER is array (mod 23) of mod 2 ** 1 with Pack;


   --
   -- Pending register
   --

   -- Register type
   type PR is array (mod 23) of mod 2 ** 1 with Pack;


   ------------------
   -- REGISTER MAP --
   ------------------

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
      with Address => System'To_Address (EXTI_Base_Address);

end STM32F4.EXTI;