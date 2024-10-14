/* Entry point of the program (Reset_Handler) */
ENTRY(Reset_Handler)

/* Memory regions based on STM32F4 */
    MEMORY
{
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 1M       /* Flash memory */
    SRAM1 (xrw) : ORIGIN = 0x20000000, LENGTH = 112K     /* SRAM1 */
    SRAM2 (xrw) : ORIGIN = 0x2001C000, LENGTH = 16K      /* SRAM2 */
}
    
/* Sections to place code and data in appropriate regions */
SECTIONS
{
    /* Place the vector table and program code in FLASH */
    .text : {
        KEEP(*(.isr_vector)) /* Keep the vector table at the start */
        *(.text*)            /* Place all .text sections (code) here */
    } > FLASH

    /* Initialized data section to be loaded into RAM */
    .data : {
        *(.data*)    /* Initialized data placed in RAM, copied from FLASH at startup */
    } > RAM AT > FLASH

    /* Uninitialized data (zero-initialized) placed in RAM */
    .bss : {
        *(.bss*)
    } > RAM

    /* Stack at the end of RAM */
    .stack (NOLOAD) : {
        . = ALIGN(8);
        _estack = .;        /* Define the top of the stack */
        *(.stack)
        . = ORIGIN(RAM) + LENGTH(RAM);
    } > RAM
}
