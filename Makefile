# Target binary file name
TARGET = blinky

# Directories
SRC_DIR = .                                       # Current directory for source files
OBJ_DIR = ./obj                                   # Directory for object files
INCLUDE_DIRS = -I$(SRC_DIR)/stm32f4_headers \     # Path to STM32 HAL and driver headers
               -I$(SRC_DIR)/includes             # Path to CMSIS headers

# Compiler and Linker
CC = arm-none-eabi-gcc                            # Cross-compiler for ARM Cortex-M series
LD = arm-none-eabi-ld                             # Linker for ARM Cortex-M series
OBJCOPY = arm-none-eabi-objcopy                   # Tool to convert ELF to binary format

# Compiler Flags
CFLAGS = -mcpu=cortex-m4 -mthumb -O0 -g3 -Wall \  # Options for Cortex-M4, debugging, and warnings
         -fdata-sections -ffunction-sections \    # Optimization to remove unused code
         $(INCLUDE_DIRS)                          # Include directories for header files

# Linker Flags
LDFLAGS = -T stm32.ld                             # Linker script for memory mapping

# Source files (all .c files in the current directory and stm32f4_headers)
SRCS = $(wildcard $(SRC_DIR)/*.c) $(wildcard $(SRC_DIR)/stm32f4_headers/*.c)

# Object files corresponding to source files
OBJS = $(SRCS:.c=.o)

# Build rules
# This rule generates the final binary file (.bin)
all: $(TARGET).bin

# This rule creates the ELF file from object files
$(TARGET).elf: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@ $(LDFLAGS)     # Compile and link object files into an ELF file

# This rule converts ELF file to a binary file
$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@                    # Convert ELF to binary format

# Rule to compile C files into object files (.o)
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@                   # Compile each source file into an object file

# Clean rule to remove generated object and binary files
clean:
	rm -f $(OBJ_DIR)/*.o $(TARGET).elf $(TARGET).bin  # Remove object files, ELF, and binary

# Debug rule to enable debugging information and recompile the project
debug:
	$(CC) -g $(CFLAGS) $(SRCS) -o $(TARGET).elf    # Compile the project with debugging enabled
