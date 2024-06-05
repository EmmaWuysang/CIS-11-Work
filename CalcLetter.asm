.ORIG x3000
; Determine the letter grade based on the score
	; Load the score into R1
	LEA R4,SCORE_1      ; Load the address of the score

	; Clear registers
	AND R2,R2,x0       ; R2 will be used as a counter
	AND R3,R3,x0       ; R3 will be used for comparison
	AND R4,R4,x0       ; R4 HOLDS INPUT VALIDATION
	AND R6,R6,x0       ; R6 for subtraction

	;INPUT VALIDATION
	ADD R4,R1,#-15		; Subtracting by -101, input validation (0-100)
	ADD R4,R1,#-15		; Offset by 15
	ADD R4,R1,#-15
	ADD R4,R1,#-15
	ADD R4,R1,#-15
	ADD R4,R1,#-15
	ADD R4,R1,#-11		; Offset by 11
	BRp ERROR		; Branches if result was over 100
	AND R4,R4,x0		; Clear Register 4
	LEA R4,SCORE_1      	; Reload the address of the score
	LD R6,ENINTY		; Load 89 onto register 6
	NOT R6,R6
	ADD R6,R6,#1		; 2S COMPLEMENT OF R6
	ADD R1,R4,R6		; Score - 89 (checks for A), moved R4 to R1
	BRp GRADE_A		; branch if grade was an A

	AND R1,R1,x0		; Clear R1
	LEA R1,SCORE_1      	; Reload the address of the score
	LD R6,SVNIN		; Load 79 onto register 6
	NOT R6,R6
	ADD R6,R6,#1		; 2S COMPLEMENT OF R6
	ADD R1,R4,R6		; Score - 79 (checks for B)
	BRp GRADE_B		; branch if grade was an B

	AND R1,R1,x0
	LD R6,SXTNY		; Load 69 onto register 6
	NOT R6,R6
	ADD R6,R6,#1		; 2S COMPLEMENT OF R6
	ADD R1,R4,R6		; Score - 69 (checks for C)
	BRp GRADE_C		; branch if grade was an C
	BRn GRADE_D		; branch if negative, grade in D
	
; Directly accessing array

GRADE_F	LEA R0, GRADES		; Load the base address of the GRADES array
	PUTS			; Print the string, F
	HALT			; Stops program

GRADE_D	LEA R0, GRADES		; Load the base address of the GRADES array
	ADD R0, R0, #10		; Offset to the score D
	PUTS			; Print the string
	HALT			; Stops program

GRADE_C LEA R0, GRADES		; Load the base address of the GRADES array
	ADD R0, R0, #10		; Offset to the score C
	ADD R0, R0, #10
	PUTS			; Print the string
	HALT			; Stops program

GRADE_B	LEA R0, GRADES		; Load the base address of the GRADES array
	ADD R0, R0, #15		; Offset to the score B
	ADD R0, R0, #15
	PUTS			; Print the string
	HALT			; Stops program

GRADE_A	LEA R0, GRADES		; Load the base address of the GRADES array
	ADD R0, R0, #15		; Offset to the score A
	ADD R0, R0, #15
	ADD R0, R0, #10
	PUTS			; Print the string
	HALT			; Stops program

ERROR
	LEA R0, OFFVAL	; Loads off value
	PUTS		; Tells user input was invalid
	HALT		; Stops program


; Data Section
SCORE_1 .FILL x65     ; Change this value to test different scores
GRADES  .STRINGZ "Scored: F"  ; (0-59)
        .STRINGZ "Scored: D"  ; (60-69)
        .STRINGZ "Scored: C"  ; (70-79)
        .STRINGZ "Scored: B"  ; (80-89)
        .STRINGZ "Scored: A"  ; (90-100)

SXTNY	.FILL x69	; Third range interval - C
SVNIN	.FILL x79	; First range interval - B
ENINTY	.FILL x89	; Range of each interval - A


HOLD	.FILL x000A
OFFVAL	.STRINGZ "INPUT WAS OUT OF BOUNDS."

.END

