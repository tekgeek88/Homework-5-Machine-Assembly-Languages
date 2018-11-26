;Guessing Game
;Ethan Cheatham

;R0 - IN/OUT
;R1 - Used to validate input
;R2 - Stores number 6, number to guess
;R3 - Keep track of loop count.
;R4 - Stores raw input
;R5 - Temporary opreations.
;R6 - Stores result of adding 6 + two's complement of a guess.


.ORIG x3000 ; Start program at x3000

ADD R2, R2, #6 ; Store 6 to R2
AND R3, R3, #0 ; Set R3 to 0 for checking number of guesses.

BRnzp GUESSMSG


GUESSMSG:
	;Check if first guess (Guess count is zero)
	
	;Print Guess message
	ADD R3, R3, #0
	BRz FIRSTGUESS
	BRp ANOTHERGUESS
	HALT


FIRSTGUESS:
	;Print first guess message
	LEA R0, GUESS
	PUTS
	BRnzp LOOP

ANOTHERGUESS: 
	;Print another guess message
	LEA R0, GUESSAGAIN
	PUTS
	BRnzp LOOP


	
LOOP:
	;Check if nine guesses have occured.
	AND R5, R5, #0
	ADD R5, R5, #9

	NOT R5, R5 ; 2'S complement
	ADD R5, R5, #1

	ADD R5, R5, R3

	BRz CORRECT ; if number of guesses - 9 = 0, assume correct
	

	;Increment guesses
	ADD R3, R3, #1

	;Get input character
	GETC
	
	AND R4, R4, #0 
	ADD R4, R4, R0 ; Add R0 to R4	
	
	;Display input
	OUT	

	LEA R0, NEWLINE ; New line after guess character
	PUTS
	


	;Determine decimal value using negative ascii
	
	LD R6, ASCII2 	
	ADD R6, R6, R4

	NOT R6, R6;
	ADD R6, R6, #1



	;Check if input is in a valid range of accepted values

	;Check lower bound
	LD R1, BOTTOM
	AND R5, R5, #0
	ADD R5, R5, R4
	NOT R5, R4;
	ADD R5, R5 #1
	ADD R1, R1, R5
	BRp INVALIDINPUT

	;Check upper bound
	LD R1, TOP
	AND R5, R5, #0
	ADD R5, R5, R4
	NOT R5, R4;
	ADD R5, R5 #1
	ADD R1, R1, R5
	BRn INVALIDINPUT


	;Add 2's complement of guess and 6
	ADD R6, R2, R6
		
	;Determine if guess is correct

	BRp SMALLER
	BRz CORRECT
	BRn GREATER
	


GREATER:
	;Display that the guess is too big
	LEA R0, BIG
	PUTS
	BRnzp GUESSMSG

SMALLER:
	;Display that the guess is too small
	LEA R0, SMALL
	PUTS
	BRnzp GUESSMSG

	
INVALIDINPUT:
	;Display the input is invalid
	LEA R0, INVALID
	PUTS
	BRnzp GUESSMSG
	

CORRECT:
	;Display the guess is correct, stop program
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