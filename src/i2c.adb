-------------
-- MODULES --
-------------

with ST;              use ST;
with ST.STM32F4;      use ST.STM32F4;

------------------
-- PACKAGE BODY --
------------------

package body i2c is


----------------------------
-- PACKAGE INITIALIZATION --
----------------------------

begin

   -- Enable GPIO port B peripheral clock
   RCC.AHB1_Peripheral_Clock_Enable_Register.IO_Port_B := Enable;

   -- Set pin mode of GPIO
   GPIO.GPIO_Port_Set(Port_B).IO_Mode_Register(6) := Alternative_Function;
   GPIO.GPIO_Port_Set(Port_B).IO_Mode_Register(7) := Alternative_Function;

   -- Set output type of GPIO
   GPIO.GPIO_Port_Set(Port_B).Output_Driver_Register(6) := Open_Drain;
   GPIO.GPIO_Port_Set(Port_B).Output_Driver_Register(7) := Open_Drain;

   -- Set output speed of GPIO
   GPIO.GPIO_Port_Set(Port_B).Output_Pin_Speed_Register(6) := Low;
   GPIO.GPIO_Port_Set(Port_B).Output_Pin_Speed_Register(7) := Low;

   -- Set pull direction of GPIO
   GPIO.GPIO_Port_Set(Port_B).Pull_Direction_Register(6) := No_Pull;
   GPIO.GPIO_Port_Set(Port_B).Pull_Direction_Register(7) := No_Pull;

   -- Set alternate function of GPIO
   GPIO.GPIO_Port_Set(Port_B).Alternative_Function_Register(6) := 4; -- I2C1_SCL
   GPIO.GPIO_Port_Set(Port_B).Alternative_Function_Register(7) := 4; -- I2C1_SDA


   -- Enable I2C1 peripheral clock
   RCC.APB1_Peripheral_Clock_Enable.I2C1 := Enable;


end Lights;
