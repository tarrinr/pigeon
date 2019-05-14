                 L E D _ F L A S H E R - S T M 3 2 F 4
                 =====================================

This simple example demonstrates the Ravenscar run-time for bare-board
applications and the unique features of Ada that facilitate access to
the registers of a microcontroller in a easy, readable and reliable way.
Additionally, the example demonstrates the use of a protected procedure as
an interrupt handler.

The example targets the SMT32F429-Discovery board and flashes the two LEDs on
the board. The speed of those LEDs change in response to an interrupt raised
when the blue User Button is pressed.

While targeting a specific developer board, the design of the STM32F4 family
of microcontrollers allows the example to run largely unmodified on other STM
discovery boards and other boards using an STM32F4 microcontroller. Generally
the only change required to the code is an update to the pin assignments for
the LEDs as different boards will typically connect them to different pins.
See the code for more details on how to achieve this.

Even if you are not using a STM32F4, this example is still useful as a guide
on how to use a protected procedure as an interrupt handler and how to access
the registers of a microcontroller in a way that takes advantages of Ada's
strengths.

If you are using STM32F4 microcontroller and have a ST-Link JTAG probe (which
is integrated in STM Discovery board) you can download the compiled example
from within GPS by connecting the board to your computer and pressing the
"flash to board" button on the toolbar. See the GPS User's Guide and the
GNAT User's Guide Supplement for Cross Platforms for more information.
