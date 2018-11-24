; An LC-3 assembly language program that counts the number of 1's stored in R5
; and stores the result into R4.
; Carl Argabright
; Ethan Cheatham
; TCSS 371 - Fall 2018

            .ORIG x3000             ; Start at x3000 and Assume some value exists in R5
            AND R4, R4, #0          ; AND R4 with 0 to start our 1's counter at zero
            LD R1, BIT_COUNT        ; Load the number of bits to be checked into R1
            AND R0, R0, #0          ; Initialize R0 with 0 and let it be our bitmask
            ADD R0, R0, #1          ; Let our bitmask begin with 1
LOOP        BRz DONE                ; Loop while there are still bits to check
            AND R6, R5, R0          ; AND R5 with our Bitmask in R0, store the unused result in R6
            BRz SHIFT_LEFT          ; If the result is zero we don't count it, only a shift_left is neccesary
            ADD R4, R4, #1          ; Increment our 1's counter by 1
SHIFT_LEFT  ADD R0, R0, R0          ; ADD the bitmask to itself to bitshift the curret value to the left
            ADD R1, R1, #-1         ; Decrement the number of bits remaining by 1
            BRnzp LOOP              ; Perform our loop so see if we have checked all of our bits


; Variables used
DONE        HALT                    ; End of program, stop executing instructions
BIT_COUNT   .FILL #16               ; Number of bits to be checked
            .END