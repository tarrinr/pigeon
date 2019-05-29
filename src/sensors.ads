-- File: sensors.ads
-- Tarrin Rasmussen 05/2019

--------------
-- PACKAGES --
--------------

-- Libraries
with STM32F4;        use STM32F4;
with STM32F4.GPIOL;  use STM32F4.GPIOL;
with STM32F4.USARTL; use STM32F4.USARTL;


---------------------------
-- PACKAGE SPECIFICATION --
---------------------------

package SENSORS is


   --
   -- Globals
   --

   -- GPIO configuration for I2C
   GPIO_PORT   : constant GPIO_Ports := B;
   GPIO_MODE   : constant := 2#10#;   -- Alternate function mode
   GPIO_OTYPE  : constant := 2#01#;   -- Open-drain
   GPIO_OSPEED : constant := 2#00#;   -- Low speed
   GPIO_PUPD   : constant := 2#00#;   -- No pull up/down
   GPIO_AFRX   : constant := 2#0100#; -- I2C1

   -- I2C configuration
   I2C_PORT      : constant I2C_Ports := 1;
   I2C_SCL_PIN   : constant := 8;
   I2C_SDA_PIN   : constant := 9;
   I2C_INPUT_CLK : constant := 2#010000#; -- 16MHz
   I2C_FS_MODE   : constant := 2#01#;     -- Fast mode


   --
   -- Procedures
   --

   -- Initialize debug interface
   procedure i2c_init;

end SENSORS;