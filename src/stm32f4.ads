package STM32F4 with Pure is

    type Unsigned_1  is mod 2 ** 1;
    type Unsigned_2  is mod 2 ** 2;
    type Unsigned_3  is mod 2 ** 3;
    type Unsigned_4  is mod 2 ** 4;
    type Unsigned_5  is mod 2 ** 5;
    type Unsigned_6  is mod 2 ** 6;
    type Unsigned_7  is mod 2 ** 7;
    type Unsigned_8  is mod 2 ** 8;
    type Unsigned_9  is mod 2 ** 9;
    type Unsigned_10 is mod 2 ** 10;
    type Unsigned_11 is mod 2 ** 11;
    type Unsigned_12 is mod 2 ** 12;
    type Unsigned_13 is mod 2 ** 13;
    type Unsigned_14 is mod 2 ** 14;
    type Unsigned_15 is mod 2 ** 15;
    type Unsigned_16 is mod 2 ** 16;

    type Unsigned_16_1 is array (0 .. 15) of Unsigned_1 with Pack;
    type Unsigned_16_2 is array (0 .. 15) of Unsigned_2 with Pack;
    type Unsigned_8_4  is array (0 .. 7)  of Unsigned_4 with Pack;


end STM32F4;