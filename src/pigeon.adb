with STM32F4;        use STM32F4;
with STM32F4.RCCL;   use STM32F4.RCCL;
with STM32F4.GPIOL;  use STM32F4.GPIOL;
with STM32F4.USARTL; use STM32F4.USARTL;
with STM32F4.I2CL;   use STM32F4.I2CL;
with STM32F4.SPIL;   use STM32F4.SPIL;

with DEBUG;

with Ada.Real_Time; use Ada.Real_Time;

------------
-- PIGEON --
------------

procedure pigeon is

   led_delay : Time;
   led : Unsigned_1 := 0;

begin
   DOUT();
   RCC.AHB1ENR.GPIODEN := 2#1#;
   GPIO(D).MODER(15) := 2#01#;

   loop
      led_delay := Clock;
      GPIO(D).ODR(15) := led;
      led := led + 1;
      delay until led_delay + Milliseconds(50);
   end loop;

end pigeon;
