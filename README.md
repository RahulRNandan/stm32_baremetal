# STM32 Bare-Metal Project

This repository contains the source code for a simple bare-metal project running on an STM32 microcontroller (STM32F407xx). The project includes basic configurations such as linker scripts, startup files, and the blink LED example. This project does not use any high-level frameworks like HAL or SPL.

## Project Structure

```
├── blinky.bin               # Compiled binary file
├── blinky.elf               # Compiled ELF file
├── includes/                # Includes for CMSIS and STM32 headers (excluded from repository)
├── main.c                   # Main program file (blinking LED)
├── Makefile                 # Makefile to compile the project
├── obj/                     # Compiled object files (build directory)
├── README.md                # Project documentation
├── startup.c                # Startup code for STM32F407xx
├── stm32.ld                 # Linker script for STM32F407xx
└── stm32f4_headers/         # STM32F4xx-specific headers (excluded from repository)
```

## Requirements

To run or build this project, the following are required:

- **GNU ARM Toolchain:** For cross-compiling the project. You can install it by following the instructions [here](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm).
- **Make:** To run the `Makefile` to build the project.

## How to Build

1. **Clone the repository:**

    ```bash
    git clone https://github.com/RahulRNandan/stm32_baremetal.git
    cd stm32_baremetal
    ```

2. **Install the required toolchain:**

    Make sure the GNU ARM toolchain is installed and accessible via your system's `PATH`.

3. **Download and include necessary CMSIS and STM32F4 header files:**

    To keep the repository lightweight, the `includes` and `stm32f4_headers` directories are excluded. You need to manually download the following:

    - **CMSIS headers:** Download the CMSIS-Core files from [ARM CMSIS GitHub](https://github.com/ARM-software/CMSIS_5).
    - **STM32F4 headers:** Download the STM32F4xx header files from [STM32CubeF4 repository](https://github.com/STMicroelectronics/STM32CubeF4).

    After downloading, place them in the following directories:

    ```
    includes/             # Place CMSIS core headers here
    stm32f4_headers/      # Place STM32F4xx headers here
    ```

    Example structure:

    ```
    includes/cmsis-header-stm32-master/stm32f4xx/Include
    includes/CMSIS/Include
    stm32f4_headers/
    ```

4. **Build the project:**

    Run the following command to build the project:

    ```bash
    make
    ```

    This will generate the `blinky.elf` and `blinky.bin` files in the root directory.

5. **Flashing to the microcontroller:**

    Use a tool like `st-flash` (for ST-Link) to flash the generated binary (`blinky.bin`) onto your STM32 board:

    ```bash
    st-flash write blinky.bin 0x8000000
    ```

## Customization

- **Modify `main.c`** for your own bare-metal application code. The current `main.c` is a simple LED blink example.
- **Edit `stm32.ld`** to modify memory regions for your specific STM32 microcontroller.
- **Add peripheral initialization:** You can expand this project by adding bare-metal code to configure peripherals such as UART, GPIO, and timers.

## .gitignore

Since the CMSIS and STM32 header files are large, they are excluded from this repository to reduce its size. These files must be manually included as described above.

```
# Ignored directories and files
includes/
stm32f4_headers/
*.o
*.bin
*.elf
obj/
```

## License

This project is released under the MIT License. See the [LICENSE](LICENSE) file for more details.

Key Points in README.md:
- **Clear structure:** Provides the user with a visual project structure.
- **Instructions for necessary files:** CMSIS and STM32F4 header files must be downloaded separately.
- **Build and flash process:** Simple instructions for building and flashing the project to the STM32 board.
- **Customization:** Encourages users to modify the main code and linker scripts as needed.
