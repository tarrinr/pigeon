--
--  Button package
--

with ST;              use ST;
with ST.STM32F4;      use ST.STM32F4;
with ST.STM32F4.EXTI; use ST.STM32F4.EXTI;

package body Button is

   Button_Line : constant Interrupt_Line := 0;
   --  The User Button is connected to EXTI0 (aka Line 0)

   protected body Speed_Button is

      ------------------------------
      -- Button_Interrupt_Handler --
      ------------------------------

      procedure Button_Interrupt_Handler is
      begin
         --  Clear the raised interrupt by writing "Occurred" to the correct
         --  position in the EXTI Pending Register.
         EXTI.Interrupt_Pending_Register.Line :=
           (Button_Line => Occurred, others => Not_Occurred);

         --  Change the Speed_State in response to the interrupt

         if Speed_State = Double then
            Speed_State := Light_Speed'First;
         else
            Speed_State := Light_Speed'Succ (Speed_State);
         end if;
      end Button_Interrupt_Handler;

      -----------------------
      -- Get_Current_Speed --
      -----------------------

      function Get_Current_Speed return Light_Speed is
      begin
         return Speed_State;
      end Get_Current_Speed;
   end Speed_Button;

begin
   --  Initialization code for the Button package. This will be executed before
   --  the tasks are run and enables the interrupt raised by the User Button
   --  to be received by the STM32F4's interrupt unit.

   EXTI.Interrupt_Mask_Register.Line (Button_Line) := Not_Masked;
   EXTI.Rising_Trigger_Selection_Register.Line (Button_Line) := Enabled;
end Button;
