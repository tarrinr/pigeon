--
--  Lights Package
--

with ST;             use ST;
with ST.STM32F4;     use ST.STM32F4;
with ST.STM32F4.RCC; use ST.STM32F4.RCC;

with Ada.Real_Time; use Ada.Real_Time;

with Button; use Button;

package body Lights is

   task body LED_Controller is
      LED_On_Time  : Ada.Real_Time.Time;
      LED_Off_Time : Ada.Real_Time.Time;
      --  The time the LED will be switched on and off respectively for the
      --  current cycle.

      Divider : Integer;
      --  Used to scale the period of the task in response to the state of the
      --  Speed_Button object.

   begin

      --  Set up the GPIO registers so the microcontroller can drive the LED
      GPIO_Port_Register (LED_Port).IO_Mode_Register.Pin (LED_Pin) := Output;
      GPIO_Port_Register (LED_Port).Output_Driver_Register.Pin (LED_Pin) :=
        Push_Pull;
      GPIO_Port_Register (LED_Port).Pull_Direction_Register.Pin (LED_Pin) :=
        No_Pull;

      --  Turn the LED on and record the time this happened.
      GPIO_Port_Register (LED_Port).Set_Pin_State_Register.
        Pin_To_Set_High (LED_Pin) := High;
      LED_On_Time := Clock;

      --  The LED flasher loop. The length of time to complete the loop is the
      --  period of the task.

      loop
         --  Query the Speed_Button state. If the speed state is Normal the
         --  LED flashes at the rate given to the task. If the state is Double
         --  then the period for this cycle is half the given period.

         case Speed_Button.Get_Current_Speed is
            when Normal =>
               Divider := 1;
            when Double =>
               Divider := 2;
         end case;

         --  Calculate the on and off times for the LED for this cycle.
         LED_Off_Time := LED_On_Time +
           Milliseconds (Period / Divider * On_Time / 100);
         LED_On_Time := LED_On_Time + Milliseconds (Period / Divider);

         --  Turn the LED on and wait for the time to turn the LED off
         GPIO_Port_Register (LED_Port).Set_Pin_State_Register.
           Pin_To_Set_High (LED_Pin) := High;
         delay until LED_Off_Time;

         --  Turn the LED off and wait for the time to turn the LED on
         GPIO_Port_Register (LED_Port).Set_Pin_State_Register.
         Pin_To_Set_Low (LED_Pin) := Low;
         delay until LED_On_Time;
      end loop;
   end LED_Controller;

begin
   --  Initialization code for the Lights package. This will be executed before
   --  the tasks are run.

   --  Enable the peripheral clock to the GPIO ports D and G
   RCC.AHB1_Peripheral_Clock_Enable_Register.IO_Port_D := Enable;
   RCC.AHB1_Peripheral_Clock_Enable_Register.IO_Port_G := Enable;
end Lights;
