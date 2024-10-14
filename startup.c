// Forward declaration of the main function
extern int main(void);  // Declare main as an external function

// Stack definition: 256 unsigned long entries, which gives a 1 KB stack
__attribute__((section(".stack"))) unsigned long stack[256];

// Minimal reset handler that directly calls main()
void Reset_Handler(void) {
    main();  // Call main after reset
    while (1);  // Infinite loop if main returns (just in case)
}

// Vector table, including the stack pointer and the reset handler
__attribute__((section(".vectors"))) void (*vectors[])(void) = {
    (void (*)(void))((unsigned long)stack + sizeof(stack)),  // Initial stack pointer value
    Reset_Handler  // Reset vector (entry point)
};
