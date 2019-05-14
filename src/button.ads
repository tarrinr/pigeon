--
--  This package provides a protected object, Speed_Button that contains the
--  state that the LEDs flash at: either at their normal rate (the rate
--  specified by the task's discriminants) or at a Fast rate (twice the rate
--  specified). The rate is switched between the two values each time the blue
--  User Button on the Discovery Board is pressed.

--  The protected object allows the state to be shared between the two tasks
--  and for the state to be updated without conflict. It also allows us to
--  provide an interrupt handler to handle the interrupt raised by the User
--  Button. This handler updates the internal state of the protected object.
--

with Ada.Interrupts.Names;

package Button is

   type Light_Speed is (Normal, Double);
   --  The speed a LED will flash at with respect to the timing properties of
   --  the LED_Controller task.

   --  The Speed_Button protected object that contains the speed state of the
   --  LEDs.

   protected Speed_Button is

      procedure Button_Interrupt_Handler with
        Attach_Handler => Ada.Interrupts.Names.EXTI0_Interrupt;
      --  The handler for the interrupt generated when the User Button is
      --  pressed.

      function Get_Current_Speed return Light_Speed;
      --  Returns the state of the Speed_Button object

   private
      Speed_State : Light_Speed := Normal;
      --  How fast the LEDs of the board should be flashed at.
   end Speed_Button;

end Button;
