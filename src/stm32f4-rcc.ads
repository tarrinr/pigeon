-- Chapter 7 - Reset and clock control for STM32F405xx/07xx and STM32F415xx/17xx (RCC)
-- STMicroelectronic RM0090 Reference Manual

with System; use System;

package STM32F4.RCC with Preelaborate is


   ----------------------
   -- MEMORY ADDRESSES --
   ----------------------

   RCC_BASE_ADDRESS          : constant := 16#4002_3800#;
   
   CR_OFFSET_ADDRESS         : constant := 16#00#;
   PLLCFGR_OFFSET_ADDRESS    : constant := 16#04#;
   CFGR_OFFSET_ADDRESS       : constant := 16#08#;
   CIR_OFFSET_ADDRESS        : constant := 16#0C#;
   AHB1RSTR_OFFSET_ADDRESS   : constant := 16#10#;
   AHB2RSTR_OFFSET_ADDRESS   : constant := 16#14#;
   AHB3RSTR_OFFSET_ADDRESS   : constant := 16#18#;
   APB1RSTR_OFFSET_ADDRESS   : constant := 16#20#;
   APB2RSTR_OFFSET_ADDRESS   : constant := 16#24#;
   AHB1ENR_OFFSET_ADDRESS    : constant := 16#30#;
   AHB2ENR_OFFSET_ADDRESS    : constant := 16#34#;
   AHB3ENR_OFFSET_ADDRESS    : constant := 16#38#;
   APB1ENR_OFFSET_ADDRESS    : constant := 16#40#;
   APB2ENR_OFFSET_ADDRESS    : constant := 16#44#;
   AHB1LPENR_OFFSET_ADDRESS  : constant := 16#50#;
   AHB2LPENR_OFFSET_ADDRESS  : constant := 16#54#;
   AHB3LPENR_OFFSET_ADDRESS  : constant := 16#58#;
   APB1LPENR_OFFSET_ADDRESS  : constant := 16#60#;
   APB2LPENR_OFFSET_ADDRESS  : constant := 16#64#;
   BDCR_OFFSET_ADDRESS       : constant := 16#70#;
   CSR_OFFSET_ADDRESS        : constant := 16#74#;
   SSCGR_OFFSET_ADDRESS      : constant := 16#80#;
   PLLI2SCFGR_OFFSET_ADDRESS : constant := 16#84#;


   ---------------
   -- REGISTERS --
   ---------------

   --
   -- Clock control register
   --

   -- Register type
   type CR_register is record
      PLLI2SRDY : Unsigned_1;
      PLLI2SON  : Unsigned_1;
      PLLRDY    : Unsigned_1;
      PLLON     : Unsigned_1;
      CSSON     : Unsigned_1;
      HSEBYP    : Unsigned_1;
      HSERDY    : Unsigned_1;
      HSEON     : Unsigned_1;
      HSICAL    : Unsigned_8;
      HSITRIM   : Unsigned_5;
      HSIRDY    : Unsigned_1;
      HSION     : Unsigned_1;
   end record;

   -- Hardware representation
   for CR_register use record
      PLLI2SRDY at 0 range 27 .. 27;
      PLLI2SON  at 0 range 26 .. 26;
      PLLRDY    at 0 range 25 .. 25;
      PLLON     at 0 range 24 .. 24;
      CSSON     at 0 range 19 .. 19;
      HSEBYP    at 0 range 18 .. 18;
      HSERDY    at 0 range 17 .. 17;
      HSEON     at 0 range 16 .. 16;
      HSICAL    at 0 range 8 .. 15;
      HSITRIM   at 0 range 3 .. 7;
      HSIRDY    at 0 range 1 .. 1;
      HSION     at 0 range 0 .. 0;
   end record;


   --
   -- PLL configuration register
   --

   -- Register type
   type PLLCFGR_register is record
      PLLQ   : Unsigned_4;
      PLLSRC : Unsigned_1;
      PLLP   : Unsigned_1;
      PLLN   : Unsigned_9;
      PLLM   : Unsigned_6;
   end record;

   -- Hardware representation
   for PLLCFGR_register use record
      PLLQ   at 0 range 24 .. 27;
      PLLSRC at 0 range 22 .. 22;
      PLLP   at 0 range 16 .. 17;
      PLLN   at 0 range 6 .. 14;
      PLLM   at 0 range 0 .. 5;
   end record;


   --
   -- Clock configuration register
   --

   -- Register type
   type CFGR_register is record
      MCO2    : Unsigned_2;
      MCO2PRE : Unsigned_3;
      MCO1PRE : Unsigned_3;
      I2SSCR  : Unsigned_1;
      MCO1    : Unsigned_2;
      RTCPRE  : Unsigned_5;
      PPRE2   : Unsigned_3;
      PPRE1   : Unsigned_3;
      HPRE    : Unsigned_4;
      SWS     : Unsigned_2;
      SW      : Unsigned_2;
   end record;

   -- Hardware representation
   for CFGR_register use record
      MCO2    at 0 range 30 .. 31;
      MCO2PRE at 0 range 27 .. 29;
      MCO1PRE at 0 range 24 .. 26;
      I2SSCR  at 0 range 23 .. 23;
      MCO1    at 0 range 21 .. 22;
      RTCPRE  at 0 range 16 .. 20;
      PPRE2   at 0 range 13 .. 15;
      PPRE1   at 0 range 10 .. 12;
      HPRE    at 0 range 4 .. 7;
      SWS     at 0 range 2 .. 3;
      SW      at 0 range 0 .. 1;
   end record;


   --
   -- Clock interrupt register
   --

   -- Register type
   type CIR_register is record
      CSSC        : Unsigned_1;
      PLLI2SRDYC  : Unsigned_1;
      PLLRDYC     : Unsigned_1;
      HSERDYC     : Unsigned_1;
      HSIRDYC     : Unsigned_1;
      LSERDYC     : Unsigned_1;
      LSIRDYC     : Unsigned_1;
      PLLI2SRDYIE : Unsigned_1;
      PLLRDYIE    : Unsigned_1;
      HSERDYIE    : Unsigned_1;
      HSIRDYIE    : Unsigned_1;
      LSERDYIE    : Unsigned_1;
      LSIRDYIE    : Unsigned_1;
      CSSF        : Unsigned_1;
      PLLI2SRDYF  : Unsigned_1;
      PLLRDYF     : Unsigned_1;
      HSERDYF     : Unsigned_1;
      HSIRDYF     : Unsigned_1;
      LSERDYF     : Unsigned_1;
      LSIRDYF     : Unsigned_1;
   end record;

   -- Hardware representation
   for CIR_register use record
      CSSC        at 0 range 23 .. 23;
      PLLI2SRDYC  at 0 range 21 .. 21;
      PLLRDYC     at 0 range 20 .. 20;
      HSERDYC     at 0 range 19 .. 19;
      HSIRDYC     at 0 range 18 .. 18;
      LSERDYC     at 0 range 17 .. 17;
      LSIRDYC     at 0 range 16 .. 16;
      PLLI2SRDYIE at 0 range 13 .. 13;
      PLLRDYIE    at 0 range 12 .. 12;
      HSERDYIE    at 0 range 11 .. 11;
      HSIRDYIE    at 0 range 10 .. 10;
      LSERDYIE    at 0 range 9 .. 9;
      LSIRDYIE    at 0 range 8 .. 8;
      CSSF        at 0 range 7 .. 7;
      PLLI2SRDYF  at 0 range 5 .. 5;
      PLLRDYF     at 0 range 4 .. 4;
      HSERDYF     at 0 range 3 .. 3;
      HSIRDYF     at 0 range 2 .. 2;
      LSERDYF     at 0 range 1 .. 1;
      LSIRDYF     at 0 range 0 .. 0;
   end record;


   --
   -- AHB1 peripheral reset register
   --

   -- Register type
   type AHB1RSTR_register is record
      OTGHSRST  : Unsigned_1;
      ETHMACRST : Unsigned_1;
      DMA2RST   : Unsigned_1;
      DMA1RST   : Unsigned_1;
      CRCRST    : Unsigned_1;
      GPIOIRST  : Unsigned_1;
      GPIOHRST  : Unsigned_1;
      GPIOGRST  : Unsigned_1;
      GPIOFRST  : Unsigned_1;
      GPIOERST  : Unsigned_1;
      GPIODRST  : Unsigned_1;
      GPIOCRST  : Unsigned_1;
      GPIOBRST  : Unsigned_1;
      GPIOARST  : Unsigned_1;
   end record;

   -- Hardware representation
   for AHB1RSTR_register use record
      OTGHSRST  at 0 range 29 .. 29;
      ETHMACRST at 0 range 25 .. 25;
      DMA2RST   at 0 range 22 .. 22;
      DMA1RST   at 0 range 21 .. 21;
      CRCRST    at 0 range 12 .. 12;
      GPIOIRST  at 0 range 8 .. 8;
      GPIOHRST  at 0 range 7 .. 7;
      GPIOGRST  at 0 range 6 .. 6;
      GPIOFRST  at 0 range 5 .. 5;
      GPIOERST  at 0 range 4 .. 4;
      GPIODRST  at 0 range 3 .. 3;
      GPIOCRST  at 0 range 2 .. 2;
      GPIOBRST  at 0 range 1 .. 1;
      GPIOARST  at 0 range 0 .. 0;
   end record;


   --
   -- AHB2 peripheral reset register
   --

   -- Register type
   type AHB2RSTR_register is record
      OTGFSRST : Unsigned_1;
      RNGRST   : Unsigned_1;
      HASHRST  : Unsigned_1;
      CRYPRST  : Unsigned_1;
      DCMIRST  : Unsigned_1;
   end record;

   -- Hardware representation
   for AHB2RSTR_register use record
      OTGFSRST at 0 range 7 .. 7;
      RNGRST   at 0 range 6 .. 6;
      HASHRST  at 0 range 5 .. 5;
      CRYPRST  at 0 range 4 .. 4;
      DCMIRST  at 0 range 0 .. 0;
   end record;


   --
   -- AHB3 peripheral reset register
   --

   -- Register type
   type AHB3RSTR_register is record
      FSMCRST : Unsigned_1;
   end record;

   -- Hardware representation
   for AHB3RSTR_register use record
      FSMCRST at 0 range 0 .. 0;
   end record;


   --
   -- APB1 peripheral reset register
   --

   -- Register type
   type APB1RSTR_register is record
      DACRST   : Unsigned_1;
      PWRRST   : Unsigned_1;
      CAN2RST  : Unsigned_1;
      CAN1RST  : Unsigned_1;
      I2C3RST  : Unsigned_1;
      I2C2RST  : Unsigned_1;
      I2C1RST  : Unsigned_1;
      UART5RST : Unsigned_1;
      UART4RST : Unsigned_1;
      UART3RST : Unsigned_1;
      UART2RST : Unsigned_1;
      SPI3RST  : Unsigned_1;
      SPI2RST  : Unsigned_1;
      WWDGRST  : Unsigned_1;
      TIM14RST : Unsigned_1;
      TIM13RST : Unsigned_1;
      TIM12RST : Unsigned_1;
      TIM7RST  : Unsigned_1;
      TIM6RST  : Unsigned_1;
      TIM5RST  : Unsigned_1;
      TIM4RST  : Unsigned_1;
      TIM3RST  : Unsigned_1;
      TIM2RST  : Unsigned_1;
   end record;

   -- Hardware representation
   for APB1RSTR_register use record
      DACRST   at 0 range 29 .. 29;
      PWRRST   at 0 range 28 .. 28;
      CAN2RST  at 0 range 26 .. 26;
      CAN1RST  at 0 range 25 .. 25;
      I2C3RST  at 0 range 23 .. 23;
      I2C2RST  at 0 range 22 .. 22;
      I2C1RST  at 0 range 21 .. 21;
      UART5RST at 0 range 20 .. 20;
      UART4RST at 0 range 19 .. 19;
      UART3RST at 0 range 18 .. 18;
      UART2RST at 0 range 17 .. 17;
      SPI3RST  at 0 range 15 .. 15;
      SPI2RST  at 0 range 14 .. 14;
      WWDGRST  at 0 range 11 .. 11;
      TIM14RST at 0 range 8 .. 8;
      TIM13RST at 0 range 7 .. 7;
      TIM12RST at 0 range 6 .. 6;
      TIM7RST  at 0 range 5 .. 5;
      TIM6RST  at 0 range 4 .. 4;
      TIM5RST  at 0 range 3 .. 3;
      TIM4RST  at 0 range 2 .. 2;
      TIM3RST  at 0 range 1 .. 1;
      TIM2RST  at 0 range 0 .. 0;
   end record;


   --
   -- APB2 peripheral reset register
   --

   -- Register type
   type APB2RSTR_register is record
      TIM11     : Unsigned_1;
      TIM10     : Unsigned_1;
      TIM9      : Unsigned_1;
      SYSCFGRST : Unsigned_1;
      SPI1RST   : Unsigned_1;
      SDIORST   : Unsigned_1;
      ADCRST    : Unsigned_1;
      USART6RST : Unsigned_1;
      USART1RST : Unsigned_1;
      TIM8RST   : Unsigned_1;
      TIM1RST   : Unsigned_1;
   end record;

   -- Hardware representation
   for APB2RSTR_register use record
      TIM11     at 0 range 18 .. 18;
      TIM10     at 0 range 17 .. 17;
      TIM9      at 0 range 16 .. 16;
      SYSCFGRST at 0 range 14 .. 14;
      SPI1RST   at 0 range 12 .. 12;
      SDIORST   at 0 range 11 .. 11;
      ADCRST    at 0 range 8 .. 8;
      USART6RST at 0 range 5 .. 5;
      USART1RST at 0 range 4 .. 4;
      TIM8RST   at 0 range 1 .. 1;
      TIM1RST   at 0 range 0 .. 0;
   end record;


   --
   -- AHB1 peripheral clock enable register
   --

   -- Register type
   type AHB1ENR_register is record
      OTGHSULPIEN  : Unsigned_1;
      OTGHSEN      : Unsigned_1;
      ETHMACPTPEN  : Unsigned_1;
      ETHMACRXEN   : Unsigned_1;
      ETHMACTXEN   : Unsigned_1;
      ETHMACEN     : Unsigned_1;
      DMA2EN       : Unsigned_1;
      DMA1EN       : Unsigned_1;
      CCMDATARAMEN : Unsigned_1;
      BKPSRAMEN    : Unsigned_1;
      CRCEN        : Unsigned_1;
      GPIOIEN      : Unsigned_1;
      GPIOHEN      : Unsigned_1;
      GPIOGEN      : Unsigned_1;
      GPIOFEN      : Unsigned_1;
      GPIOEEN      : Unsigned_1;
      GPIODEN      : Unsigned_1;
      GPIOCEN      : Unsigned_1;
      GPIOBEN      : Unsigned_1;
      GPIOAEN      : Unsigned_1;
   end record;

   -- Hardware representation
   for AHB1ENR_register use record
      OTGHSULPIEN  at 0 range 30 .. 30;
      OTGHSEN      at 0 range 29 .. 29;
      ETHMACPTPEN  at 0 range 28 .. 28;
      ETHMACRXEN   at 0 range 27 .. 27;
      ETHMACTXEN   at 0 range 26 .. 26;
      ETHMACEN     at 0 range 25 .. 25;
      DMA2EN       at 0 range 22 .. 22;
      DMA1EN       at 0 range 21 .. 21;
      CCMDATARAMEN at 0 range 20 .. 20;
      BKPSRAMEN    at 0 range 18 .. 18;
      CRCEN        at 0 range 12 .. 12;
      GPIOIEN      at 0 range 8 .. 8;
      GPIOHEN      at 0 range 7 .. 7;
      GPIOGEN      at 0 range 6 .. 6;
      GPIOFEN      at 0 range 5 .. 5;
      GPIOEEN      at 0 range 4 .. 4;
      GPIODEN      at 0 range 3 .. 3;
      GPIOCEN      at 0 range 2 .. 2;
      GPIOBEN      at 0 range 1 .. 1;
      GPIOAEN      at 0 range 0 .. 0;
   end record;


   --
   -- AHB2 peripheral clock enable register
   --

   -- Register type
   type AHB2ENR_register is record
      OTGFSEN : Unsigned_1;
      RNGEN   : Unsigned_1;
      HASHEN  : Unsigned_1;
      CRYP    : Unsigned_1;
      DCMI    : Unsigned_1;
   end record;

   -- Hardware representation
   for AHB2ENR_register use record
      OTGFSEN at 0 range 7 .. 7;
      RNGEN   at 0 range 6 .. 6;
      HASHEN  at 0 range 5 .. 5;
      CRYP    at 0 range 4 .. 4;
      DCMI    at 0 range 0 .. 0;
   end record;


   --
   -- AHB3 peripheral clock enable register
   --

   -- Register type
   type AHB3ENR_register is record
      FSMCEN : Unsigned_1;
   end record;

   -- Hardware representation
   for AHB3ENR_register use record
      FSMCEN at 0 range 0 .. 0;
   end record;


   --
   -- APB1 peripheral clock enable register
   --

   -- Register type
   type APB1ENR_register is record
      DACEN    : Unsigned_1;
      PWREN    : Unsigned_1;
      CAN2EN   : Unsigned_1;
      CAN1EN   : Unsigned_1;
      I2C3EN   : Unsigned_1;
      I2C2EN   : Unsigned_1;
      I2C1EN   : Unsigned_1;
      UART5EN  : Unsigned_1;
      UART4EN  : Unsigned_1;
      USART3EN : Unsigned_1;
      USART2EN : Unsigned_1;
      SPI3EN   : Unsigned_1;
      SPI2EN   : Unsigned_1;
      WWDGEN   : Unsigned_1;
      TIM14EN  : Unsigned_1;
      TIM13EN  : Unsigned_1;
      TIM12EN  : Unsigned_1;
      TIM7EN   : Unsigned_1;
      TIM6EN   : Unsigned_1;
      TIM5EN   : Unsigned_1;
      TIM4EN   : Unsigned_1;
      TIM3EN   : Unsigned_1;
      TIM2EN   : Unsigned_1;
   end record;

   -- Hardware representation
   for APB1ENR_register use record
      DACEN    at 0 range 29 .. 29;
      PWREN    at 0 range 28 .. 28;
      CAN2EN   at 0 range 26 .. 26;
      CAN1EN   at 0 range 25 .. 25;
      I2C3EN   at 0 range 23 .. 23;
      I2C2EN   at 0 range 22 .. 22;
      I2C1EN   at 0 range 21 .. 21;
      UART5EN  at 0 range 20 .. 20;
      UART4EN  at 0 range 19 .. 19;
      USART3EN at 0 range 18 .. 18;
      USART2EN at 0 range 17 .. 17;
      SPI3EN   at 0 range 15 .. 15;
      SPI2EN   at 0 range 14 .. 14;
      WWDGEN   at 0 range 11 .. 11;
      TIM14EN  at 0 range 8 .. 8;
      TIM13EN  at 0 range 7 .. 7;
      TIM12EN  at 0 range 6 .. 6;
      TIM7EN   at 0 range 5 .. 5;
      TIM6EN   at 0 range 4 .. 4;
      TIM5EN   at 0 range 3 .. 3;
      TIM4EN   at 0 range 2 .. 2;
      TIM3EN   at 0 range 1 .. 1;
      TIM2EN   at 0 range 0 .. 0;
   end record;


   --
   -- APB2 peripheral clock enable register
   --

   -- Register type
   type APB2ENR_register is record
      TIM11EN  : Unsigned_1;
      TIM10EN  : Unsigned_1;
      TIM9EN   : Unsigned_1;
      SYSCFGEN : Unsigned_1;
      SPI1EN   : Unsigned_1;
      SDIOEN   : Unsigned_1;
      ADC3EN   : Unsigned_1;
      ADC2EN   : Unsigned_1;
      ADC1EN   : Unsigned_1;
      USART6EN : Unsigned_1;
      USART1EN : Unsigned_1;
      TIM8EN   : Unsigned_1;
      TIM1EN   : Unsigned_1;
   end record;

   -- Hardware representation
   for APB2ENR_register use record
      TIM11EN  at 0 range 18 .. 18;
      TIM10EN  at 0 range 17 .. 17;
      TIM9EN   at 0 range 16 .. 16;
      SYSCFGEN at 0 range 14 .. 14;
      SPI1EN   at 0 range 12 .. 12;
      SDIOEN   at 0 range 11 .. 11;
      ADC3EN   at 0 range 10 .. 10;
      ADC2EN   at 0 range 9 .. 9;
      ADC1EN   at 0 range 8 .. 8;
      USART6EN at 0 range 5 .. 5;
      USART1EN at 0 range 4 .. 4;
      TIM8EN   at 0 range 1 .. 1;
      TIM1EN   at 0 range 0 .. 0;
   end record;


   --
   -- AHB1 peripheral clock enable in low power mode register
   --

   -- Register type
   type AHB1LPENR_register is record
      OTGHSULPILPEN : Unsigned_1;
      OTGHSLPEN     : Unsigned_1;
      ETHPTPLPEN    : Unsigned_1;
      ETHRXLPEN     : Unsigned_1;
      ETHTXLPEN     : Unsigned_1;
      ETHMACLPEN    : Unsigned_1;
      DMA2LPEN      : Unsigned_1;
      DMA1LPEN      : Unsigned_1;
      BKPSRAMLPEN   : Unsigned_1;
      SRAM2LPEN     : Unsigned_1;
      SRAM1LPEN     : Unsigned_1;
      FLITFLPEN     : Unsigned_1;
      CRCLPEN       : Unsigned_1;
      GPIOILPEN     : Unsigned_1;
      GPIOHLPEN     : Unsigned_1;
      GPIOGLPEN     : Unsigned_1;
      GPIOFLPEN     : Unsigned_1;
      GPIOELPEN     : Unsigned_1;
      GPIODLPEN     : Unsigned_1;
      GPIOCLPEN     : Unsigned_1;
      GPIOBLPEN     : Unsigned_1;
      GPIOALPEN     : Unsigned_1;
   end record;

   -- Hardware representation
   for AHB1LPENR_register use record
      OTGHSULPILPEN at 0 range 30 .. 30;
      OTGHSLPEN     at 0 range 29 .. 29;
      ETHPTPLPEN    at 0 range 28 .. 28;
      ETHRXLPEN     at 0 range 27 .. 27;
      ETHTXLPEN     at 0 range 26 .. 26;
      ETHMACLPEN    at 0 range 25 .. 25;
      DMA2LPEN      at 0 range 22 .. 22;
      DMA1LPEN      at 0 range 21 .. 21;
      BKPSRAMLPEN   at 0 range 18 .. 18;
      SRAM2LPEN     at 0 range 17 .. 17;
      SRAM1LPEN     at 0 range 16 .. 16;
      FLITFLPEN     at 0 range 15 .. 15;
      CRCLPEN       at 0 range 12 .. 12;
      GPIOILPEN     at 0 range 8 .. 8;
      GPIOHLPEN     at 0 range 7 .. 7;
      GPIOGLPEN     at 0 range 6 .. 6;
      GPIOFLPEN     at 0 range 5 .. 5;
      GPIOELPEN     at 0 range 4 .. 4;
      GPIODLPEN     at 0 range 3 .. 3;
      GPIOCLPEN     at 0 range 2 .. 2;
      GPIOBLPEN     at 0 range 1 .. 1;
      GPIOALPEN     at 0 range 0 .. 0;
   end record;


   --
   -- AHB2 peripheral clock enable in low power mode register
   --

   -- Register type
   type AHB2LPENR_register is record
      OTGFSLPEN : Unsigned_1;
      RNGLPEN   : Unsigned_1;
      HASHLPEN  : Unsigned_1;
      CRYPLPEN  : Unsigned_1;
      DCMILPEN  : Unsigned_1;
   end record;

   -- Hardware representation
   for AHB2LPENR_register use record
      OTGFSLPEN at 0 range 7 .. 7;
      RNGLPEN   at 0 range 6 .. 6;
      HASHLPEN  at 0 range 5 .. 5;
      CRYPLPEN  at 0 range 4 .. 4;
      DCMILPEN  at 0 range 0 .. 0;
   end record;


   --
   -- AHB3 peripheral clock enable in low power mode register
   --

   -- Register type
   type AHB3LPENR_register is record
      FSMCLPEN : Unsigned_1;
   end record;

   -- Hardware representation
   for AHB3LPENR_register use record
      FSMCLPEN at 0 range 0 .. 0;
   end record;


   --
   -- APB1 peripheral clock enable in low power mode register
   --

   -- Register type
   type APB1LPENR_register is record
      DACLPEN    : Unsigned_1;
      PWRLPEN    : Unsigned_1;
      CAN2LPEN   : Unsigned_1;
      CAN1LPEN   : Unsigned_1;
      I2C3LPEN   : Unsigned_1;
      I2C2LPEN   : Unsigned_1;
      I2C1LPEN   : Unsigned_1;
      UART5LPEN  : Unsigned_1;
      UART4LPEN  : Unsigned_1;
      USART3LPEN : Unsigned_1;
      USART2LPEN : Unsigned_1;
      SPI3LPEN   : Unsigned_1;
      SPI2LPEN   : Unsigned_1;
      WWDGLPEN   : Unsigned_1;
      TIM14LPEN  : Unsigned_1;
      TIM13LPEN  : Unsigned_1;
      TIM12LPEN  : Unsigned_1;
      TIM7LPEN   : Unsigned_1;
      TIM6LPEN   : Unsigned_1;
      TIM5LPEN   : Unsigned_1;
      TIM4LPEN   : Unsigned_1;
      TIM3LPEN   : Unsigned_1;
      TIM2LPEN   : Unsigned_1;
   end record;

   -- Hardware representation
   for APB1LPENR_register use record
      DACLPEN    at 0 range 29 .. 29;
      PWRLPEN    at 0 range 28 .. 28;
      CAN2LPEN   at 0 range 26 .. 26;
      CAN1LPEN   at 0 range 25 .. 25;
      I2C3LPEN   at 0 range 23 .. 23;
      I2C2LPEN   at 0 range 22 .. 22;
      I2C1LPEN   at 0 range 21 .. 21;
      UART5LPEN  at 0 range 20 .. 20;
      UART4LPEN  at 0 range 19 .. 19;
      USART3LPEN at 0 range 18 .. 18;
      USART2LPEN at 0 range 17 .. 17;
      SPI3LPEN   at 0 range 15 .. 15;
      SPI2LPEN   at 0 range 14 .. 14;
      WWDGLPEN   at 0 range 11 .. 11;
      TIM14LPEN  at 0 range 8 .. 8;
      TIM13LPEN  at 0 range 7 .. 7;
      TIM12LPEN  at 0 range 6 .. 6;
      TIM7LPEN   at 0 range 5 .. 5;
      TIM6LPEN   at 0 range 4 .. 4;
      TIM5LPEN   at 0 range 3 .. 3;
      TIM4LPEN   at 0 range 2 .. 2;
      TIM3LPEN   at 0 range 1 .. 1;
      TIM2LPEN   at 0 range 0 .. 0;
   end record;


   --
   -- APB2 peripheral clock enable in low power mode register
   --

   -- Register type
   type APB2LPENR_register is record
      TIM11LPEN  : Unsigned_1;
      TIM10LPEN  : Unsigned_1;
      TIM9LPEN   : Unsigned_1;
      SYSCFGLPEN : Unsigned_1;
      SPI1LPEN   : Unsigned_1;
      SDIOLPEN   : Unsigned_1;
      ADC3LPEN   : Unsigned_1;
      ADC2LPEN   : Unsigned_1;
      ADC1LPEN   : Unsigned_1;
      USART6LPEN : Unsigned_1;
      USART1LPEN : Unsigned_1;
      TIM8LPEN   : Unsigned_1;
      TIM1LPEN   : Unsigned_1;
   end record;

   -- Hardware representation
   for APB2LPENR_register use record
      TIM11LPEN  at 0 range 18 .. 18;
      TIM10LPEN  at 0 range 17 .. 17;
      TIM9LPEN   at 0 range 16 .. 16;
      SYSCFGLPEN at 0 range 14 .. 14;
      SPI1LPEN   at 0 range 12 .. 12;
      SDIOLPEN   at 0 range 11 .. 11;
      ADC3LPEN   at 0 range 10 .. 10;
      ADC2LPEN   at 0 range 9 .. 9;
      ADC1LPEN   at 0 range 8 .. 8;
      USART6LPEN at 0 range 5 .. 5;
      USART1LPEN at 0 range 4 .. 4;
      TIM8LPEN   at 0 range 1 .. 1;
      TIM1LPEN   at 0 range 0 .. 0;
   end record;


   --
   -- Backup domain control register
   --

   -- Register type
   type BDCR_register is record
      BDRST  : Unsigned_1;
      TRCEN  : Unsigned_1;
      RTCSEL : Unsigned_2;
      LSEBYP : Unsigned_1;
      LSERDY : Unsigned_1;
      LSEON  : Unsigned_1;
   end record;

   -- Hardware representation
   for BDCR_register use record
      BDRST  at 0 range 16 .. 16;
      TRCEN  at 0 range 15 .. 15;
      RTCSEL at 0 range 8 .. 9;
      LSEBYP at 0 range 2 .. 2;
      LSERDY at 0 range 1 .. 1;
      LSEON  at 0 range 0 .. 0;
   end record;


   --
   -- Clock control & status register
   --

   -- Register type
   type CSR_register is record
      LPWRRSTF : Unsigned_1;
      WWDGRSTF : Unsigned_1;
      IWDGRSTF : Unsigned_1;
      SFTRSTF  : Unsigned_1;
      PORRSTF  : Unsigned_1;
      PINRSTF  : Unsigned_1;
      BORRSTF  : Unsigned_1;
      RMVF     : Unsigned_1;
      LSIRDY   : Unsigned_1;
      LSION    : Unsigned_1;
   end record;

   -- Hardware representation
   for CSR_register use record
      LPWRRSTF at 0 range 31 .. 31;
      WWDGRSTF at 0 range 30 .. 30;
      IWDGRSTF at 0 range 29 .. 29;
      SFTRSTF  at 0 range 28 .. 28;
      PORRSTF  at 0 range 27 .. 27;
      PINRSTF  at 0 range 26 .. 26;
      BORRSTF  at 0 range 25 .. 25;
      RMVF     at 0 range 24 .. 24;
      LSIRDY   at 0 range 1 .. 1;
      LSION    at 0 range 0 .. 0;
   end record;


   --
   -- Spread spectrum clock generation register
   --

   -- Register type
   type SSCGR_register is record
      SSCGEN    : Unsigned_1;
      SPREADSEL : Unsigned_1;
      INCSTEP   : Unsigned_15;
      MODPER    : Unsigned_13;
   end record;

   -- Hardware representation
   for SSCGR_register use record
      SSCGEN    at 0 range 31 .. 31;
      SPREADSEL at 0 range 30 .. 30;
      INCSTEP   at 0 range 13 .. 27;
      MODPER    at 0 range 0 .. 12;
   end record;


   --
   -- PLLI2S configuration register
   --

   -- Register type
   type PLLI2SCFGR_register is record
      PLLI2SR : Unsigned_3;
      PLLI2SN : Unsigned_9;
   end record;

   -- Hardware representation
   for PLLI2SCFGR_register use record
      PLLI2SR at 0 range 28 .. 30;
      PLLI2SN at 0 range 6 .. 14;
   end record;


   ------------------
   -- REGISTER MAP --
   ------------------

   -- Register type
   type RCC_Register_Map is record
      CR         : CR_register;
      PLLCFGR    : PLLCFGR_register;
      CFGR       : CFGR_register;
      CIR        : CIR_register;
      AHB1RSTR   : AHB1RSTR_register;
      AHB2RSTR   : AHB2RSTR_register;
      AHB3RSTR   : AHB3RSTR_register;
      APB1RSTR   : APB1RSTR_register;
      APB2RSTR   : APB2RSTR_register;
      AHB1ENR    : AHB1ENR_register;
      AHB2ENR    : AHB2ENR_register;
      AHB3ENR    : AHB3ENR_register;
      APB1ENR    : APB1ENR_register;
      APB2ENR    : APB2ENR_register;
      AHB1LPENR  : AHB1LPENR_register;
      AHB2LPENR  : AHB2LPENR_register;
      AHB3LPENR  : AHB3LPENR_register;
      APB1LPENR  : APB1LPENR_register;
      APB2LPENR  : APB2LPENR_register;
      BDCR       : BDCR_register;
      CSR        : CSR_register;
      SSCGR      : SSCGR_register;
      PLLI2SCFGR : PLLI2SCFGR_register;
   end record;

   -- Hardware representation
   for RCC_Register_Map use record
      CR         at CR_OFFSET_ADDRESS         range 0 .. 27;
      PLLCFGR    at PLLCFGR_OFFSET_ADDRESS    range 0 .. 27;
      CFGR       at CFGR_OFFSET_ADDRESS       range 0 .. 31;
      CIR        at CIR_OFFSET_ADDRESS        range 0 .. 23;
      AHB1RSTR   at AHB1RSTR_OFFSET_ADDRESS   range 0 .. 29;
      AHB2RSTR   at AHB2RSTR_OFFSET_ADDRESS   range 0 .. 7;
      AHB3RSTR   at AHB3RSTR_OFFSET_ADDRESS   range 0 .. 1;
      APB1RSTR   at APB1RSTR_OFFSET_ADDRESS   range 0 .. 29;
      APB2RSTR   at APB2RSTR_OFFSET_ADDRESS   range 0 .. 18;
      AHB1ENR    at AHB1ENR_OFFSET_ADDRESS    range 0 .. 30;
      AHB2ENR    at AHB2ENR_OFFSET_ADDRESS    range 0 .. 7;
      AHB3ENR    at AHB3ENR_OFFSET_ADDRESS    range 0 .. 1;
      APB1ENR    at APB1ENR_OFFSET_ADDRESS    range 0 .. 29;
      APB2ENR    at APB2ENR_OFFSET_ADDRESS    range 0 .. 18;
      AHB1LPENR  at AHB1LPENR_OFFSET_ADDRESS  range 0 .. 30;
      AHB2LPENR  at AHB2LPENR_OFFSET_ADDRESS  range 0 .. 7;
      AHB3LPENR  at AHB3LPENR_OFFSET_ADDRESS  range 0 .. 1;
      APB1LPENR  at APB1LPENR_OFFSET_ADDRESS  range 0 .. 29;
      APB2LPENR  at APB2LPENR_OFFSET_ADDRESS  range 0 .. 18;
      BDCR       at BDCR_OFFSET_ADDRESS       range 0 .. 16;
      CSR        at CSR_OFFSET_ADDRESS        range 0 .. 31;
      SSCGR      at SSCGR_OFFSET_ADDRESS      range 0 .. 31;
      PLLI2SCFGR at PLLI2SCFGR_OFFSET_ADDRESS range 0 .. 30;
   end record;


   -----------------------------
   -- HARDWARE REPRESENTATION --
   -----------------------------

   RCC : RCC_Register_Map
      with Volatile, Address => System'To_Address (RCC_BASE_ADDRESS);

end STM32F4.RCC;