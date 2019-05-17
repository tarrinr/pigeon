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
   type CR is record
      PLLI2SRDY : mod 2 ** 1;
      PLLI2SON  : mod 2 ** 1;
      PLLRDY    : mod 2 ** 1;
      PLLON     : mod 2 ** 1;
      CSSON     : mod 2 ** 1;
      HSEBYP    : mod 2 ** 1;
      HSERDY    : mod 2 ** 1;
      HSEON     : mod 2 ** 1;
      HSICAL    : mod 2 ** 8;
      HSITRIM   : mod 2 ** 5;
      HSIRDY    : mod 2 ** 1;
      HSION     : mod 2 ** 1;
   end record;

   -- Hardware representation
   for CR use record
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
   type PLLCFGR is record
      PLLQ   : mod 2 ** 4;
      PLLSRC : mod 2 ** 2;
      PLLP   : mod 2 ** 1;
      PLLN   : mod 2 ** 9;
      PLLM   : mod 2 ** 6;
   end record;

   -- Hardware representation
   for PLLCFGR use record
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
   type CFGR is record
      MCO2    : mod 2 ** 2;
      MCO2PRE : mod 2 ** 3;
      MCO1PRE : mod 2 ** 3;
      I2SSCR  : mod 2 ** 1;
      MCO1    : mod 2 ** 2;
      RTCPRE  : mod 2 ** 5;
      PPRE2   : mod 2 ** 3;
      PPRE1   : mod 2 ** 3;
      HPRE    : mod 2 ** 4;
      SWS     : mod 2 ** 2;
      SW      : mod 2 ** 2;
   end record;

   -- Hardware representation
   for CFGR use record
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
   type CIR is record
      CSSC        : mod 2 ** 1;
      PLLI2SRDYC  : mod 2 ** 1;
      PLLRDYC     : mod 2 ** 1;
      HSERDYC     : mod 2 ** 1;
      HSIRDYC     : mod 2 ** 1;
      LSERDYC     : mod 2 ** 1;
      LSIRDYC     : mod 2 ** 1;
      PLLI2SRDYIE : mod 2 ** 1;
      PLLRDYIE    : mod 2 ** 1;
      HSERDYIE    : mod 2 ** 1;
      HSIRDYIE    : mod 2 ** 1;
      LSERDYIE    : mod 2 ** 1;
      LSIRDYIE    : mod 2 ** 1;
      CSSF        : mod 2 ** 1;
      PLLI2SRDYF  : mod 2 ** 1;
      PLLRDYF     : mod 2 ** 1;
      HSERDYF     : mod 2 ** 1;
      HSIRDYF     : mod 2 ** 1;
      LSERDYF     : mod 2 ** 1;
      LSIRDYF     : mod 2 ** 1;
   end record;

   -- Hardware representation
   for CIR use record
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
   type AHB1RSTR is record
      OTGHSRST  : mod 2 ** 1;
      ETHMACRST : mod 2 ** 1;
      DMA2RST   : mod 2 ** 1;
      DMA1RST   : mod 2 ** 1;
      CRCRST    : mod 2 ** 1;
      GPIOIRST  : mod 2 ** 1;
      GPIOHRST  : mod 2 ** 1;
      GPIOGRST  : mod 2 ** 1;
      GPIOFRST  : mod 2 ** 1;
      GPIOERST  : mod 2 ** 1;
      GPIODRST  : mod 2 ** 1;
      GPIOCRST  : mod 2 ** 1;
      GPIOBRST  : mod 2 ** 1;
      GPIOARST  : mod 2 ** 1;
   end record;

   -- Hardware representation
   for AHB1RSTR use record
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
   type AHB2RSTR is record
      OTGFSRST : mod 2 ** 1;
      RNGRST   : mod 2 ** 1;
      HASHRST  : mod 2 ** 1;
      CRYPRST  : mod 2 ** 1;
      DCMIRST  : mod 2 ** 1;
   end record;

   -- Hardware representation
   for AHB2RSTR use record
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
   type AHB3RSTR is record
      FSMCRST : mod 2 ** 1;
   end record;

   -- Hardware representation
   for AHB3RSTR use record
      FSMCRST at 0 range 0 .. 0;
   end record;


   --
   -- APB1 peripheral reset register
   --

   -- Register type
   type APB1RSTR is record
      DACRST   : mod 2 ** 1;
      PWRRST   : mod 2 ** 1;
      CAN2RST  : mod 2 ** 1;
      CAN1RST  : mod 2 ** 1;
      I2C3RST  : mod 2 ** 1;
      I2C2RST  : mod 2 ** 1;
      I2C1RST  : mod 2 ** 1;
      UART5RST : mod 2 ** 1;
      UART4RST : mod 2 ** 1;
      UART3RST : mod 2 ** 1;
      UART2RST : mod 2 ** 1;
      SPI3RST  : mod 2 ** 1;
      SPI2RST  : mod 2 ** 1;
      WWDGRST  : mod 2 ** 1;
      TIM14RST : mod 2 ** 1;
      TIM13RST : mod 2 ** 1;
      TIM12RST : mod 2 ** 1;
      TIM7RST  : mod 2 ** 1;
      TIM6RST  : mod 2 ** 1;
      TIM5RST  : mod 2 ** 1;
      TIM4RST  : mod 2 ** 1;
      TIM3RST  : mod 2 ** 1;
      TIM2RST  : mod 2 ** 1;
   end record;

   -- Hardware representation
   for APB1RSTR use record
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
   type APB2RSTR is record
      TIM11     : mod 2 ** 1;
      TIM10     : mod 2 ** 1;
      TIM9      : mod 2 ** 1;
      SYSCFGRST : mod 2 ** 1;
      SPI1RST   : mod 2 ** 1;
      SDIORST   : mod 2 ** 1;
      ADCRST    : mod 2 ** 1;
      USART6RST : mod 2 ** 1;
      USART1RST : mod 2 ** 1;
      TIM8RST   : mod 2 ** 1;
      TIM1RST   : mod 2 ** 1;
   end record;

   -- Hardware representation
   for APB2RSTR use record
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
   type AHB1ENR is record
      OTGHSULPIEN  : mod 2 ** 1;
      OTGHSEN      : mod 2 ** 1;
      ETHMACPTPEN  : mod 2 ** 1;
      ETHMACRXEN   : mod 2 ** 1;
      ETHMACTXEN   : mod 2 ** 1;
      ETHMACEN     : mod 2 ** 1;
      DMA2EN       : mod 2 ** 1;
      DMA1EN       : mod 2 ** 1;
      CCMDATARAMEN : mod 2 ** 1;
      BKPSRAMEN    : mod 2 ** 1;
      CRCEN        : mod 2 ** 1;
      GPIOIEN      : mod 2 ** 1;
      GPIOHEN      : mod 2 ** 1;
      GPIOGEN      : mod 2 ** 1;
      GPIOFEN      : mod 2 ** 1;
      GPIOEEN      : mod 2 ** 1;
      GPIODEN      : mod 2 ** 1;
      GPIOCEN      : mod 2 ** 1;
      GPIOBEN      : mod 2 ** 1;
      GPIOAEN      : mod 2 ** 1;
   end record;

   -- Hardware representation
   for AHB1ENR use record
      OTGHSULPIEN  at 30 range 30;
      OTGHSEN      at 29 range 29;
      ETHMACPTPEN  at 28 range 28;
      ETHMACRXEN   at 27 range 27;
      ETHMACTXEN   at 26 range 26;
      ETHMACEN     at 25 range 25;
      DMA2EN       at 22 range 22;
      DMA1EN       at 21 range 21;
      CCMDATARAMEN at 20 range 20;
      BKPSRAMEN    at 18 range 18;
      CRCEN        at 12 range 12;
      GPIOIEN      at 8 range 8;
      GPIOHEN      at 7 range 7;
      GPIOGEN      at 6 range 6;
      GPIOFEN      at 5 range 5;
      GPIOEEN      at 4 range 4;
      GPIODEN      at 3 range 3;
      GPIOCEN      at 2 range 2;
      GPIOBEN      at 1 range 1;
      GPIOAEN      at 0 range 0;
   end record;


   --
   -- AHB2 peripheral clock enable register
   --

   -- Register type
   type AHB2ENR is record
      OTGFSEN : mod 2 ** 1;
      RNGEN   : mod 2 ** 1;
      HASHEN  : mod 2 ** 1;
      CRYP    : mod 2 ** 1;
      DCMI    : mod 2 ** 1;
   end record;

   -- Hardware representation
   for AHB2ENR use record
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
   type AHB3ENR is record
      FSMCEN : mod 2 ** 1;
   end record;

   -- Hardware representation
   for AHB3ENR use record
      FSMCEN at 0 range 0 .. 0;
   end record;


   --
   -- APB1 peripheral clock enable register
   --

   -- Register type
   type APB1ENR is record
      DACEN    : mod 2 ** 1;
      PWREN    : mod 2 ** 1;
      CAN2EN   : mod 2 ** 1;
      CAN1EN   : mod 2 ** 1;
      I2C3EN   : mod 2 ** 1;
      I2C2EN   : mod 2 ** 1;
      I2C1EN   : mod 2 ** 1;
      UART5EN  : mod 2 ** 1;
      UART4EN  : mod 2 ** 1;
      USART3EN : mod 2 ** 1;
      USART2EN : mod 2 ** 1;
      SPI3EN   : mod 2 ** 1;
      SPI2EN   : mod 2 ** 1;
      WWDGEN   : mod 2 ** 1;
      TIM14EN  : mod 2 ** 1;
      TIM13EN  : mod 2 ** 1;
      TIM12EN  : mod 2 ** 1;
      TIM7EN   : mod 2 ** 1;
      TIM6EN   : mod 2 ** 1;
      TIM5EN   : mod 2 ** 1;
      TIM4EN   : mod 2 ** 1;
      TIM3EN   : mod 2 ** 1;
      TIM2EN   : mod 2 ** 1;
   end record;

   -- Hardware representation
   for APB1ENR use record
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
   type APB2ENR is record
      TIM11EN  : mod 2 ** 1;
      TIM10EN  : mod 2 ** 1;
      TIM9EN   : mod 2 ** 1;
      SYSCFGEN : mod 2 ** 1;
      SPI1EN   : mod 2 ** 1;
      SDIOEN   : mod 2 ** 1;
      ADC3EN   : mod 2 ** 1;
      ADC2EN   : mod 2 ** 1;
      ADC1EN   : mod 2 ** 1;
      USART6EN : mod 2 ** 1;
      USART1EN : mod 2 ** 1;
      TIM8EN   : mod 2 ** 1;
      TIM1EN   : mod 2 ** 1;
   end record;

   -- Hardware representation
   for APB2ENR use record
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
   type AHB1LPENR is record
      OTGHSULPILPEN : mod 2 ** 1;
      OTGHSLPEN     : mod 2 ** 1;
      ETHPTPLPEN    : mod 2 ** 1;
      ETHRXLPEN     : mod 2 ** 1;
      ETHTXLPEN     : mod 2 ** 1;
      ETHMACLPEN    : mod 2 ** 1;
      DMA2LPEN      : mod 2 ** 1;
      DMA1LPEN      : mod 2 ** 1;
      BKPSRAMLPEN   : mod 2 ** 1;
      SRAM2LPEN     : mod 2 ** 1;
      SRAM1LPEN     : mod 2 ** 1;
      FLITFLPEN     : mod 2 ** 1;
      CRCLPEN       : mod 2 ** 1;
      GPIOILPEN     : mod 2 ** 1;
      GPIOHLPEN     : mod 2 ** 1;
      GPIOGLPEN     : mod 2 ** 1;
      GPIOFLPEN     : mod 2 ** 1;
      GPIOELPEN     : mod 2 ** 1;
      GPIODLPEN     : mod 2 ** 1;
      GPIOCLPEN     : mod 2 ** 1;
      GPIOBLPEN     : mod 2 ** 1;
      GPIOALPEN     : mod 2 ** 1;
   end record;

   -- Hardware representation
   for AHB1LPENR use record
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
   type AHB2LPENR is record
      OTGFSLPEN : mod 2 ** 1;
      RNGLPEN   : mod 2 ** 1;
      HASHLPEN  : mod 2 ** 1;
      CRYPLPEN  : mod 2 ** 1;
      DCMILPEN  : mod 2 ** 1;
   end record;

   -- Hardware representation
   for AHB2LPENR use record
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
   type AHB3LPENR is record
      FSMCLPEN : mod 2 ** 1;
   end record;

   -- Hardware representation
   for AHB3LPENR use record
      FSMCLPEN at 0 range 0 .. 0;
   end record;


   --
   -- APB1 peripheral clock enable in low power mode register
   --

   -- Register type
   type APB1LPENR is record
      DACLPEN    : mod 2 ** 1;
      PWRLPEN    : mod 2 ** 1;
      CAN2LPEN   : mod 2 ** 1;
      CAN1LPEN   : mod 2 ** 1;
      I2C3LPEN   : mod 2 ** 1;
      I2C2LPEN   : mod 2 ** 1;
      I2C1LPEN   : mod 2 ** 1;
      UART5LPEN  : mod 2 ** 1;
      UART4LPEN  : mod 2 ** 1;
      USART3LPEN : mod 2 ** 1;
      USART2LPEN : mod 2 ** 1;
      SPI3LPEN   : mod 2 ** 1;
      SPI2LPEN   : mod 2 ** 1;
      WWDGLPEN   : mod 2 ** 1;
      TIM14LPEN  : mod 2 ** 1;
      TIM13LPEN  : mod 2 ** 1;
      TIM12LPEN  : mod 2 ** 1;
      TIM7LPEN   : mod 2 ** 1;
      TIM6LPEN   : mod 2 ** 1;
      TIM5LPEN   : mod 2 ** 1;
      TIM4LPEN   : mod 2 ** 1;
      TIM3LPEN   : mod 2 ** 1;
      TIM2LPEN   : mod 2 ** 1;
   end record;

   -- Hardware representation
   for APB1LPENR use record
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
   type APB2LPENR is record
      TIM11LPEN  : mod 2 ** 1;
      TIM10LPEN  : mod 2 ** 1;
      TIM9LPEN   : mod 2 ** 1;
      SYSCFGLPEN : mod 2 ** 1;
      SPI1LPEN   : mod 2 ** 1;
      SDIOLPEN   : mod 2 ** 1;
      ADC3LPEN   : mod 2 ** 1;
      ADC2LPEN   : mod 2 ** 1;
      ADC1LPEN   : mod 2 ** 1;
      USART6LPEN : mod 2 ** 1;
      USART1LPEN : mod 2 ** 1;
      TIM8LPEN   : mod 2 ** 1;
      TIM1LPEN   : mod 2 ** 1;
   end record;

   -- Hardware representation
   for APB2LPENR use record
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
   type BDCR is record
      BDRST  : mod 2 ** 1;
      TRCEN  : mod 2 ** 1;
      RTCSEL : mod 2 ** 2;
      LSEBYP : mod 2 ** 1;
      LSERDY : mod 2 ** 1;
      LSEON  : mod 2 ** 1;
   end record;

   -- Hardware representation
   for BDCR use record
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
   type CSR is record
      LPWRRSTF : mod 2 ** 1;
      WWDGRSTF : mod 2 ** 1;
      IWDGRSTF : mod 2 ** 1;
      SFTRSTF  : mod 2 ** 1;
      PORRSTF  : mod 2 ** 1;
      PINRSTF  : mod 2 ** 1;
      BORRSTF  : mod 2 ** 1;
      RMVF     : mod 2 ** 1;
      LSIRDY   : mod 2 ** 1;
      LSION    : mod 2 ** 1;
   end record;

   -- Hardware representation
   for CSR use record
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
   type SSCGR is record
      SSCGEN    : mod 2 ** 1;
      SPREADSEL : mod 2 ** 1;
      INCSTEP   : mod 2 ** 15;
      MODPER    : mod 2 ** 13;
   end record;

   -- Hardware representation
   for SSCGR use record
      SSCGEN    at 0 range 31 .. 31;
      SPREADSEL at 0 range 30 .. 30;
      INCSTEP   at 0 range 13 .. 27;
      MODPER    at 0 range 0 .. 12;
   end record;


   --
   -- PLLI2S configuration register
   --

   -- Register type
   type PLLI2SCFGR is record
      PLLI2SR : mod 2 ** 3;
      PLLI2SN : mod 2 ** 9;
   end record;

   -- Hardware representation
   for PLLI2SCFGR use record
      PLLI2SR at 0 range 28 .. 30;
      PLLI2SN at 0 range 6 .. 14;
   end record;


   ------------------
   -- REGISTER MAP --
   ------------------

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
      with Address => System'To_Address (RCC_Base_Address);

end STM32F4.RCC;