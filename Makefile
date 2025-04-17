CC = i686 - elf - gcc
CFLAGS = -ffreestanding - O2 - Wall - Wextra - m32
LDFLAGS = -T linker.ld - ffreestanding - O2 - nostdlib

SRC = kernel.cpp
OBJ = $(SRC:.cpp =.o)
KERNEL_BIN = kernel.bin

all: $(KERNEL_BIN)

$(KERNEL_BIN): $(OBJ)
	$(CC) $(LDFLAGS) - o $@ $^

%.o: %.cpp
	$(CC) $(CFLAGS) - c - o $@ $<

clean:
	rm - f $(OBJ) $(KERNEL_BIN)

run: $(KERNEL_BIN)
    qemu - system - amd64 - drive format = raw,file =$(KERNEL_BIN)

