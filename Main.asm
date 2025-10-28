; Author: Jacob Baker
; Date: 2025-10-28

; 10 SYS (2304)

*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $32, $33, $30, $34, $29, $00, $00, $00


PRINTLINE=$AB1E
*=$0900

PROGRAM_START

        ;Step 0: Swaps colors of background and the Ready text also added name/date at top
        LDA $D021
        STA $0286
        LDA $D020
        STA $D021

        ; Step 1: print the letters in Input String
        LDX #0

PRINT_LOOP
        LDA INPUT_STRING,X
        sta CURRENT_LETTER
        lda #0
        sta CURRENT_LETTER+1
        stx X_TEMP
        lda #<CURRENT_LETTER
        ldy #>CURRENT_LETTER
        jsr PRINTLINE

        ; Step 2: Made output PRINTLINE to screen if charcter was a letter
        lda CURRENT_LETTER
        cmp #"a"
        bmi not_letter
        cmp #"z"
        bpl not_letter
        lda #<IS_LETTER_MESSAGE
        ldy #>IS_LETTER_MESSAGE
        jsr PRINTLINE
        jmp end_of_process_printline
not_letter

        ; Step 3: Made output PRINTLINE to screen if charcter was a number
        lda CURRENT_LETTER
        cmp #"0"
        bmi not_number
        cmp #"9"
        bpl not_number
        lda #<IS_NUMBER_MESSAGE
        ldy #>IS_NUMBER_MESSAGE
        jsr PRINTLINE
        jmp end_of_process_printline
not_number


end_of_process_printline
        ldx X_TEMP
        inx
        cpx #15
        bne PRINT_LOOP

PROGRAM_END
        rts

; variable used to print the current letter
CURRENT_LETTER
        byte 00 
        byte 00 

; use this to save a copy of x (the loop counter)
X_TEMP
        byte 00

; our input string to process
INPUT_STRING 
        text ""@553mb1y r0cks!"

; message to print when a letter is encountered
IS_LETTER_MESSAGE
        text " <-- is a letter"
        byte 13, 00

; message to print when a number is encountered
IS_NUMBER_MESSAGE
        text " <-- is a number"
        byte 13, 00

; message to print when something other than a letter/number is encountered
IS_SOMETHING_ELSE_MESSAGE
        text " <-- is some other character"
        byte 13, 00