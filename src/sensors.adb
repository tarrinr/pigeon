-- File: sensors.adb
-- Tarrin Rasmussen 05/2019

--------------
-- PACKAGES --
--------------

-- Libraries
with STM32F4.RCCL;   use STM32F4.RCCL;

-- Ada packages
with Ada.Synchronous_Task_Control; use Ada.Synchronous_Task_Control;


------------------
-- PACKAGE BODY --
------------------

package body SENSORS is

   initialized : Boolean := false;

   type counter is mod 100;
   type circular_buffer is array (counter) of Character;

   buffer        : circular_buffer;
   head          : counter := 0;
   tail          : counter := 0;
   Activate_Task : Suspension_Object;


   --
   -- Tasks
   --

   -- Output debug message to USART console
   task debug_task is
      pragma Priority (1);
   end debug_task;

   task body debug_task is
   begin
      Suspend_Until_True (Activate_Task);
      while head /= tail loop
         USART(USART_PORT).DR.DR := Character'POS (buffer (head));
         head := head + 1;
         while USART(USART_PORT).SR.TXE = 0 loop
            null;
         end loop;
      end loop;
   end debug_task;


   --
   -- Procedures
   --

   -- Place message in circular buffer
   procedure fill_buffer (message : string) is
   begin
      if not initialized then
         debug_init;
         initialized := true;
      end if;
      for i in message'RANGE loop
         buffer (tail) := message (i);
         while tail + 1 = head loop
            null;
         end loop;
         tail := tail + 1;
         if not debug_task'TERMINATED then
            Set_True(Activate_Task);
         end if;
      end loop;
   end fill_buffer;


   -- Output debug message to USART console task
   procedure DOUT (message : string) is
   begin
      pragma Debug (fill_buffer (message));
   end DOUT;

   -- Initialize debugging interface
   procedure i2c_init is
   begin


      --
      -- Configure clock
      --

      -- Enable GPIO peripheral clock
      case GPIO_PORT is
         when A =>
            RCC.AHB1ENR.GPIOAEN := 1;
         when B =>
            RCC.AHB1ENR.GPIOBEN := 1;
         when C =>
            RCC.AHB1ENR.GPIOCEN := 1;
         when D =>
            RCC.AHB1ENR.GPIODEN := 1;
         when E =>
            RCC.AHB1ENR.GPIOEEN := 1;
         when F =>
            RCC.AHB1ENR.GPIOFEN := 1;
         when G =>
            RCC.AHB1ENR.GPIOGEN := 1;
         when H =>
            RCC.AHB1ENR.GPIOHEN := 1;
         when I =>
            RCC.AHB1ENR.GPIOIEN := 1;
      end case;

      -- Enable I2C peripheral clock
      case USART_PORT is
         when 1 =>
            RCC.APB2ENR.I2C1EN := 1;
         when 2 =>
            RCC.APB1ENR.I2C2EN := 1;
         when 3 =>
            RCC.APB1ENR.I2C3EN := 1;
      end case;


      --
      -- Configure GPIO
      --

      -- Set mode of GPIO
      GPIO(GPIO_PORT).MODER(I2C_SCL_PIN) := GPIO_MODE;
      GPIO(GPIO_PORT).MODER(I2C_SDA_PIN) := GPIO_MODE;

      -- Set output type of GPIO
      GPIO(GPIO_PORT).OTYPER(I2C_SCL_PIN) := GPIO_OTYPE;
      GPIO(GPIO_PORT).OTYPER(I2C_SDA_PIN) := GPIO_OTYPE;

      -- Set output speed of GPIO
      GPIO(GPIO_PORT).OSPEEDR(I2C_SCL_PIN) := GPIO_OSPEED;
      GPIO(GPIO_PORT).OSPEEDR(I2C_SDA_PIN) := GPIO_OSPEED;

      -- Set pull up/down of GPIO
      GPIO(GPIO_PORT).PUPDR(I2C_SCL_PIN) := GPIO_PUPD;
      GPIO(GPIO_PORT).PUPDR(I2C_SDA_PIN) := GPIO_PUPD;

      -- Set alternate function of GPIO
      pragma Warnings (Off, "*condition is always*");
      if I2C_SCL_PIN > 7 then
         GPIO(GPIO_PORT).AFRH(I2C_SCL_PIN - 8) := GPIO_AFRX;
      else
         GPIO(GPIO_PORT).AFRL(I2C_SCL_PIN) := GPIO_AFRX;
      end if;

      if I2C_SDA_PIN > 7 then
         GPIO(GPIO_PORT).AFRH(I2C_SDA_PIN - 8) := GPIO_AFRX;
      else 
         GPIO(GPIO_PORT).AFRL(I2C_SDA_PIN) := GPIO_AFRX;
      end if;
      pragma Warnings (On, "*condition is always*");


      --
      -- Configure I2C
      --

      -- Program peripheral input clock
      I2C(I2C_PORT).CR2.FREQ := I2C_INPUT_CLK;

      -- Set fast/standard mode
      I2C(I2C_PORT).CCR.FS := I2C_FS_MODE;

      -- Set stop bits of USART
      USART(USART_PORT).CR2.STOP := USART_STOP_BITS;

      -- Set baud rate of USART
      USART(USART_PORT).BRR.DIV_MANTISSA := USART_BR_MAN;
      USART(USART_PORT).BRR.DIV_FRACTION := USART_BR_FRAC;

      -- Set transmitter enable of USART
      USART(USART_PORT).CR1.TE := 1;

   end i2c_init;   

end SENSORS;