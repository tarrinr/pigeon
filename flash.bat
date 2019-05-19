@echo off

echo ### gprbuild ###
gprbuild

echo ### arm-eabi-objcopy ###
arm-eabi-objcopy -O binary obj/pigeon obj/pigeon.bin

echo ### st-flash ###
st-flash write obj/pigeon.bin 0x8000000