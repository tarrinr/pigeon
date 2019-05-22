with STM32F4;       use STM32F4;
with STM32F4.GPIO;  use STM32F4.GPIO;
with STM32F4.USART; use STM32F4.USART;

----------
-- DOUT --
----------

procedure DOUT is

   -- GPIO configuration for USART1
   GPIO_PORT   : constant := B;
   GPIO_MODE   : constant := 2#10#;   -- Alternate function mode
   GPIO_OTYPE  : constant := 2#00#;   -- Push-pull
   GPIO_OSPEED : constant := 2#00#;   -- Low speed
   GPIO_PUPD   : constant := 2#00#;   -- No pull up/down
   GPIO_AFRL   : constant := 2#0111#; -- USART1

   -- USART1 configuration
   USART_PORT        : constant := 1;
   USART_TX_PIN      : constant := 6;
   USART_RX_PIN      : constant := 7;
   USART_WORD_LENGTH : constant := 16#00#; -- 8 data bits
   USART_STOP_BITS   : constant := 16#00#; -- 1 stop bit
   USART_BR_MAN      : constant := 16#68#; -- 104 for 9600 bps
   USART_BR_FRAC     : constant := 16#03#; -- 0.1875 for 9600 bps

begin


   --
   -- Configure clock
   --

   -- Enable GPIO port B peripheral clock
   RCC.AHB1ENR.GPIOBEN := 1;


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
   GPIO(GPIO_PORT).AFRLR(USART_TX_PIN) := GPIO_AFRL;
   GPIO(GPIO_PORT).AFRLR(USART_RX_PIN) := GPIO_AFRL;


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

end DOUT;