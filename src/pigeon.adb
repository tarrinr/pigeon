--with stm32f4;       use stm32f4;
with STM32F4;       use STM32F4;
--with stm32f4.rcc;   use stm32f4.rcc;
with STM32F4.GPIO;  use STM32F4.GPIO;
--with STM32F4.RCC;  use STM32F4.RCC;
--with stm32f4.usart; use stm32f4.usart;

with Ada.Real_Time; use Ada.Real_Time;

------------
-- pigeon --
------------

procedure pigeon is

   -- GPIO configuration for I2C1
   --GPIO_MODE   : constant := 2#01#;   -- Alternate function mode
   --GPIO_OTYPE  : constant := 2#1#;    -- Open drain
   --GPIO_OSPEED : constant := 2#00#;   -- Low speed
   --GPIO_PUPD   : constant := 2#00#;   -- No pull up/down
   --GPIO_AFRL   : constant := 2#0100#; -- I2C1

   led_delay : Time;
   --led : Unsigned_1 := 2#1#;

begin
   --RCC.AHB1ENR.GPIODEN := 2#1#;
   GPIO(D).MODER(15) := 2#01#; -- Output mode

   loop
      led_delay := Clock;
      GPIO(D).ODR(15) := 1;
      delay until led_delay + Seconds(1);
      GPIO(D).ODR(15) := 0;
      delay until led_delay + Seconds(1);
   end loop;

   -- Set pin mode of GPIO
   --GPIO(B).MODER(6) := GPIO_MODE;
   --GPIO(B).MODER(7) := GPIO_MODE;

   -- Set output type of GPIO
   --GPIO(B).OTYPER(6) := GPIO_OTYPE;
   --GPIO(B).OTYPER(7) := GPIO_OTYPE;
   


   -- Set output speed of GPIO
   --GPIO(B).OSPEEDR(6) := GPIO_OSPEED;
   --GPIO(B).OSPEEDR(7) := GPIO_OSPEED;
   --GPIO(D).OSPEEDR(12) := 2#11#;

   -- Set pull direction of GPIO
   --GPIO(B).PUPDR(6) := GPIO_PUPD;
   --GPIO(B).PUPDR(7) := GPIO_PUPD;

   -- Set alternate function of GPIO
   --GPIO(B).AFRL(6) := GPIO_AFRL;
   --GPIO(B).AFRL(7) := GPIO_AFRL;

   -- Enable GPIO port B peripheral clock
   --RCC.AHB1ENR.GPIOBEN := 1;

   -- Enable I2C1 peripheral clock
   --RCC.APB1_Peripheral_Clock_Enable.I2C1 := Enable;


end pigeon;
