;Guessing Game
;Ethan Cheatham



;if you encounter non digit character, output invalid input.
;stored value of 6
;ask to guess between 0 and 9
;invalid input still countes as guess, just output invalid input
; uiser inputs and hits enter
;asciu code x0A causes the cursor to go to the nextline NEWLINE
;Assume that the user gets it right within 9 guesses.

;R0 - IN/OUT
;R1 - Used to validate input
;R2 - Stores number 6, number to guess
;R4 - Stores raw input

;R6 - Stores result of adding 6 + two's complement of a guess.

;R3 - Keep track of loop count. 9 to 1.


;check if 9 guesses occured


.ORIG x3000 ;Start program at x3000

ADD R2, R2, #6 ; Store 6 to R2
AND R3, R3, #0 ; Set R3 to 0 for checking number of guesses.

BRnzp START



START:
	;Increment guesses
	ADD R3, R3, #1
	
	; Print guess message
	LEA R0, GUESS 
	PUTS 

	; Get input character
	
	GETC
	
	
	AND R4, R4, #0
	ADD R4, R4, R0 ; Add R0 to R4	

	OUT	


	LEA R0, NEWLINE ; New line after guess
	PUTS
	



	
	LD R6, ASCII2 	
	ADD R6, R6, R4

	NOT R6, R6;
	ADD R6, R6, #1




	;Check input
	LD R1, BOTTOM
	AND R5, R5, #0
	ADD R5, R5, R4
	NOT R5, R4;
	ADD R5, R5 #1

	ADD R1, R1, R5

	BRp INVALIDINPUT

	LD R1, TOP
	AND R5, R5, #0
	ADD R5, R5, R4
	NOT R5, R4;
	ADD R5, R5 #1

	ADD R1, R1, R5

	BRn INVALIDINPUT




	



	ADD R6, R2, R6
	
	
	
	BRp SMALLER
	BRz CORRECT
	BRn GREATER
	
AGAIN:

	;Check if nine guesses have occured.
	AND R5, R5, #0
	ADD R5, R5, #9

	;2'S complement
	NOT R5, R5
	ADD R5, R5, #1

	ADD R5, R5, R3

	BRz CORRECT
	

	

	;Increment guesses
	ADD R3, R3, #1
	
	; Print guess message
	LEA R0, GUESSAGAIN
	PUTS 

	; Get input character
	
	GETC
	
	
	AND R4, R4, #0
	ADD R4, R4, R0 ; Add R0 to R4	

	OUT	


	LEA R0, NEWLINE ; New line after guess
	PUTS
	



	
	LD R6, ASCII2 	
	ADD R6, R6, R4

	NOT R6, R6;
	ADD R6, R6, #1



	;Check input
	LD R1, BOTTOM
	AND R5, R5, #0
	ADD R5, R5, R4
	NOT R5, R4;
	ADD R5, R5 #1

	ADD R1, R1, R5

	BRp INVALIDINPUT

	LD R1, TOP
	AND R5, R5, #0
	ADD R5, R5, R4
	NOT R5, R4;
	ADD R5, R5 #1

	ADD R1, R1, R5

	BRn INVALIDINPUT



	

	



	ADD R6, R2, R6
	
	
	
	BRp SMALLER
	BRz CORRECT
	BRn GREATER
	


GREATER:
	LEA R0, BIG
	PUTS
	BRnzp AGAIN	

SMALLER:
	LEA R0, SMALL
	PUTS
	BRnzp AGAIN

	
INVALIDINPUT:
	LEA R0, INVALID
	PUTS
	BRnzp AGAIN
	

CORRECT:
	LEA R0, CORRECT1
	PUTS
	LD R0, ASCII
	ADD R0, R0, R3
	OUT
	LEA R0, CORRECT2
	PUTS
	HALT


GUESS .STRINGZ "Guess a number: "
GUESSAGAIN .STRINGZ "Guess again: " 
SMALL .STRINGZ "Too Small.\n"
BIG .STRINGZ "Too big.\n"
INVALID .STRINGZ "Invalid input.\n"
CORRECT1 .STRINGZ "Correct! You took "
CORRECT2 .STRINGZ " guesses."
NEWLINE .STRINGZ "\n"
ASCII .FILL x0030
ASCII2 .FILL xFFD0
BOTTOM .FILL x0030
TOP .FILL x0039


HALT
.END ;End of program