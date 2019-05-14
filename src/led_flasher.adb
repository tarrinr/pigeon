--
--  This simple example demonstrates the Ravenscar run-time for bare-board
--  applications and the unique features of Ada that facilitate access to the
--  registers of a microcontroller in a easy, readable and reliable way.
--
--  The example targets the SMT32F429-Discovery board and flashes the two LEDs
--  on the board. The speed of those LEDs change in response to the blue User
--  Button being pressed.
--
--  The project consists of this main procedure, two application packages and a
--  set of packages that define access to the registers of the STM32F4
--  microcontroller.
--
--  The two application packages capture the the functionality of the example:
--    * Lights: contains the functionality that flashes a LED.
--    * Button: contains the functionality that reacts to the pressing of the
--              User Button.
--
--  Each LED on the Discovery board is controlled by a corresponding task
--  contained within the Lights package. A single task type with discriminants,
--  LED_Controller, implements the behaviour of these tasks. Objects of this
--  type are created by providing the GPIO pin of the LED to be flashed, the
--  period of the flashing LED and the percentage of the period the LED is lit
--  for.
--
--  The Button package provides a protected object, Speed_Button that contains
--  an interrupt handler for the blue User Button on the Discovery board.
--  Speed_Button stores the state of the speed the LEDs should flash at: Normal
--  or Double (which is twice as fast as normal). This state alternates on each
--  press of the User Button, while the LED_Controller tasks query this state
--  every period to adjust the rate they flash the LED at.
--
--  The ST package and its children define the registers of the STM32F4
--  microcontroller as records (or an array of records where this is more
--  appropriate). Ada allows the representation of a record to specified at the
--  bit level, making them a natural choice for expressing registers in the
--  program. This is further enhanced through the use of scaler types to
--  express different register options to ensure the right values are used in
--  an easy to read form. The ST.STM32F4.RCC and GPIO packages describe these
--  representations and how to use them.
--
--  Finally, while this example may target the SMT32F429-Discovery and its
--  STM32F429ZI microcontroller, the design of the SMT32F4 family of
--  microcontrollers generally means programs written for one member of the
--  STM32F4 family can run on another without changes to the register
--  descriptions. Thus to run this example on another STM Discovery Board (or
--  other developer boards), all that is generally required is an update to
--  GPIO pins used by task object declarations in the Lights package so that
--  they correspond to the pins used by the new board. An update to the Button
--  package may also be required. See the respective packages for more details.
--
--  This example can also be run on GNATemulator. Since GNATemulator does not
--  have any LEDs, output can be shown by replacing the writes to the GPIO
--  register ports with Text_IO.Put_Line.
--

with Lights; pragma Unreferenced (Lights);
--  The Lights package provides the tasks that will perform the work of this
--  example. Since this package does deliberately not reference anything from
--  the Lights package, we suppress the associated warning GNAT will otherwise
--  generate.

with Ada.Real_Time;

-----------------
-- LED_Flasher --
-----------------

--  For this example, the main procedure does not do anything as all the work
--  is performed by the tasks in the Lights package. Thus, we delay the
--  environment task indefinitely.

procedure LED_Flasher is
begin
   loop
      delay until Ada.Real_Time.Time_Last;
   end loop;
end LED_Flasher;
