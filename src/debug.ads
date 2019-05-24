with STM32F4;        use STM32F4;
with STM32F4.RCCL;   use STM32F4.RCCL;
with STM32F4.GPIOL;  use STM32F4.GPIOL;
with STM32F4.USARTL; use STM32F4.USARTL;

--------------------------------
-- DEBUG PACKAGE SPECIFICATION--
--------------------------------

package DEBUG is


   -------------
   -- GLOBALS --
   -------------

   -- GPIO configuration for USART
   GPIO_PORT   : constant GPIO_Ports := B;
   GPIO_MODE   : constant := 2#10#;   -- Alternate function mode
   GPIO_OTYPE  : constant := 2#00#;   -- Push-pull
   GPIO_OSPEED : constant := 2#00#;   -- Low speed
   GPIO_PUPD   : constant := 2#00#;   -- No pull up/down
   GPIO_AFRX   : constant := 2#0111#; -- USART1

   -- USART configuration
   USART_PORT        : constant USART_Ports := 1;
   USART_TX_PIN      : constant := 6;
   USART_RX_PIN      : constant := 7;
   USART_WORD_LENGTH : constant := 16#00#; -- 8 data bits
   USART_STOP_BITS   : constant := 16#00#; -- 1 stop bit
   USART_BR_MAN      : constant := 16#68#; -- 104 for 9600 bps
   USART_BR_FRAC     : constant := 16#03#; -- 0.1875 for 9600 bps


   ----------------
   -- PROCEDURES --
   ----------------

   -- Initialize debug interface
   procedure debug_init;

   -- Output debug message to USART console
   procedure DOUT (message : string);

end DEBUG;