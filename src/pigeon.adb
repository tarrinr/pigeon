with STM32F4;        use STM32F4;
with STM32F4.RCCL;   use STM32F4.RCCL;
with STM32F4.GPIOL;  use STM32F4.GPIOL;
--with STM32F4.USARTL; use STM32F4.USARTL;
--with STM32F4.I2CL;   use STM32F4.I2CL;
--with STM32F4.SPIL;   use STM32F4.SPIL;

with DEBUG; use DEBUG;

with Ada.Real_Time; use Ada.Real_Time;

------------
-- PIGEON --
------------

procedure pigeon is

   led_delay : Time;
   led : Unsigned_1 := 0;
   rc : integer := 0;

begin

   RCC.AHB1ENR.GPIODEN := 2#1#;
   GPIO(D).MODER(15) := 2#01#;

   loop
      led_delay := Clock;
      GPIO(D).ODR(15) := led;
      led := led + 1;
      delay until led_delay + Milliseconds(50);
   end loop;


   --
   -- Initialize interfaces
   --

   -- Initialize debug interface
   pragma debug (debug_init);

   DOUT("############################\n");
   DOUT("## PIGEON DEBUG INTERFACE ##\n");
   DOUT("############################\n\n");

   DOUT(" > Debug USART interface initalized\n");

   -- Initialize I2C interface
   DOUT(" > Initializing I2C interface... ");
   --rc := I2C_init;
   case rc is
      when 0 =>
         DOUT("done\n");
      when 1 =>
         DOUT("\n### ERROR: I2C initialization failed\n");
   end case;

   -- Initialize SPI1 interface
   DOUT(" > Initializing SPI1 interface... ");
   --rc := SPI1_init;
   case rc is
      when 0 =>
         DOUT("done\n");
      when 1 =>
         DOUT("\n### ERROR: SPI1 initialization failed\n");
   end case;

   -- Initialize SPI2 interface
   DOUT(" > Initializing SPI2 interface... ");
   --rc := SPI2_init;
   case rc is
      when 0 =>
         DOUT("done\n");
      when 1 =>
         DOUT("\n### ERROR: SPI2 initialization failed\n");
   end case;

   -- Initialize DCMI interface
   DOUT(" > Initializing DCMI interface... ");
   --rc := DCMI_init;
   case rc is
      when 0 =>
         DOUT("done\n");
      when 1 =>
         DOUT("\n### ERROR: DCMI initialization failed\n");
   end case;

   -- Initialize GPIO interface
   DOUT(" > Initializing GPIO interface... ");
   --rc := GPIO_init;
   case rc is
      when 0 =>
         DOUT("done\n");
      when 1 =>
         DOUT("\n### ERROR: GPIO initialization failed\n");
   end case;

   --loop
   --   -- Read sensors
   --   DOUT(" > Reading sensors... ");
   --   --rc := peripherals.read;
   --   case rc is
   --      when 0 =>
   --         DOUT("done\n");
   --      when 1 =>
   --         DOUT("\n### ERROR: Reading sensors failed\n");
   --   end case;
--
   --   -- Filter sensor data
   --   DOUT(" > Filtering sensor data... ");
   --   --rc := peripherals.kalman;
   --   case rc is
   --      when 0 =>
   --         DOUT("done\n");
   --      when 1 =>
   --         DOUT("\n### ERROR: Filtering sensor data failed\n");
   --   end case;
--
   --   rc := peripherals.transmit;
   --   rc := peripherals.save;
   --end loop;

end pigeon;
