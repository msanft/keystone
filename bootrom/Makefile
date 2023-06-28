march ?= rv64imafdc
mabi ?= lp64
CC ?= riscv64-unknown-elf-gcc
OBJCOPY ?= riscv64-unknown-elf-objcopy

CFLAGS = \
	-march=$(march) -mcmodel=medany -mabi=$(mabi) \
	-nostdlib -nostartfiles -fno-common -std=c99 \
	-static \
	-fPIC \
	-O0 -Wall
# O0 needs to be here to prevent the compiler from optimizing the
# jitter entropy source

O ?=.

# ^ consider taking out -g -Og and putting in -O2

bootloaders=\
	$(O)/bootrom.elf \
	$(O)/bootrom.bin

.PHONY: all
all: $(bootloaders)

.PHONY: clean
clean:
	rm -f $(bootloaders)

bootrom_sources = \
	./bootloader.S \
	./bootloader.c \
	./ed25519/*.c \
	./sha3/*.c \
	./jent/*.c


%.elf: $(bootrom_sources) bootloader.lds
	$(CC) $(CFLAGS) -I./ -L . -T bootloader.lds -o $@ $(bootrom_sources)

%.bin: %.elf
	$(OBJCOPY) binary --only-section=.text $< $@;
