; -----------------------------------------------------------------------------
;|  Author: Zareeb                                                             |
;|  Cerritos College CIS-231 FizzBuzz Lab                                      |
; -----------------------------------------------------------------------------

include Irvine32.inc
.386
.model flat,stdcall
.stack 4096

ExitProcess proto,dwExitCode:dword

.data
    roundPrompt     byte "Enter number of rounds to play: ", 0
    number          dword ?
    i               dword ?
    Fizz            byte "Fizz", 0
    Buzz            byte "Buzz", 0
    FizzBuzz        byte "FizzBuzz", 0

.code

fizzbuzz_program PROC

    mov      edx, offset roundPrompt
    call     WriteString                ; Asks user how many rounds of FizzBuzz game to play
    call     ReadInt                    ; and stores the input in the eax register
    mov      number, eax                ; moves it to the number variable.
    mov      i, 0                       ; initializes i to zero

    loopThis:                           ; LOOP BODY
    inc      i                          ; increments i by 1 every time the loop is run
    mov      eax, number                ; moves the number of rounds entered by the user to the eax register
    cmp      i, eax                     ; and compares i and eax
    jg       endLoop                    ; If i is greater than the number, jumps to the terminating portion of the loop

    mov      eax, i                     ; and moves the counter to the eax register
    cdq
    ;  -----------------------------------------------------------------------------
    ; |Condition 1 - FizzBuzz if i % 15 == 0                                        |
    ;  -----------------------------------------------------------------------------


    mov      ecx, 0fh                   ; Moves 15 to the ecx register
    idiv     ecx                        ; performs division which stores the quotient in eax and remainder in edx
    cmp      edx, 0                     ; If condition is true, i.e., if remainder of
    je       C1                         ; previous division is zero, then jumps to C1

    ;  -----------------------------------------------------------------------------
    ; |Condition 2 - Fizz if i % 3 == 0                                             |
    ;  -----------------------------------------------------------------------------

    mov      eax, i                     ; Similar process as described above,
    cdq                                 ; in this case it checks if there is a remainder
    mov      ecx, 3                     ; if i is divided by 3
    idiv     ecx
    cmp      edx, 0
    je       C2                         ; Jumps to C2 if condition is true

    ;  -----------------------------------------------------------------------------
    ; |Condition 3 - Buzz if i % 5 == 0                                             |
    ;  -----------------------------------------------------------------------------

    mov      eax, i
    cdq
    mov      ecx, 5
    idiv     ecx
    cmp      edx, 0
    je       C3                         ; Jumps to C3 if condition is true
    jmp      C4                         ; if condition falls through, i.e., number is not perfectly divisible by 3, 5, or 15, then call C4

    C1:
    mov      edx, offset FizzBuzz
    call     WriteString
    call     CrLf
    jmp      loopThis                   ; Returns to start of the loop assuming i <= number

    C2:
    mov      edx, offset Fizz
    call     WriteString
    call     CrLf
    jmp      loopThis                   ; Returns to start of the loop assuming i <= number

    C3:
    mov      edx, offset Buzz
    call     WriteString
    call     CrLf
    jmp      loopThis                   ; Returns to start of the loop assuming i <= number

    C4:
    mov      eax, i                     ; Prints current value of i
    call     WriteDec
    call     CrLf
    jmp      loopThis                   ; Returns to start of the loop assuming i <= number

    endLoop:                            ; End of loop body
    call     CrLf
    call     DumpRegs                   ; Shows values of registers
    invoke   ExitProcess, 0

fizzbuzz_program ENDP


main PROC   

    call fizzbuzz_program               ; Invokes FizzBuzz program procedure
    invoke ExitProcess, 0               ; Terminates program

main ENDP

END
