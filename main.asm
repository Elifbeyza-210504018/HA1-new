;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer (password ve hold u veya ile yaptı)
                                            ; in C> WDTCTL = WDTPW | WDTHOLD;

;-------------------------------------------------------------------------------
; Main loop here

;-------------------------------------------------------------------------------
init:

			bis.b	#01h, &P1DIR	       ;Set P1.0 (LED) as output
			bic.b   #01h, &P1OUT           ;configurate P1.0 as pull-down  (clear=0)
			bis.b   #01h, &P1REN           ;enable pull-down für P1.0       (set=1)


	        bis.b   #02h, &P1DIR            ;P1.1 wird als Buton zugewiesen (input =0)
			bis.b   #02h, &P1OUT            ;enable pull-up für P1.1
			bis.b   #02h, &P1REN            ;enable pull-up für P1.1


main:
			bit.b   #02h, &P1IN             ;check if P1.1 (button) pressed
            jnz     button_not_pressed      ;if button not pressed skip LED toggle

            xor.b	#01h, &P1OUT			;Toggle LED (LEDi tersledik)

button_not_pressed:
			jmp      main                   ;skip the loop




;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
