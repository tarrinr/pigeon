--
--  This package defines the tasks that flash the LEDs on the Discovery Board.
--  Each task controls a single LED. The task type LED_Controller provides the
--  implementation of the tasks. Through discriminants, each task can drive a
--  different LED at different flashing rates.
--

with ST.STM32F4.GPIO; use ST.STM32F4.GPIO;

package Lights is

   subtype Duty_Cycle is Integer range 0 .. 100;
   --  The percentage a task's period the LED is on for. Expressed as an
   --  integer out of 100.

   task type LED_Controller
     (LED_Port : GPIO_Ports;
      LED_Pin  : GPIO_Pins;
      Period   : Integer;
      On_Time  : Duty_Cycle);
   --  The LED_Controller provides the implementation of the LED flashing
   --  tasks. Through the use of discriminants, each task object can control
   --  different LEDs, flashing at different speeds and duty cycles.
   --
   --  The LED assigned to the task is done through the LED_Port and LED_Pin
   --  discriminants (since GPIO pins on the STM32F4 are grouped by ports. The
   --  length of each flash cycle is given by the Period of the LED_Controller
   --  (expressed in milliseconds, while the On_Time specifies how long the LED
   --  is on for as a percentage of the LED_Controller's period.

   --  The following two object declarations create the tasks that will flash
   --  the two LEDs on the SMT32F429-Discovery Board. On this board these LEDs
   --  are on pins PG13 and PG14. If you are using a different board, you can
   --  change the LED_Port and LED_Pin discriminants to reflect the pins the
   --  LEDs on your board are connected to. For example, if you are using the
   --  STM32F4-Discovery Board, there are LEDs on pins PD12-PD15. Thus, to
   --  flash the LED on PD12 you can write:
   --
   --  LED_PD12 : LED_Controller
   --    (LED_Port => Port_D,
   --     LED_Pin  => 12,
   --     Period   => 1000,
   --     On_Time  => 50);

   LED_PG13 : LED_Controller
     (LED_Port => Port_G,
      LED_Pin  => 13,
      Period   => 1000,
      On_Time  => 50);
   --  LED_Controller for the LED on pin PG13. A cycle of this LED last for
   --  1 second and the LED is on for half this time.

   LED_PG14 : LED_Controller
     (LED_Port => Port_G,
      LED_Pin  => 14,
      Period   => 1000,
      On_Time  => 25);
   --  LED_Controller for the LED on pin PG14. A cycle of this LED last for
   --  1 second and the LED is on for a quarter this time.

end Lights;
