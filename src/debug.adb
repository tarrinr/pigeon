------------------------
-- DEBUG PACKAGE BODY --
------------------------

package body DEBUG is


   ----------------
   -- PROCEDURES --
   ----------------

   -- Output debug message to USART console
   procedure debug_message (message : string) is
   begin
      for i in 1 .. message'LENGTH loop
         USART(USART_PORT).DR.DR := Character'POS(message (i));
         while USART(USART_PORT).SR.TXE = 0 loop
            null;
         end loop;
      end loop;
   end debug_message;

   procedure DOUT (message : string) is
   begin
      pragma debug (debug_message (message));
   end;

   procedure debug_init is
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

      -- Enable USART peripheral clock
      case USART_PORT is
         when 1 =>
            RCC.APB2ENR.USART1EN := 1;
         when 2 =>
            RCC.APB1ENR.USART2EN := 1;
         when 3 =>
            RCC.APB1ENR.USART3EN := 1;
         when 4 =>
            RCC.APB1ENR.UART4EN  := 1;
         when 5 =>
            RCC.APB1ENR.UART5EN  := 1;
         when 6 =>
            RCC.APB2ENR.USART6EN := 1;
      end case;


      --
      -- Configure GPIO
      --

      -- Set mode of GPIO
      GPIO(GPIO_PORT).MODER(USART_TX_PIN) := GPIO_MODE;
      GPIO(GPIO_PORT).MODER(USART_RX_PIN) := GPIO_MODE;

      -- Set output type of GPIO
      GPIO(GPIO_PORT).OTYPER(USART_TX_PIN) := GPIO_OTYPE;
      GPIO(GPIO_PORT).OTYPER(USART_RX_PIN) := GPIO_OTYPE;

      -- Set output speed of GPIO
      GPIO(GPIO_PORT).OSPEEDR(USART_TX_PIN) := GPIO_OSPEED;
      GPIO(GPIO_PORT).OSPEEDR(USART_RX_PIN) := GPIO_OSPEED;

      -- Set pull up/down of GPIO
      GPIO(GPIO_PORT).PUPDR(USART_TX_PIN) := GPIO_PUPD;
      GPIO(GPIO_PORT).PUPDR(USART_RX_PIN) := GPIO_PUPD;

      -- Set alternate function of GPIO
      pragma Warnings (Off, "*condition is always*");
      if USART_TX_PIN > 7 then
         GPIO(GPIO_PORT).AFRH(USART_TX_PIN - 8) := GPIO_AFRX;
      else
         GPIO(GPIO_PORT).AFRL(USART_TX_PIN) := GPIO_AFRX;
      end if;

      if USART_RX_PIN > 7 then
         GPIO(GPIO_PORT).AFRH(USART_RX_PIN - 8) := GPIO_AFRX;
      else 
         GPIO(GPIO_PORT).AFRL(USART_RX_PIN) := GPIO_AFRX;
      end if;
      pragma Warnings (On, "*condition is always*");


      --
      -- Configure USART
      --

      -- Enable USART
      USART(USART_PORT).CR1.UE := 1;

      -- Set world length of USART
      USART(USART_PORT).CR1.M := USART_WORD_LENGTH;

      -- Set stop bits of USART
      USART(USART_PORT).CR2.STOP := USART_STOP_BITS;

      -- Set baud rate of USART
      USART(USART_PORT).BRR.DIV_MANTISSA := USART_BR_MAN;
      USART(USART_PORT).BRR.DIV_FRACTION := USART_BR_FRAC;

      -- Set transmitter enable of USART
      USART(USART_PORT).CR1.TE := 1;

   end debug_init;   

end DEBUG;