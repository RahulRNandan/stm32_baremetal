#include "includes/stm32f4xx.h"

#define GPIOC_BASE (0x40020800)    // Base address for GPIOC
#define RCC_BASE (0x40023800)       // Base address for RCC
#define RCC_AHB1ENR (*(volatile unsigned int*)(RCC_BASE + 0x30))  // RCC AHB1 peripheral clock enable register
#define GPIO_MODER  (*(volatile unsigned int*)(GPIOC_BASE + 0x00))  // GPIO mode register
#define GPIO_ODR    (*(volatile unsigned int*)(GPIOC_BASE + 0x14))  // GPIO output data register

void delay(int count) {
    while (count--) {
        for (int i = 0; i < 10000; i++) {}  // Simple delay
    }
}

int main(void) {
    // Enable clock for GPIOC
    RCC_AHB1ENR |= (1 << 2); // Set bit 2 to enable GPIOC clock

    // Configure PC13 as general-purpose output
    GPIO_MODER &= ~(0x3 << (13 * 2));  // Clear mode bits for PC13 (bit 26 and 27)
    GPIO_MODER |= (0x1 << (13 * 2));   // Set PC13 as output (0x01 -> general purpose output mode)

    while (1) {
        GPIO_ODR ^= (1 << 13);  // Toggle the LED connected to PC13
        delay(500);  // Simple delay between toggles
    }

    return 0;  // Program should never reach this point in embedded systems
}
