;MARIO's Memory  
;Members:
;João Pedro Baratella Mattos
;Santigo Vera Martins
;Hugo Rubira Zanni
;Caique Martins Costa Xavier

jmp main

;stores the user's pressed key
pressedKey: var #1

;indicates if the card has been turned (facing up)
;game1
flag0: var #1
flag1: var #1
flag2: var #1
flag3: var #1
flag4: var #1
flag5: var #1
flag6: var #1
flag7: var #1
flag8: var #1
flag9: var #1

;game2
flag00: var #1
flag01: var #1
flag02: var #1
flag03: var #1
flag04: var #1
flag05: var #1
flag06: var #1
flag07: var #1
flag08: var #1
flag09: var #1

;game3
flag000: var #1
flag001: var #1
flag002: var #1
flag003: var #1
flag004: var #1
flag005: var #1
flag006: var #1
flag007: var #1
flag008: var #1
flag009: var #1

;indicates if the pair has been matched
;game1
match08: var #1
match17: var #1
match26: var #1
match35: var #1
match49: var #1

;game2
match06: var #1
match57: var #1
match29: var #1
match38: var #1
match14: var #1

;game3
match25: var #1
match37: var #1
match09: var #1
match14: var #1
match68: var #1

;player lifes
lifes: var #1
ScoreLifes: var #1

;total score (how many pairs were matched) -> scoreTotal == 5 (the player wins)
scoreTotal: var #1

main:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	loadn r0, #0
	store scoreTotal, r0
	
	loadn r0, #13 ;loading r0 with the ASCII code for enter
	
	call printinicioScreen

	;waiting untill the input is enter
	menuLoop:
		call getChar
		load r3, pressedKey
		cmp r3, r0
		jne menuLoop 
	
	call clearScreen

	loadn r2, #0
	loadn r1, #screen2line1 
	call printScreenOverlap
	
	;waiting untill the input is enter
	loopTutorial:
		call getChar
		load r3, pressedKey
		cmp r3, r0
		jne loopTutorial 

	call clearScreen
	call startGame1
	
	endGame:
	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	halt
	
	startGame1:
	;starting the game 1 --------------------------
	
	call resetVariables
    call printTitle
	call printAllFront
	call printToScreen
	call printLifes
	
	;showing the cards for a few seconds
	call longDelay
	
	;hiding the cards	
	call printAllBack

	loopGame:
		
		loadn r6, #1
		
		call getChar
		load r7, pressedKey
		call printFront
		call getChar
		load r7, pressedKey
		call printFront
		call longDelay
		call verifyMatch ;verifying if the two inputs form a match
		call printBack ;checking if the cards need to be printed backwards or not

		call printLifes
		
		
		;--------------------
		load r3, ScoreLifes
		loadn r4, #3
		cmp r3, r4
		jeq endMainlost1
		
		load r3, scoreTotal
		loadn r4, #5
		cmp r3, r4
		jeq endMain1
		;--------------------
		
		jmp loopGame
		
		rts
		
		endMain1:
		call clearScreen
		call printtelafinal_winTScreen ;printing the winner screen
		call playMGAgain1	;call this function, that's calls the second game
		rts
		endMainlost1:
		call clearScreen
		call printtela_fimTScreen ;printing the loser screen
		call playMGAgainlost1 ;call this function, that's calls the first game again
		rts
		
	
	
	playMGAgain1:
		push r0
		push r1
		push r2
		push r3
		push r4
			
		loadn r0, #121 ;loading r0 with the ASCII code for "y"
		call getChar
		load r3, pressedKey
		cmp r3, r0
		jne notplayMGAgain ;if the input is not "y" then check if it's "n"
			
		;if the input is "y" call the game loop
		call clearScreen
		;jmp for the second game
		jmp startGame2
			
		notplayMGAgain:
			loadn r0, #110 ;loading r0 with the ASCII code for "n"
			load r3, pressedKey
			cmp r3, r0
			jeq endGame ;if the input is "n" end the program
			call playMGAgain1 ;if the input is neither "y" nor "n" then check again
		
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		
		rts
			
	playMGAgainlost1:
		push r0
		push r1
		push r2
		push r3
		push r4
		
		loadn r0, #121 ;loading r0 with the ASCII code for "y"
		call getChar
		load r3, pressedKey
		cmp r3, r0
		jne notplayMGAgain ;if the input is not "y" then check if it's "n"
		
		;if the input is "y" call the game loop
		call clearScreen
		;jmp for the first game again
		jmp startGame1
			
		notplayMGAgain:
			loadn r0, #110 ;loading r0 with the ASCII code for "n"
			load r3, pressedKey
			cmp r3, r0
			jeq endGame ;if the input is "n" end the program
			call playMGAgain1 ;if the input is neither "y" nor "n" then check again
			
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
			
		rts
			
						
	startGame2:   ;GAME 2------------------------------------------------
	;starting the game--------------------------
	call resetVariables
    call printTitle
	call printAllFront2
	call printToScreen
	call printLifes
	
	;showing the cards for a few seconds
	call longDelay
	
	;hiding the cards	
	call printAllBack

	loopGame2:
		
		loadn r6, #1
		
		call getChar
		load r7, pressedKey
		call printFront2
		call getChar
		load r7, pressedKey
		call printFront2
		call longDelay
		call verifyMatch2 ;verifying if the two inputs form a match
		call printBack2 ;checking if the cards need to be printed backwards or not

		call printLifes
		
		;--------------------
		load r3, ScoreLifes
		loadn r4, #3
		cmp r3, r4
		jeq endMainlost2
		
		load r3, scoreTotal
		loadn r4, #5
		cmp r3, r4
		jeq endMain2
		;--------------------
		
		jmp loopGame2
		
		rts
		
		endMain2:
			call clearScreen
			call printtelafinal_winTScreen ;printing the winner screen
			call playMGAgain2;call this function, that's calls the third game 
			
			rts
			
			endMainlost2:
			call clearScreen
			call printtela_fimTScreen ;printing the loser screen
			call playMGAgainlost2;call this function, that's calls the second game again
			
			rts
		
		playMGAgain2:
			push r0
			push r1
			push r2
			push r3
			push r4
			
			loadn r0, #121 ;loading r0 with the ASCII code for "y"
			call getChar
			load r3, pressedKey
			cmp r3, r0
			jne notplayMGAgain2 ;if the input is not "y" then check if it's "n"
			
			;if the input is "y" call the game loop
			call clearScreen
			;jmp for the third game
			jmp startGame3
		
		notplayMGAgain2:
			loadn r0, #110 ;loading r0 with the ASCII code for "n"
			load r3, pressedKey
			cmp r3, r0
			jeq endGame ;if the input is "n" end the program
			
			call playMGAgain2 ;if the input is neither "y" nor "n" then check again
			
			pop r4
			pop r3
			pop r2
			pop r1
			pop r0
			
			rts
			
		playMGAgainlost2:
			push r0
			push r1
			push r2
			push r3
			push r4
			
			loadn r0, #121 ;loading r0 with the ASCII code for "y"
			call getChar
			load r3, pressedKey
			cmp r3, r0
			jne notplayMGAgain2 ;if the input is not "y" then check if it's "n"
			
			;if the input is "y" call the game loop
			call clearScreen
			;jmp for the second game again
			jmp startGame2
		
		notplayMGAgain:
			loadn r0, #110 ;loading r0 with the ASCII code for "n"
			load r3, pressedKey
			cmp r3, r0
			jeq endGame ;if the input is "n" end the program
			
			call playMGAgain2 ;if the input is neither "y" nor "n" then check again
			
			pop r4
			pop r3
			pop r2
			pop r1
			pop r0
			
			rts
		
		
		
		
	startGame3:   ;GAME 3------------------------------------------------
	;starting the game--------------------------
	call clearScreen
	call resetVariables
    call printTitle
	call printAllFront3
	call printToScreen
	call printLifes
	
	;showing the cards for a few seconds
	call longDelay
	
	;hiding the cards	
	call printAllBack

	loopGame3:
		
		loadn r6, #1
		
		call getChar
		load r7, pressedKey
		call printFront3
		call getChar
		load r7, pressedKey
		call printFront3
		call longDelay
		call verifyMatch3 ;verifying if the two inputs form a match
		call printBack3 ;checking if the cards need to be printed backwards or not

		call printLifes
		
		
		;--------------------
		load r3, ScoreLifes
		loadn r4, #3
		cmp r3, r4
		jeq endMainlost3
		
		load r3, scoreTotal
		loadn r4, #5
		cmp r3, r4
		jeq endMain3
		;--------------------
		
		jmp loopGame3
		
		rts
		
		endMain3:
		call clearScreen
		call printtelafinal_winTScreen ;printing the winner screen
		call playMGAgain3;call this function, that's calls the first game
		rts
		endMainlost3:
		call clearScreen
		call printtela_fimTScreen ;printing the loser screen
		call playMGAgainlost3;call this function, that's calls the third game again
		rts
		
		playMGAgain3:
			push r0
			push r1
			push r2
			push r3
			push r4
			
			loadn r0, #121 ;loading r0 with the ASCII code for "y"
			call getChar
			load r3, pressedKey
			cmp r3, r0
			jne notplayMGAgain3 ;if the input is not "y" then check if it's "n"
			
			;if the input is "y" call the game loop
			call clearScreen
			;jmp for the first game
			jmp startGame1
		
		notplayMGAgain3:
			loadn r0, #110 ;loading r0 with the ASCII code for "n"
			load r3, pressedKey
			cmp r3, r0
			jeq endGame ;if the input is "n" end the program
			
			call playMGAgain3 ;if the input is neither "y" nor "n" then check again
			
			pop r4
			pop r3
			pop r2
			pop r1
			pop r0
			
			rts
			
		playMGAgainlost3:
			push r0
			push r1
			push r2
			push r3
			push r4
		
			loadn r0, #121 ;loading r0 with the ASCII code for "y"
			call getChar
			load r3, pressedKey
			cmp r3, r0
			jne notplayMGAgain3 ;if the input is not "y" then check if it's "n"
			
			;if the input is "y" call the game loop
			call clearScreen
			;jmp for the third game again
			jmp startGame3
		
		notplayMGAgain:
			loadn r0, #110 ;loading r0 with the ASCII code for "n"
			load r3, pressedKey
			cmp r3, r0
			jeq endGame ;if the input is "n" end the program
			
			call playMGAgain3 ;if the input is neither "y" nor "n" then check again
			
			pop r4
			pop r3
			pop r2
			pop r1
			pop r0
			
			rts

;prints the tutorial's screen
showTutorial:
	push r1
	push r2
	
	loadn r2, #0
	loadn r1, #screen2line1 ;tutorial's screen
	call printScreenOverlap
	
	pop r2
	pop r1
	
	rts

;prints the game screen
;GAME 1 -----------------------
printAllFront:

	call printTitle
	
	call printCard0
	call printCard1
	call printCard2
	call printCard3
	call printCard4
	call printCard5
	call printCard6
	call printCard7
	call printCard8
	call printCard9
	
	call printToScreen

	rts
	
;GAME 2 -----------------------
printAllFront2:

	call printTitle
	
	call printCard00
	call printCard01
	call printCard02
	call printCard03
	call printCard04
	call printCard05
	call printCard06
	call printCard07
	call printCard08
	call printCard09
	
	call printToScreen

	rts
	
;GAME 3 -------------------------
printAllFront3:

	call printTitle
	
	call printCard000
	call printCard001
	call printCard002
	call printCard003
	call printCard004
	call printCard005
	call printCard006
	call printCard007
	call printCard008
	call printCard009
	
	call printToScreen

	rts

;prints all the cards facing down
printAllBack:
    
	call printCard0back
	
	call printCard1back
	
	call printCard2back
	
	call printCard3back
	
	call printCard4back
	
	call printCard5back
	
	call printCard6back
	
	call printCard7back
	
	call printCard8back
	
	call printCard9back

	rts

;prints the card(facing up) pressed by the player
;GAME 1 -------------------------
printFront:

	push r1
	push r2
	push r3
	push r5
	
	loadn r2, #0
	
	loadn r3, #48 ;0 + 48 (turning 0 into it's actual ASCII code)
	
	;cheking if the input is 0
	cmp r3, r7
	jne nextCard1 ;if it's not 0 then check if it's 1
	;if the input is 0 then change the 0 flag to 1 (card facing up)
	load r5, flag0
	inc r5
	store flag0, r5
	call printCard0 ;actually printing the card frontwards
    jmp endPfront ;going to the end because this function only checks one input at a time
    
    ;repeating this process to the other cards
	nextCard1:
		loadn r3, #49 ;1 + 48 (ASCII)

		cmp r3, r7
		jne nextCard2
		load r5, flag1
		inc r5
		store flag1, r5
		call printCard1
        jmp endPfront
	
	nextCard2: 
		loadn r3, #50 ;2 + 48 (ASCII)

		cmp r3, r7
		jne nextCard3
		load r5, flag2
		inc r5
		store flag2, r5
		call printCard2
        jmp endPfront

	nextCard3: 
		loadn r3, #51 ;3 + 48 (ASCII)

		cmp r3, r7
		jne nextCard4
		load r5, flag3
		inc r5
		store flag3, r5
		call printCard3
        jmp endPfront

	nextCard4: 
		loadn r3, #52 ;4 + 48 (ASCII)

		cmp r3, r7
		jne nextCard5
		load r5, flag4
		inc r5
		store flag4, r5
		call printCard4
        jmp endPfront

	nextCard5: 
		loadn r3, #53 ;5 + 48 (ASCII)

		cmp r3, r7
		jne nextCard6
		load r5, flag5
		inc r5
		store flag5, r5
		call printCard5
        jmp endPfront

	nextCard6: 
		loadn r3, #54 ;6 + 48 (ASCII)

		cmp r3, r7
		jne nextCard7
		load r5, flag6
		inc r5
		store flag6, r5
		call printCard6
        jmp endPfront

	nextCard7: 
		loadn r3, #55 ;7 + 48 (ASCII)

		cmp r3, r7
		jne nextCard8
		load r5, flag7
		inc r5
		store flag7, r5
		call printCard7
        jmp endPfront

	nextCard8: 
		loadn r3, #56 ;8 + 48 (ASCII)

		cmp r3, r7
		jne nextCard9
		load r5, flag8
		inc r5
		store flag8, r5
		call printCard8
        jmp endPfront

	nextCard9: 
		loadn r3, #57 ;9 + 48 (ASCII)
		
		cmp r3, r7
		jne endPfront
		load r5, flag9
		inc r5
		store flag9, r5
		call printCard9
        jmp endPfront

	endPfront:
		
	pop r5
	pop r3
	pop r2
	pop r1

	rts
	
;GAME 2 ---------------------------------------------
printFront2:
	push r1
	push r2
	push r3
	push r5
	
	loadn r2, #0
	
	loadn r3, #48 ;0 + 48 (turning 0 into it's actual ASCII code)
	
	;cheking if the input is 0
	cmp r3, r7
	jne nextCard01 ;if it's not 0 then check if it's 1
	;if the input is 0 then change the 0 flag to 1 (card facing up)
	load r5, flag00
	inc r5
	store flag00, r5
	call printCard00 ;actually printing the card frontwards
    jmp endPfront ;going to the end because this function only checks one input at a time
    
    ;repeating this process to the other cards
	nextCard01:
		loadn r3, #49 ;1 + 48 (ASCII)

		cmp r3, r7
		jne nextCard02
		load r5, flag01
		inc r5
		store flag01, r5
		call printCard01
        jmp endPfront
	
	nextCard02: 
		loadn r3, #50 ;2 + 48 (ASCII)

		cmp r3, r7
		jne nextCard03
		load r5, flag02
		inc r5
		store flag02, r5
		call printCard02
        jmp endPfront

	nextCard03: 
		loadn r3, #51 ;3 + 48 (ASCII)

		cmp r3, r7
		jne nextCard04
		load r5, flag03
		inc r5
		store flag03, r5
		call printCard03
        jmp endPfront

	nextCard04: 
		loadn r3, #52 ;4 + 48 (ASCII)

		cmp r3, r7
		jne nextCard05
		load r5, flag04
		inc r5
		store flag04, r5
		call printCard04
        jmp endPfront

	nextCard05: 
		loadn r3, #53 ;5 + 48 (ASCII)

		cmp r3, r7
		jne nextCard06
		load r5, flag05
		inc r5
		store flag05, r5
		call printCard05
        jmp endPfront

	nextCard06: 
		loadn r3, #54 ;6 + 48 (ASCII)

		cmp r3, r7
		jne nextCard07
		load r5, flag06
		inc r5
		store flag06, r5
		call printCard06
        jmp endPfront

	nextCard07: 
		loadn r3, #55 ;7 + 48 (ASCII)

		cmp r3, r7
		jne nextCard08
		load r5, flag07
		inc r5
		store flag07, r5
		call printCard07
        jmp endPfront

	nextCard08: 
		loadn r3, #56 ;8 + 48 (ASCII)

		cmp r3, r7
		jne nextCard09
		load r5, flag08
		inc r5
		store flag08, r5
		call printCard08
        jmp endPfront

	nextCard09: 
		loadn r3, #57 ;9 + 48 (ASCII)
		
		cmp r3, r7
		jne endPfront
		load r5, flag09
		inc r5
		store flag09, r5
		call printCard09
        jmp endPfront

	endPfront:
		
	pop r5
	pop r3
	pop r2
	pop r1

	rts
	
;GAME 3 -------------------------------------------
printFront3:
	push r1
	push r2
	push r3
	push r5
	
	loadn r2, #0
	
	loadn r3, #48 ;0 + 48 (turning 0 into it's actual ASCII code)
	
	;cheking if the input is 0
	cmp r3, r7
	jne nextCard001 ;if it's not 0 then check if it's 1
	;if the input is 0 then change the 0 flag to 1 (card facing up)
	load r5, flag000
	inc r5
	store flag000, r5
	call printCard000 ;actually printing the card frontwards
    jmp endPfront ;going to the end because this function only checks one input at a time
    
    ;repeating this process to the other cards
	nextCard001:
		loadn r3, #49 ;1 + 48 (ASCII)

		cmp r3, r7
		jne nextCard002
		load r5, flag001
		inc r5
		store flag001, r5
		call printCard001
        jmp endPfront
	
	nextCard002: 
		loadn r3, #50 ;2 + 48 (ASCII)

		cmp r3, r7
		jne nextCard003
		load r5, flag002
		inc r5
		store flag002, r5
		call printCard002
        jmp endPfront

	nextCard003: 
		loadn r3, #51 ;3 + 48 (ASCII)

		cmp r3, r7
		jne nextCard004
		load r5, flag003
		inc r5
		store flag003, r5
		call printCard003
        jmp endPfront

	nextCard004: 
		loadn r3, #52 ;4 + 48 (ASCII)

		cmp r3, r7
		jne nextCard005
		load r5, flag004
		inc r5
		store flag004, r5
		call printCard004
        jmp endPfront

	nextCard005: 
		loadn r3, #53 ;5 + 48 (ASCII)

		cmp r3, r7
		jne nextCard006
		load r5, flag005
		inc r5
		store flag005, r5
		call printCard005
        jmp endPfront

	nextCard006: 
		loadn r3, #54 ;6 + 48 (ASCII)

		cmp r3, r7
		jne nextCard007
		load r5, flag006
		inc r5
		store flag006, r5
		call printCard006
        jmp endPfront

	nextCard007: 
		loadn r3, #55 ;7 + 48 (ASCII)

		cmp r3, r7
		jne nextCard008
		load r5, flag007
		inc r5
		store flag007, r5
		call printCard007
        jmp endPfront

	nextCard008: 
		loadn r3, #56 ;8 + 48 (ASCII)

		cmp r3, r7
		jne nextCard009
		load r5, flag008
		inc r5
		store flag008, r5
		call printCard008
        jmp endPfront

	nextCard009: 
		loadn r3, #57 ;9 + 48 (ASCII)
		
		cmp r3, r7
		jne endPfront
		load r5, flag009
		inc r5
		store flag009, r5
		call printCard009
        jmp endPfront

	endPfront:
		
	pop r5
	pop r3
	pop r2
	pop r1

	rts

;prints the card(facing down) pressed by the player if there isn't a match
;GAME 1 ------------------------------------------	
printBack:

	push r0
	push r1
	push r2
	push r3
	
	loadn r0, #0
	load r3, flag0
	cmp r0, r3
	jeq nextVerification1 ;if the card is facing down then it doesn't need to be printed backwards again
	
	;verifying if the card facing up has already been matched
	loadn r0, #1
	load r3, match08
	cmp r0, r3
	jeq nextVerification1 ;if the match has been made the front of the card must be kept facing up

	;if the card is facing up but hasn't been matched then it should be printed facing down
	call printCard0back
	;changing the card flag to 0 (facing down)
	load r3, flag0
	dec r3
	store flag0, r3
	
	;repeating this process to the other cards
	nextVerification1:
		loadn r0, #0
		load r3, flag1
		cmp r0, r3
		jeq nextVerification2

		loadn r0, #1
		load r3, match17
		cmp r0, r3
		jeq nextVerification2
        
		call printCard1back
		load r3, flag1
		dec r3
		store flag1, r3

	nextVerification2:
		loadn r0, #0
		load r3, flag2
		cmp r0, r3
		jeq nextVerification3

		loadn r0, #1
		load r3, match26
		cmp r0, r3
		jeq nextVerification3
        
		call printCard2back
		load r3, flag2
		dec r3
		store flag2, r3
	
	nextVerification3:
		loadn r0, #0
		load r3, flag3
		cmp r0, r3
		jeq nextVerification4

		loadn r0, #1
		load r3, match35
		cmp r0, r3
		jeq nextVerification4
       
		call printCard3back
		load r3, flag3
		dec r3
		store flag3, r3
	
	nextVerification4:
		loadn r0, #0
		load r3, flag4
		cmp r0, r3
		jeq nextVerification5

		loadn r0, #1
		load r3, match49
		cmp r0, r3
		jeq nextVerification5
        
		call printCard4back
		load r3, flag4
		dec r3
		store flag4, r3
	
	nextVerification5:
		loadn r0, #0
		load r3, flag5
		cmp r0, r3
		jeq nextVerification6

		loadn r0, #1
		load r3, match35
		cmp r0, r3
		jeq nextVerification6
		
        
		call printCard5back
		load r3, flag5
		dec r3
		store flag5, r3

	nextVerification6:
		loadn r0, #0
		load r3, flag6
		cmp r0, r3
		
		jeq nextVerification7

		loadn r0, #1
		load r3, match26
		cmp r0, r3
		jeq nextVerification7
        
        
		call printCard6back
		load r3, flag6
		dec r3
		store flag6, r3
		

	nextVerification7:
		loadn r0, #0
		load r3, flag7
		cmp r0, r3
		jeq nextVerification8

		loadn r0, #1
		load r3, match17
		cmp r0, r3
		jeq nextVerification8
		
        
		call printCard7back
		load r3, flag7
		dec r3
		store flag7, r3

	nextVerification8:
		loadn r0, #0
		load r3, flag8
		cmp r0, r3
		jeq nextVerification9

		loadn r0, #1
		load r3, match08
		cmp r0, r3
		
		jeq nextVerification9
		
       
		call printCard8back
		load r3, flag8
		dec r3
		store flag8, r3

	nextVerification9:
		loadn r0, #0
		load r3, flag9
		cmp r0, r3
		jeq endPback

		loadn r0, #1
		load r3, match49
		cmp r0, r3
		jeq endPback
		
         
		call printCard9back
		load r3, flag9
		dec r3
		store flag9, r3

	endPback:

	pop r3	
	pop r2
	pop r1
	pop r0

	rts


;GAME 2 ------------------------------------------
printBack2:
	push r0
	push r1
	push r2
	push r3
	
	loadn r0, #0
	load r3, flag00
	cmp r0, r3
	jeq nextVerification01 ;if the card is facing down then it doesn't need to be printed backwards again
	
	;verifying if the card facing up has already been matched
	loadn r0, #1
	load r3, match06
	cmp r0, r3
	jeq nextVerification01 ;if the match has been made the front of the card must be kept facing up
	
	;if the card is facing up but hasn't been matched then it should be printed facing down
	call printCard0back
	;changing the card flag to 0 (facing down)
	load r3, flag00
	dec r3
	store flag00, r3
	
	;repeating this process to the other cards
	nextVerification01:
		loadn r0, #0
		load r3, flag01
		cmp r0, r3
		jeq nextVerification02

		loadn r0, #1
		load r3, match14
		cmp r0, r3
		jeq nextVerification02

		call printCard1back
		load r3, flag01
		dec r3
		store flag01, r3

	nextVerification02:
		loadn r0, #0
		load r3, flag02
		cmp r0, r3
		jeq nextVerification03

		loadn r0, #1
		load r3, match29
		cmp r0, r3
		jeq nextVerification03

		call printCard2back
		load r3, flag02
		dec r3
		store flag02, r3
	
	nextVerification03:
		loadn r0, #0
		load r3, flag03
		cmp r0, r3
		jeq nextVerification04

		loadn r0, #1
		load r3, match38
		cmp r0, r3
		jeq nextVerification04

		call printCard3back
		load r3, flag03
		dec r3
		store flag03, r3
	
	nextVerification04:
		loadn r0, #0
		load r3, flag04
		cmp r0, r3
		jeq nextVerification05

		loadn r0, #1
		load r3, match14
		cmp r0, r3
		jeq nextVerification05

		call printCard4back
		load r3, flag04
		dec r3
		store flag04, r3
	
	nextVerification05:
		loadn r0, #0
		load r3, flag05
		cmp r0, r3
		jeq nextVerification06

		loadn r0, #1
		load r3, match57
		cmp r0, r3
		jeq nextVerification06

		call printCard5back
		load r3, flag05
		dec r3
		store flag05, r3

	nextVerification06:
		loadn r0, #0
		load r3, flag06
		cmp r0, r3
		jeq nextVerification07

		loadn r0, #1
		load r3, match06
		cmp r0, r3
		jeq nextVerification07

		call printCard6back
		load r3, flag06
		dec r3
		store flag06, r3

	nextVerification07:
		loadn r0, #0
		load r3, flag07
		cmp r0, r3
		jeq nextVerification08

		loadn r0, #1
		load r3, match57
		cmp r0, r3
		jeq nextVerification08

		call printCard7back
		load r3, flag07
		dec r3
		store flag07, r3

	nextVerification08:
		loadn r0, #0
		load r3, flag08
		cmp r0, r3
		jeq nextVerification09

		loadn r0, #1
		load r3, match38
		cmp r0, r3
		jeq nextVerification09

		call printCard8back
		load r3, flag08
		dec r3
		store flag08, r3

	nextVerification09:
		loadn r0, #0
		load r3, flag09
		cmp r0, r3
		jeq endPback

		loadn r0, #1
		load r3, match29
		cmp r0, r3
		jeq endPback

		call printCard9back
		load r3, flag09
		dec r3
		store flag09, r3

	endPback:

	pop r3	
	pop r2
	pop r1
	pop r0

	rts
	
;GAME 3 ----------------------------------------
printBack3:
	push r0
	push r1
	push r2
	push r3
	
	loadn r0, #0
	load r3, flag000
	cmp r0, r3
	jeq nextVerification001 ;if the card is facing down then it doesn't need to be printed backwards again
	
	;verifying if the card facing up has already been matched
	loadn r0, #1
	load r3, match09
	cmp r0, r3
	jeq nextVerification001 ;if the match has been made the front of the card must be kept facing up
	
	;if the card is facing up but hasn't been matched then it should be printed facing down
	call printCard0back
	;changing the card flag to 0 (facing down)
	load r3, flag000
	dec r3
	store flag000, r3
	
	;repeating this process to the other cards
	nextVerification001:
		loadn r0, #0
		load r3, flag001
		cmp r0, r3
		jeq nextVerification002

		loadn r0, #1
		load r3, match14
		cmp r0, r3
		jeq nextVerification002

		call printCard1back
		load r3, flag001
		dec r3
		store flag001, r3

	nextVerification002:
		loadn r0, #0
		load r3, flag002
		cmp r0, r3
		jeq nextVerification003

		loadn r0, #1
		load r3, match25
		cmp r0, r3
		jeq nextVerification003

		call printCard2back
		load r3, flag002
		dec r3
		store flag002, r3
	
	nextVerification003:
		loadn r0, #0
		load r3, flag003
		cmp r0, r3
		jeq nextVerification004

		loadn r0, #1
		load r3, match37
		cmp r0, r3
		jeq nextVerification004

		call printCard3back
		load r3, flag003
		dec r3
		store flag003, r3
	
	nextVerification004:
		loadn r0, #0
		load r3, flag004
		cmp r0, r3
		jeq nextVerification005

		loadn r0, #1
		load r3, match14
		cmp r0, r3
		jeq nextVerification005

		call printCard4back
		load r3, flag004
		dec r3
		store flag004, r3
	
	nextVerification005:
		loadn r0, #0
		load r3, flag005
		cmp r0, r3
		jeq nextVerification006

		loadn r0, #1
		load r3, match25
		cmp r0, r3
		jeq nextVerification006

		call printCard5back
		load r3, flag005
		dec r3
		store flag005, r3

	nextVerification006:
		loadn r0, #0
		load r3, flag006
		cmp r0, r3
		jeq nextVerification007

		loadn r0, #1
		load r3, match68
		cmp r0, r3
		jeq nextVerification007

		call printCard6back
		load r3, flag006
		dec r3
		store flag006, r3

	nextVerification007:
		loadn r0, #0
		load r3, flag007
		cmp r0, r3
		jeq nextVerification008

		loadn r0, #1
		load r3, match37
		cmp r0, r3
		jeq nextVerification008

		call printCard7back
		load r3, flag007
		dec r3
		store flag007, r3

	nextVerification008:
		loadn r0, #0
		load r3, flag008
		cmp r0, r3
		jeq nextVerification009

		loadn r0, #1
		load r3, match68
		cmp r0, r3
		jeq nextVerification009

		call printCard8back
		load r3, flag008
		dec r3
		store flag008, r3

	nextVerification009:
		loadn r0, #0
		load r3, flag009
		cmp r0, r3
		jeq endPback

		loadn r0, #1
		load r3, match09
		cmp r0, r3
		jeq endPback

		call printCard9back
		load r3, flag009
		dec r3
		store flag009, r3

	endPback:

	pop r3	
	pop r2
	pop r1
	pop r0

	rts

;checking if there is a match
;GAME 1 ------------------------------------------	
verifyMatch:
	push r0
	push r1
	
	;if the match has already been done then we skip this verification
	loadn r0, #1
	load r1, match08
	cmp r0, r1
	jeq nextCheck1

	loadn r0, #0
	
	load r1, flag0
	cmp r0, r1
	jeq nextCheck1
	
	load r1, flag8
	cmp r0, r1
	jeq nextCheck1
	
	;both 0 and 8 cards are facing up (flag = 1)
	load r1, match08
	inc r1
	store match08, r1 ;match08 = 1
	call increaseScore
	jmp endVerify
	
	;repeating this process to the other matches
	nextCheck1:
		loadn r0, #1
		load r1, match17
		cmp r0, r1
		jeq nextCheck2

		loadn r0, #0

		load r1, flag1
		cmp r0, r1
		jeq nextCheck2

		load r1, flag7
		cmp r0, r1
		jeq nextCheck2
		
		;both 1 and 7 cards are facing up (flag = 1)
		load r1, match17
		inc r1
		store match17, r1 ;match17 = 1
		call increaseScore
		jmp endVerify

	nextCheck2:

		loadn r0, #1
		load r1, match26
		cmp r0, r1
		jeq nextCheck3
	
		loadn r0, #0

		load r1, flag2
		cmp r0, r1
		jeq nextCheck3

		load r1, flag6
		cmp r0, r1
		jeq nextCheck3
		
		;both 2 and 6 cards are facing up (flag = 1)
		load r1, match26
		inc r1
		store match26, r1 ;match26 = 1
		call increaseScore
		jmp endVerify

	nextCheck3:

		loadn r0, #1
		load r1, match35
		cmp r0, r1
		jeq nextCheck4
		
		loadn r0, #0

		load r1, flag3
		cmp r0, r1
		jeq nextCheck4

		load r1, flag5
		cmp r0, r1
		jeq nextCheck4
		
		;both 3 and 5 cards are facing up (flag = 1)
		load r1, match35
		inc r1
		store match35, r1 ;match35 = 1
		call increaseScore
		jmp endVerify

	nextCheck4:

		loadn r0, #1
		load r1, match49
		cmp r0, r1
		jeq endVerify
		
		loadn r0, #0

		load r1, flag4
		cmp r0, r1
		jeq endVerify

		load r1, flag9
		cmp r0, r1
		jeq endVerify
		
		;both 4 and 9 cards are facing up (flag = 1)
		load r1, match49
		inc r1
		store match49, r1 ;match49 = 1
		call increaseScore
		jmp endVerify
		
	;if there isn't a match (matchFound == 0), call the function to decrement lifes
	endVerify: 
	loadn r0, #0
	cmp r0, r1
	jne skipLifeLoss
	call decrementLifes  

skipLifeLoss:
	pop r1
	pop r0
	rts
	
;GAME 2 ------------------------------------------------------------------------
verifyMatch2:
	push r0
	push r1
	
	;if the match has already been done then we skip this verification
	loadn r0, #1
	load r1, match06
	cmp r0, r1
	jeq nextCheck01

	loadn r0, #0
	
	load r1, flag00
	cmp r0, r1
	jeq nextCheck01
	
	load r1, flag06
	cmp r0, r1
	jeq nextCheck01
	
	;both 0 and 6 cards are facing up (flag = 1)
	load r1, match06
	inc r1
	store match06, r1 ;match06 = 1
	call increaseScore
	jmp endVerify
	
	;repeating this process to the other matches
	nextCheck01:
		loadn r0, #1
		load r1, match14
		cmp r0, r1
		jeq nextCheck02

		loadn r0, #0

		load r1, flag01
		cmp r0, r1
		jeq nextCheck02

		load r1, flag04
		cmp r0, r1
		jeq nextCheck02
		
		;both 1 and 4 cards are facing up (flag = 1)
		load r1, match14
		inc r1
		store match14, r1 ;match14 = 1
		call increaseScore
		jmp endVerify

	nextCheck02:

		loadn r0, #1
		load r1, match29
		cmp r0, r1
		jeq nextCheck03
	
		loadn r0, #0

		load r1, flag02
		cmp r0, r1
		jeq nextCheck03

		load r1, flag09
		cmp r0, r1
		jeq nextCheck03
		
		;both 2 and 9 cards are facing up (flag = 1)
		load r1, match29
		inc r1
		store match29, r1 ;match29 = 1
		call increaseScore
		jmp endVerify

	nextCheck03:

		loadn r0, #1
		load r1, match38
		cmp r0, r1
		jeq nextCheck04
		
		loadn r0, #0

		load r1, flag03
		cmp r0, r1
		jeq nextCheck04

		load r1, flag08
		cmp r0, r1
		jeq nextCheck04
		
		;both 3 and 8 cards are facing up (flag = 1)
		load r1, match38
		inc r1
		store match38, r1 ;match38 = 1
		call increaseScore
		jmp endVerify

	nextCheck04:

		loadn r0, #1
		load r1, match57
		cmp r0, r1
		jeq endVerify
		
		loadn r0, #0

		load r1, flag05
		cmp r0, r1
		jeq endVerify

		load r1, flag07
		cmp r0, r1
		jeq endVerify
		
		;both 5 and 7 cards are facing up (flag = 1)
		load r1, match57
		inc r1
		store match57, r1 ;match57 = 1
		call increaseScore
		jmp endVerify
		
	;if there isn't a match (matchFound == 0), call the function to decrement lifes	
	endVerify: 
	loadn r0, #0
	cmp r0, r1
	jne skipLifeLoss
	call decrementLifes  

skipLifeLoss:
	pop r1
	pop r0
	rts
	
;GAME 3 -------------------------------------------------------------
verifyMatch3:
	push r0
	push r1
	
	;if the match has already been done then we skip this verification
	loadn r0, #1
	load r1, match09
	cmp r0, r1
	jeq nextCheck001

	loadn r0, #0
	
	load r1, flag000
	cmp r0, r1
	jeq nextCheck001
	
	load r1, flag009
	cmp r0, r1
	jeq nextCheck001
	
	;both 0 and 9 cards are facing up (flag = 1)
	load r1, match09
	inc r1
	store match09, r1 ;match09 = 1
	call increaseScore
	jmp endVerify
	
	;repeating this process to the other matches
	nextCheck001:
		loadn r0, #1
		load r1, match14
		cmp r0, r1
		jeq nextCheck002

		loadn r0, #0

		load r1, flag001
		cmp r0, r1
		jeq nextCheck002

		load r1, flag004
		cmp r0, r1
		jeq nextCheck002
		
		;both 1 and 4 cards are facing up (flag = 1)
		load r1, match14
		inc r1
		store match14, r1 ;match14 = 1
		call increaseScore
		jmp endVerify

	nextCheck002:

		loadn r0, #1
		load r1, match25
		cmp r0, r1
		jeq nextCheck003
	
		loadn r0, #0

		load r1, flag002
		cmp r0, r1
		jeq nextCheck003

		load r1, flag005
		cmp r0, r1
		jeq nextCheck003
		
		;both 2 and 5 cards are facing up (flag = 1)
		load r1, match25
		inc r1
		store match25, r1 ;match25 = 1
		call increaseScore
		jmp endVerify

	nextCheck003:

		loadn r0, #1
		load r1, match68
		cmp r0, r1
		jeq nextCheck004
		
		loadn r0, #0

		load r1, flag006
		cmp r0, r1
		jeq nextCheck004

		load r1, flag008
		cmp r0, r1
		jeq nextCheck004
		
		;both 6 and 8 cards are facing up (flag = 1)
		load r1, match68
		inc r1
		store match68, r1 ;match68 = 1
		call increaseScore
		jmp endVerify

	nextCheck004:

		loadn r0, #1
		load r1, match37 
		cmp r0, r1
		jeq endVerify
		
		loadn r0, #0

		load r1, flag003
		cmp r0, r1
		jeq endVerify

		load r1, flag007
		cmp r0, r1
		jeq endVerify
		
		;both 3 and 7 cards are facing up (flag = 1)
		load r1, match37
		inc r1
		store match37, r1 ;match37 = 1
		call increaseScore
		jmp endVerify

	endVerify: ;if there isn't a match (matchFound == 0), call the function to decrement lifes
	loadn r0, #0
	cmp r0, r1	 
	jne skipLifeLoss
	call decrementLifes
	
	
skipLifeLoss:
	pop r1
	pop r0
	rts	
	
	
;function to decrement lifes
decrementLifes:
	push r0

	load r0, lifes
	dec r0
	store lifes, r0
	jmp endIncScore
 
	endIncScore:	
	;increasing the Score lifes 
	load r0, ScoreLifes
	inc r0
	store ScoreLifes, r0

	pop r0

	rts
	
;Function to increase the score
increaseScore:
	push r0
    push r2

	;increasing the total score
	load r0, scoreTotal
	inc r0
	store scoreTotal, r0
	
    pop r2
	pop r0

	rts

;prints the box that shows the number of lifes
printLifes:
	push r2
	push r3
	push r4
	
	load r3, lifes ;loading the lifes
	loadn r4, #1102 ;loading it's position on the screen
	add r3, r3, r2 ;turning the number into it's actual ASCII code
	outchar r3, r4 ;printing the lifes
	
	pop r4
	pop r3
	pop r2

	rts

;prints whole screens
printScreenOverlap:

	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #0 ;the initial position is the first position of the screen
	loadn r3, #40 ;increasing the position to the next line
	loadn r4, #41 ;increasing the pointer of the lines of the screen
	loadn r5, #1200 ;end of the screen
	loadn r6, #screen0line1	;adress of the first line of the scenario
	
	printScreenOverlap_Loop:
		call printStringOverlap
		add r0, r0, r3 ;going to the next line -> r0 = r0 + 40
		add r1, r1, r4 ;increasing the pointer to the beggining of the next line of the memory -> r1 = r1 + 41 (41 because every string ends with "\0")
		add r6, r6, r4 ;increasing the pointer to the beggining of the next line of the memory -> r1 = r1 + 41 (41 because every string ends with "\0")
		cmp r0, r5 ;compares the r0 to 1200
		jne printScreenOverlap_Loop	;while r0 < 1200

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;used on the printScreenOverlap function
printStringOverlap:
	push r0	
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	
	loadn r3, #'\0' ;end of the string
	loadn r5, #' ' ;blank space

	printStringOverlap_Loop:
		loadi r4, r1
		cmp r4, r3 ;if (Char == '\0') return
		jeq printStringOverlap_Return
		cmp r4, r5 ;if (Char == ' '): jump the outchar of " " not to erase the other characters
		jeq printStringOverlap_Skip
		add r4, r2, r4 ;adds the color code
		outchar r4, r0;printing the character to the screen
		storei r6, r4
	printStringOverlap_Skip:
		inc r0 ;increases screen position
		inc r1 ;increases the string pointer
		inc r6 ;increases the string pointer of screen0
		jmp printStringOverlap_Loop
	
	printStringOverlap_Return:	
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts	

;gets the input from the keyboard
getChar:
	push r1
	push r0
	
	;waiting for a reasonable input
	loadn r1, #255
	recebeCharLoop:
		inchar r0 
		cmp r0, r1
		jeq recebeCharLoop
	
	;storing the input to the pressedKey variable
	store pressedKey, r0 

	pop r0
	pop r1
	
	rts

;Function to print strings
printString:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	loadn r3, #'\0'	;end of the string

	printStringLoop:	
		loadi r4, r1
		cmp r4, r3
		jeq printStringReturn
		add r4, r2, r4
		outchar r4, r0
		inc r0
		inc r1
		jmp printStringLoop
		
	printStringReturn:	
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts
		
;function to clear the screen
clearScreen:
    push fr
	push r0
	push r1
	
	loadn r0, #1200 ;erases the 1200 positions of the screen
	loadn r1, #' ' ;blank space
	
	clearScreen_Loop: ;label for(r0 = 1200; r3 > 0; r3--)
		dec r0
		outchar r1, r0
		jnz clearScreen_Loop
 
	pop r1
	pop r0
    pop fr
	rts

;gets a delay, for example to show the card facing up for a few seconds before the start 
longDelay:
	push r0
	push r1
	push r2
	
	loadn r0,#0
	loadn r2,#2000

	loopj:
		loadn r1,#0
		loopi:
			inc r1
			cmp r1,r2
			jne loopi
		inc r0
		cmp r0,r2
		jne loopj
		
	pop r2
	pop r1
	pop r0
	
	rts	

;resets all the variables
resetVariables:
	push r0
	push r1
	loadn r1, #51
	loadn r0, #0
	store flag0, r0
	store flag1, r0
	store flag2, r0
	store flag3, r0
	store flag4, r0
	store flag5, r0
	store flag6, r0
	store flag7, r0
	store flag8, r0
	store flag9, r0 
	store flag00, r0
	store flag01, r0
	store flag02, r0
	store flag03, r0
	store flag04, r0
	store flag05, r0
	store flag06, r0
	store flag07, r0
	store flag08, r0
	store flag09, r0 
	store match08, r0
	store match17, r0
	store match26, r0
	store match35, r0
	store match49, r0
	store match06, r0
	store match14, r0
	store match29, r0
	store match38, r0
	store match57, r0
	store match25, r0
    store match09, r0
    store match14, r0
    store match37, r0
    store match68, r0
	store lifes, r1
	store ScoreLifes, r0
	store scoreTotal, r0  
	pop r1
	pop r0

screen0line1 :  string "                                        "
screen0line2 :  string "                                        "
screen0line3 :  string "                                        "
screen0line4 :  string "                                        "
screen0line5 :  string "                                        "
screen0line6 :  string "                                        "
screen0line7 :  string "                                        "
screen0line8 :  string "                                        "
screen0line9 :  string "                                        "
screen0line10 : string "                                        "
screen0line11 : string "                                        "
screen0line12 : string "                                        "
screen0line13 : string "                                        "
screen0line14 : string "                                        "
screen0line15 : string "                                        "
screen0line16 : string "                                        "
screen0line17 : string "                                        "
screen0line18 : string "                                        "
screen0line19 : string "                                        "
screen0line20 : string "                                        "
screen0line21 : string "                                        "
screen0line22 : string "                                        "
screen0line23 : string "                                        "
screen0line24 : string "                                        "
screen0line25 : string "                                        "
screen0line26 : string "                                        "
screen0line27 : string "                                        "
screen0line28 : string "                                        "
screen0line29 : string "                                        "
screen0line30 : string "                                        "

memorygamestring : string "!Choose your cards!"

;Function to print the title(the string: Choose your cards)
printTitle:
	push r0
	push r1
	push r2
	
	loadn r0, #50 ;start position
    loadn r2, #0 ;selects the color of the string
    
    loadn r1, #memorygamestring
    call printString
    
    pop r2
    pop r1
    pop r0
    
    rts

;strings that will appear on the game screen
string_Lifes : string "Lifes:"
heart : string "#$"

;function to print the strings above
printToScreen:
	push r0
	push r1
	push r2
	push r3
	
	loadn r0, #1096 ;start position
    loadn r3, #40
    loadn r2, #0 ;selects the color of the string
    
    loadn r1, #string_Lifes
    call printString
    loadn r0, #1103
    loadn r2, #2304       ; Position on the screen where the message will be printed
    loadn r1, #heart   ; Loads r1 with the adress of the vector that contains the message
    call printString
      
    pop r3
	pop r2
	pop r1
	pop r0
	
    rts


;front of the cards-------------------------------------------------
;star
card0_1: string "*;;;;;;*"
card0_2: string "[      [" 
card0_3: string "[      ["
card0_4: string "[      ["
card0_5: string "[      ["
card0_6: string "[      ["
card0_7: string "[      ["
card0_8: string "*;;;;;;*"


card0_02: string "  }}} "
card0_03: string "}} } }"
card0_04: string "}} } }"
card0_05: string " }}}} "
card0_06: string "}}}}}}"
card0_07: string "}}  }}"

;GAME 1 ---------------------------
;print the card0 - GAME 1
printCard0:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #200
    loadn r3, #40
    
    loadn r1, #card0_1
    call printString
    add r0, r0, r3       
    loadn r1, #card0_2
    call printString
    add r0, r0, r3
    loadn r1, #card0_3
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_4
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_5
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_6
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_7
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_8
    loadn r2, #0
    call printString 
    
    loadn r0, #241
    loadn r3, #40
    loadn r1, #card0_02
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_03
    loadn r2, #2816 
    call printString
    add r0, r0, r3
     loadn r1, #card0_04
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_05
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_06
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_07
    loadn r2, #2816 
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0

    rts

;mushroom
card1_1: string "*;;;;;;*"
card1_2: string "[      ["
card1_3: string "[      ["
card1_4: string "[      ["   
card1_5: string "[      ["
card1_6: string "[      ["
card1_7: string "[      ["
card1_8: string "*;;;;;;*"

card1_02: string " }}}} "
card1_03: string "}}}}}}"
card1_04: string "}}}}}}"
card1_05: string "}}}}}}"


card1_006: string " } }  "
card1_007: string " }}}} "

;print the card1 - GAME 1
printCard1:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #208
    loadn r3, #40
    
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card1_2
    loadn r2, #0 
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #249
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #2304
    call printString
    add r0, r0, r3
      loadn r1, #card1_05
    loadn r2, #2304
    call printString
    add r0, r0, r3
     loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
     loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts
    
;egg
card2_1: string	"*;;;;;;*"
card2_2: string "[  }}  ["
card2_3: string "[ }}}} ["  
card2_4: string	"[}}}}}}["  
card2_5: string	"[}}}}}}["
card2_6: string	"[}}}}}}["
card2_7: string	"[ }}}} ["
card2_8: string	"*;;;;;;*"
	
;print the card2 - GAME 1
printCard2:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #216 
    loadn r3, #40
    
    loadn r1, #card2_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card2_2
    loadn r2, #0   
    call printString
    add r0, r0, r3
    loadn r1, #card2_3
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_4
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_5
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_6
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_7
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_8
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;pipe	
card3_1: string	"*;;;;;;*"
card3_2: string	"[      ["
card3_3: string	"[      ["
card3_4: string	"[      ["   
card3_5: string	"[      ["
card3_6: string	"[      ["
card3_7: string	"[      ["
card3_8: string	"*;;;;;;*"
	
	
card3_03: string "}}}}}}"	
card3_04: string "}}}}}}"
card3_05: string " } }} "
card3_06: string " } }} "
card3_07: string " }}}} "

;print the card3 - GAME 1
printCard3:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #224
    loadn r3, #40
    
    loadn r1, #card3_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card3_2
     loadn r2, #0  
    call printString
    add r0, r0, r3
    loadn r1, #card3_3
     loadn r2, #0
    call printString
   

    add r0, r0, r3
    loadn r1, #card3_4
     loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_5
     loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_6
     loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_7
     loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_8
    loadn r2, #0
    call printString
    
    loadn r0, #305
    loadn r3, #40
    loadn r1, #card3_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_06
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_07
    loadn r2, #512
    call printString
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;mushroom
card4_1: string "*;;;;;;*"
card4_2: string "[      ["
card4_3: string "[      ["
card4_4: string "[      ["   
card4_5: string "[      ["
card4_6: string "[      ["
card4_7: string "[      ["
card4_8: string "*;;;;;;*"

card4_02: string " }}}} "
card4_03: string "}}}}}}"
card4_04: string "}}}}}}"
card4_05: string "}}}}}}"

card4_006: string " } }  "
card4_007: string " }}}} "

;print the card4 - GAME 1
printCard4:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #232
    loadn r3, #40
    
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card1_2
    loadn r2, #0 
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #273
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card5 - GAME 1
printCard5:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #600
    loadn r3, #40
    
    loadn r1, #card3_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card3_2
    loadn r2, #0   
    call printString
    add r0, r0, r3
    loadn r1, #card3_3
    loadn r2, #0
    call printString
   

    add r0, r0, r3
    loadn r1, #card3_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_5
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_6
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_7
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_8
    loadn r2, #0
    call printString
    
    loadn r0, #681
    loadn r3, #40
    loadn r1, #card3_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_06
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_07
    loadn r2, #512
    call printString
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts


;print the card6 - GAME 1
printCard6:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #608 
    loadn r3, #40
    loadn r2, #0
    loadn r1, #card2_1
    call printString
    add r0, r0, r3       
    loadn r1, #card2_2  
    call printString
    add r0, r0, r3
    loadn r1, #card2_3
    call printString
    add r0, r0, r3
    loadn r1, #card2_4
    call printString
    add r0, r0, r3
    loadn r1, #card2_5
    call printString
    add r0, r0, r3
    loadn r1, #card2_6
    call printString
    add r0, r0, r3
    loadn r1, #card2_7
    call printString
    add r0, r0, r3
    loadn r1, #card2_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card7 - GAME 1
printCard7:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #616
    loadn r3, #40
    
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card1_2
    loadn r2, #0 
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #657
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_05
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts


;print the card8 - GAME 1
printCard8:
	printCard0:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #624
    loadn r3, #40
    
    loadn r1, #card0_1
    call printString
    add r0, r0, r3       
    loadn r1, #card0_2 
    call printString
    add r0, r0, r3
    loadn r1, #card0_3
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_4
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_5
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_6
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_7
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_8
    loadn r2, #0
    call printString 
    
    loadn r0, #665
    loadn r3, #40
    loadn r1, #card0_02
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_03
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_04
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_05
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_06
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_07
    loadn r2, #2816 
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0

    rts

;print the card9 - GAME 1
printCard9:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #632
    loadn r3, #40
    
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3      
    loadn r1, #card1_2
    loadn r2, #0 
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #673
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts
    

;GAME 2 -----------------------------------------------
;print the card0 - GAME 2
printCard00:

	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #200
    loadn r3, #40
    loadn r1, #card3_1
    loadn r2, #0
    call printString
    add r0, r0, r3      
    loadn r1, #card3_2
    loadn r2, #0   
    call printString
    add r0, r0, r3
    loadn r1, #card3_3
    loadn r2, #0
    call printString
   

    add r0, r0, r3
    loadn r1, #card3_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_5
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_6
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_7
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_8
    loadn r2, #0
    call printString
    
    loadn r0, #281
    loadn r3, #40
    loadn r1, #card3_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_06
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_07
    loadn r2, #512
    call printString
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card1 - GAME 2
printCard01:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #208
    loadn r3, #40
    
    
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card1_2
    loadn r2, #0 
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #249
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts
    
;print the card2 - GAME 2
printCard02:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #216
    loadn r3, #40
    
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card1_2
    loadn r2, #0 
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #257
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_05
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card3 - GAME 2
printCard03:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #224
    loadn r3, #40
    
    loadn r1, #card2_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card2_2
    loadn r2, #0   
    call printString
    add r0, r0, r3
    loadn r1, #card2_3
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_4
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_5
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_6
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_7
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_8
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card4 - GAME 2
printCard04:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #232
    loadn r3, #40
    
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3      
    loadn r1, #card1_2
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #273
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card5 - GAME 2
printCard05:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #600
    loadn r3, #40
    
    loadn r2, #0
    
    loadn r1, #card0_1
    call printString
    add r0, r0, r3       
    loadn r1, #card0_2 
    call printString
    add r0, r0, r3
    loadn r1, #card0_3
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_4
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_5
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_6
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_7
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_8
    loadn r2, #0
    call printString 
    
    loadn r0, #641
    loadn r3, #40
    loadn r1, #card0_02
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_03
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_04
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_05
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_06
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_07
    loadn r2, #2816 
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0

    rts

;print the card6 - GAME 2
printCard06:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #608 
    loadn r3, #40
    
    loadn r1, #card3_1
    loadn r2, #0
    call printString
    add r0, r0, r3      
    loadn r1, #card3_2
    loadn r2, #0   
    call printString
    add r0, r0, r3
    loadn r1, #card3_3
    loadn r2, #0
    call printString
   

    add r0, r0, r3
    loadn r1, #card3_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_5
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_6
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_7
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_8
    loadn r2, #0
    call printString
    
    loadn r0, #689
    loadn r3, #40
    loadn r1, #card3_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_06
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_07
    loadn r2, #512
    call printString
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card7 - GAME 2
printCard07:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #616
    loadn r3, #40
    
    loadn r2, #0
    
    loadn r1, #card0_1
    call printString
    add r0, r0, r3      
    loadn r1, #card0_2 
    call printString
    add r0, r0, r3
    loadn r1, #card0_3
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_4
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_5
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_6
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_7
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_8
    loadn r2, #0
    call printString 
    
    loadn r0, #657
    loadn r3, #40
    loadn r1, #card0_02
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_03
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_04
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_05
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_06
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_07
    loadn r2, #2816 
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0

    rts

;print the card8 - GAME 2
printCard08:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #624
    loadn r3, #40
    
    loadn r1, #card2_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card2_2
    loadn r2, #0  
    call printString
    add r0, r0, r3
    loadn r1, #card2_3
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_4
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_5
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_6
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_7
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_8
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card9 - GAME 2
printCard09:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #632
    loadn r3, #40
    
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card1_2
    loadn r2, #0 
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #673
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_05
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts
    
    
;GAME 3 ----------------------------------------------------
;print the card0 - GAME 3
printCard000:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #200
    loadn r3, #40
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3      
    loadn r1, #card1_2
    loadn r2, #0 
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #241
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_05
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card1 - GAME 3
printCard001:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #208
    loadn r3, #40
    
    
  
    loadn r2, #0
    
    loadn r1, #card0_1
    call printString
    add r0, r0, r3      
    loadn r1, #card0_2 
    call printString
    add r0, r0, r3
    loadn r1, #card0_3
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_4
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_5
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_6
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_7
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_8
    loadn r2, #0
    call printString 
    
    loadn r0, #249
    loadn r3, #40
    loadn r1, #card0_02
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_03
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_04
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_05
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_06
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_07
    loadn r2, #2816 
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0

    rts

;print the card2 - GAME 3
printCard002:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #216
    loadn r3, #40
    
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card1_2
    loadn r2, #0 
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #257
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card3 - GAME 3
printCard003:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #224
    loadn r3, #40
    
    loadn r2, #0
    
    loadn r1, #card2_1
    loadn r2, #0
    call printString
    add r0, r0, r3       
    loadn r1, #card2_2
    loadn r2, #0  
    call printString
    add r0, r0, r3
    loadn r1, #card2_3
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_4
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_5
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_6
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_7
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_8
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card4 - GAME 3
printCard004:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #232
    loadn r3, #40
    
    loadn r2, #0
    
    loadn r1, #card0_1
    call printString
    add r0, r0, r3      
    loadn r1, #card0_2 
    call printString
    add r0, r0, r3
    loadn r1, #card0_3
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_4
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_5
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_6
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_7
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card0_8
    loadn r2, #0
    call printString 
    
    loadn r0, #273
    loadn r3, #40
    loadn r1, #card0_02
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_03
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_04
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_05
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_06
    loadn r2, #2816 
    call printString
    add r0, r0, r3
    loadn r1, #card0_07
    loadn r2, #2816 
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0

    rts

;print the card5 - GAME 3
printCard005:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #600
    loadn r3, #40
    
    loadn r2, #0
    
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3      
    loadn r1, #card1_2
    loadn r2, #0 
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #641
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card6 - GAME 3
printCard006:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #608 
    loadn r3, #40
    
    loadn r1, #card3_1
    loadn r2, #0
    call printString
    add r0, r0, r3      
    loadn r1, #card3_2
    loadn r2, #0  
    call printString
    add r0, r0, r3
    loadn r1, #card3_3
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card3_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_5
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_6
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_7
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_8
    loadn r2, #0
    call printString
    
    loadn r0, #689
    loadn r3, #40
    loadn r1, #card3_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_06
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_07
    loadn r2, #512
    call printString
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card7 - GAME 3
printCard007:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #616
    loadn r3, #40
    
    loadn r1, #card2_1
    loadn r2, #0
    call printString
    add r0, r0, r3     
    loadn r1, #card2_2
    loadn r2, #0  
    call printString
    add r0, r0, r3
    loadn r1, #card2_3
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_4
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_5
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_6
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_7
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card2_8
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card8 - GAME 3
printCard008:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #624
    loadn r3, #40
    
    loadn r1, #card3_1
    loadn r2, #0
    call printString
    add r0, r0, r3      
    loadn r1, #card3_2
    loadn r2, #0   
    call printString
    add r0, r0, r3
    loadn r1, #card3_3
    loadn r2, #0
    call printString
   

    add r0, r0, r3
    loadn r1, #card3_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_5
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_6
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_7
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card3_8
    loadn r2, #0
    call printString
    
    loadn r0, #705
    loadn r3, #40
    loadn r1, #card3_03
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_04
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_05
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_06
    loadn r2, #512
    call printString
    add r0, r0, r3
    loadn r1, #card3_07
    loadn r2, #512
    call printString
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;print the card9 - GAME 3
printCard009:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #632
    loadn r3, #40
    
    loadn r1, #card1_1
    loadn r2, #0
    call printString
    add r0, r0, r3    
    loadn r1, #card1_2
    loadn r2, #0 
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_3
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_4
    loadn r2, #0
    call printString
    
    add r0, r0, r3
    loadn r1, #card1_5
    loadn r2, #0
    call printString
  
    add r0, r0, r3
    loadn r1, #card1_6
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_7
    loadn r2, #0
    call printString
   
    add r0, r0, r3
    loadn r1, #card1_8
    loadn r2, #0
    call printString
    
    loadn r0, #673
    loadn r3, #40
    loadn r1, #card1_02
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_03
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_04
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_05
    loadn r2, #2304
    call printString
    add r0, r0, r3
    loadn r1, #card1_006
    loadn r2, #0
    call printString
    add r0, r0, r3
    loadn r1, #card1_007
    loadn r2, #0
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

    
   
;back of the cards-------------------------------------------------
;used in the three games

;back of the cards
card0back_0: string "  0   " ;number of the card(0)
card0back_1: string "}}}}}}"
card0back_2: string "} (? }"
card0back_3: string "} +{ }"
card0back_4: string "} }} }"
card0back_5: string "} }} }"
card0back_6: string "} }} }"
card0back_7: string "} }} }"
card0back_8: string "}}}}}}"

;print the card0 back
printCard0back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #161
    loadn r3, #40

    loadn r1, #card0back_0
    loadn r2, #0
    call printString

    loadn r2, #2304
    loadn r0, #201
    loadn r1, #card0back_1
    call printString
    add r0, r0, r3           
    loadn r1, #card0back_2  
    call printString
    add r0, r0, r3
    loadn r1, #card0back_3
    call printString
    add r0, r0, r3
    loadn r1, #card0back_4
    call printString
    add r0, r0, r3
    loadn r1, #card0back_5
    call printString
    add r0, r0, r3
    loadn r1, #card0back_6
    call printString
    add r0, r0, r3
    loadn r1, #card0back_7
    call printString
    add r0, r0, r3
    loadn r1, #card0back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;number of the card(1)
card1back_0: string "  1   "

;print the card1 back
printCard1back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #169
    loadn r3, #40

    loadn r1, #card1back_0
    loadn r2, #0
    call printString

    loadn r2, #2304
    loadn r0, #209
    loadn r1, #card0back_1
    call printString
    add r0, r0, r3          
    loadn r1, #card0back_2   
    call printString
    add r0, r0, r3
    loadn r1, #card0back_3
    call printString
    add r0, r0, r3
    loadn r1, #card0back_4
    call printString
    add r0, r0, r3
    loadn r1, #card0back_5
    call printString
    add r0, r0, r3
    loadn r1, #card0back_6
    call printString
    add r0, r0, r3
    loadn r1, #card0back_7
    call printString
    add r0, r0, r3
    loadn r1, #card0back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;number of the card(2)
card2back_0: string "  2   "

;print the card2 back
printCard2back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #177
    loadn r3, #40

    loadn r1, #card2back_0
    loadn r2, #0
    call printString

    loadn r2, #2304
    loadn r0, #217
    loadn r1, #card0back_1
    call printString
    add r0, r0, r3          
    loadn r1, #card0back_2  
    call printString
    add r0, r0, r3
    loadn r1, #card0back_3
    call printString
    add r0, r0, r3
    loadn r1, #card0back_4
    call printString
    add r0, r0, r3
    loadn r1, #card0back_5
    call printString
    add r0, r0, r3
    loadn r1, #card0back_6
    call printString
    add r0, r0, r3
    loadn r1, #card0back_7
    call printString
    add r0, r0, r3
    loadn r1, #card0back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;number of the card(3)
card3back_0: string "  3   "

;print the card3 back
printCard3back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #185
    loadn r3, #40

    loadn r1, #card3back_0
    loadn r2, #0
    call printString

    loadn r2, #2304
    loadn r0, #225
    loadn r1, #card0back_1
    call printString
    add r0, r0, r3           
    loadn r1, #card0back_2  
    call printString
    add r0, r0, r3
    loadn r1, #card0back_3
    call printString
    add r0, r0, r3
    loadn r1, #card0back_4
    call printString
    add r0, r0, r3
    loadn r1, #card0back_5
    call printString
    add r0, r0, r3
    loadn r1, #card0back_6
    call printString
    add r0, r0, r3
    loadn r1, #card0back_7
    call printString
    add r0, r0, r3
    loadn r1, #card0back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;number of the card(4)
card4back_0: string "  4   "

;print the card4 back
printCard4back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #193
    loadn r3, #40

    loadn r1, #card4back_0
    loadn r2, #0
    call printString

    loadn r2, #2304
    loadn r0, #233
    loadn r1, #card0back_1
    call printString
    add r0, r0, r3         
    loadn r1, #card0back_2  
    call printString
    add r0, r0, r3
    loadn r1, #card0back_3
    call printString
    add r0, r0, r3
    loadn r1, #card0back_4
    call printString
    add r0, r0, r3
    loadn r1, #card0back_5
    call printString
    add r0, r0, r3
    loadn r1, #card0back_6
    call printString
    add r0, r0, r3
    loadn r1, #card0back_7
    call printString
    add r0, r0, r3
    loadn r1, #card0back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;number of the card(5)
card5back_0: string "  5   "

;print the card5 back
printCard5back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #561
    loadn r3, #40

    loadn r1, #card5back_0
    loadn r2, #0
    call printString

    loadn r2, #2304
    loadn r0, #601
    loadn r1, #card0back_1
    call printString
    add r0, r0, r3          
    loadn r1, #card0back_2  
    call printString
    add r0, r0, r3
    loadn r1, #card0back_3
    call printString
    add r0, r0, r3
    loadn r1, #card0back_4
    call printString
    add r0, r0, r3
    loadn r1, #card0back_5
    call printString
    add r0, r0, r3
    loadn r1, #card0back_6
    call printString
    add r0, r0, r3
    loadn r1, #card0back_7
    call printString
    add r0, r0, r3
    loadn r1, #card0back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;number of the card(6)
card6back_0: string "  6   "

;print the card6 back
printCard6back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #569
    loadn r3, #40

    loadn r1, #card6back_0
    loadn r2, #0
    call printString

    loadn r2, #2304
    loadn r0, #609
    loadn r1, #card0back_1
    call printString
    add r0, r0, r3           
    loadn r1, #card0back_2   
    call printString
    add r0, r0, r3
    loadn r1, #card0back_3
    call printString
    add r0, r0, r3
    loadn r1, #card0back_4
    call printString
    add r0, r0, r3
    loadn r1, #card0back_5
    call printString
    add r0, r0, r3
    loadn r1, #card0back_6
    call printString
    add r0, r0, r3
    loadn r1, #card0back_7
    call printString
    add r0, r0, r3
    loadn r1, #card0back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;number of the card(7)
card7back_0: string "  7   "

;print the card7 back
printCard7back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #577
    loadn r3, #40

    loadn r1, #card7back_0
    loadn r2, #0
    call printString

    loadn r2, #2304
    loadn r0, #617
    loadn r1, #card0back_1
    call printString
    add r0, r0, r3           
    loadn r1, #card0back_2   
    call printString
    add r0, r0, r3
    loadn r1, #card0back_3
    call printString
    add r0, r0, r3
    loadn r1, #card0back_4
    call printString
    add r0, r0, r3
    loadn r1, #card0back_5
    call printString
    add r0, r0, r3
    loadn r1, #card0back_6
    call printString
    add r0, r0, r3
    loadn r1, #card0back_7
    call printString
    add r0, r0, r3
    loadn r1, #card0back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;number of the card(8)
card8back_0: string "  8   "

;print the card8 back
printCard8back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #585
    loadn r3, #40

    loadn r1, #card8back_0
    loadn r2, #0
    call printString

    loadn r2, #2304
    loadn r0, #625
    loadn r1, #card0back_1
    call printString
    add r0, r0, r3         
    loadn r1, #card0back_2  
    call printString
    add r0, r0, r3
    loadn r1, #card0back_3
    call printString
    add r0, r0, r3
    loadn r1, #card0back_4
    call printString
    add r0, r0, r3
    loadn r1, #card0back_5
    call printString
    add r0, r0, r3
    loadn r1, #card0back_6
    call printString
    add r0, r0, r3
    loadn r1, #card0back_7
    call printString
    add r0, r0, r3
    loadn r1, #card0back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;number of the card(9)
card9back_0: string "  9   "

;print the card9 back
printCard9back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #593
    loadn r3, #40

    loadn r1, #card9back_0
    loadn r2, #0
    call printString

    loadn r2, #2304
    loadn r0, #633
    loadn r1, #card0back_1
    call printString
    add r0, r0, r3           
    loadn r1, #card0back_2  
    call printString
    add r0, r0, r3
    loadn r1, #card0back_3
    call printString
    add r0, r0, r3
    loadn r1, #card0back_4
    call printString
    add r0, r0, r3
    loadn r1, #card0back_5
    call printString
    add r0, r0, r3
    loadn r1, #card0back_6
    call printString
    add r0, r0, r3
    loadn r1, #card0back_7
    call printString
    add r0, r0, r3
    loadn r1, #card0back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts
    
   
;Tutorial's screen
screen2line1 :  string "@<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>@"
screen2line2 :  string "^                                      ^"
screen2line3 :  string "^                                      ^"
screen2line4 :  string "^                                      ^"
screen2line5 :  string "^                                      ^"
screen2line6 :  string "^             HOW TO PLAY              ^"
screen2line7 :  string "^                                      ^"
screen2line8 :  string "^                                      ^"
screen2line9 :  string "^                                      ^"
screen2line10 : string "^                                      ^"
screen2line11 : string "^   THE PLAYER TRIES TO MATCH 2 CARDS  ^"
screen2line12 : string "^         WITH THE SAME SYMBOL         ^"
screen2line13 : string "^                                      ^"
screen2line14 : string "^     THE PLAYER HAS TO IMPUT THE      ^"
screen2line15 : string "^     NUMBER OF THE CARD AND THEN      ^"
screen2line16 : string "_          THE CARD WILL TURN          _"
screen2line17 : string "_                                      _"
screen2line18 : string "_                                      _"
screen2line19 : string "_   THE GAME ENDS WHEN ALL THE CARDS   _"
screen2line20 : string "_             ARE MATCHED              _"
screen2line21 : string "_                 OR                   _"
screen2line22 : string "_     THE PLAYER LOSES THREE LIFES     _"
screen2line23 : string "_                                      _"
screen2line24 : string "_                                      _"
screen2line25 : string "_      --------------------------      _"
screen2line26 : string "_      PRESS ' ENTER' TO CONTINUE      _"
screen2line27 : string "_      --------------------------      _"
screen2line28 : string "_                                      _"
screen2line29 : string "_                                      _"
screen2line30 : string "@<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>@"


;first screen(Mario's Memory)
inicio : var #1200
  ;Linha 0
  static inicio + #0, #64
  static inicio + #1, #60
  static inicio + #2, #60
  static inicio + #3, #60
  static inicio + #4, #60
  static inicio + #5, #60
  static inicio + #6, #60
  static inicio + #7, #60
  static inicio + #8, #60
  static inicio + #9, #60
  static inicio + #10, #60
  static inicio + #11, #60
  static inicio + #12, #60
  static inicio + #13, #60
  static inicio + #14, #60
  static inicio + #15, #60
  static inicio + #16, #60
  static inicio + #17, #60
  static inicio + #18, #60
  static inicio + #19, #60
  static inicio + #20, #62
  static inicio + #21, #62
  static inicio + #22, #62
  static inicio + #23, #62
  static inicio + #24, #62
  static inicio + #25, #62
  static inicio + #26, #62
  static inicio + #27, #62
  static inicio + #28, #62
  static inicio + #29, #62
  static inicio + #30, #62
  static inicio + #31, #62
  static inicio + #32, #62
  static inicio + #33, #62
  static inicio + #34, #62
  static inicio + #35, #62
  static inicio + #36, #62
  static inicio + #37, #62
  static inicio + #38, #62
  static inicio + #39, #64

  ;Linha 1
  static inicio + #40, #94
  static inicio + #41, #127
  static inicio + #42, #127
  static inicio + #43, #127
  static inicio + #44, #127
  static inicio + #45, #127
  static inicio + #46, #127
  static inicio + #47, #127
  static inicio + #48, #127
  static inicio + #49, #127
  static inicio + #50, #127
  static inicio + #51, #127
  static inicio + #52, #127
  static inicio + #53, #127
  static inicio + #54, #127
  static inicio + #55, #127
  static inicio + #56, #127
  static inicio + #57, #127
  static inicio + #58, #127
  static inicio + #59, #127
  static inicio + #60, #127
  static inicio + #61, #127
  static inicio + #62, #127
  static inicio + #63, #127
  static inicio + #64, #127
  static inicio + #65, #127
  static inicio + #66, #127
  static inicio + #67, #127
  static inicio + #68, #127
  static inicio + #69, #127
  static inicio + #70, #127
  static inicio + #71, #127
  static inicio + #72, #127
  static inicio + #73, #127
  static inicio + #74, #127
  static inicio + #75, #127
  static inicio + #76, #127
  static inicio + #77, #127
  static inicio + #78, #127
  static inicio + #79, #94

  ;Linha 2
  static inicio + #80, #94
  static inicio + #81, #127
  static inicio + #82, #127
  static inicio + #83, #127
  static inicio + #84, #127
  static inicio + #85, #127
  static inicio + #86, #127
  static inicio + #87, #127
  static inicio + #88, #127
  static inicio + #89, #127
  static inicio + #90, #127
  static inicio + #91, #127
  static inicio + #92, #127
  static inicio + #93, #127
  static inicio + #94, #127
  static inicio + #95, #127
  static inicio + #96, #127
  static inicio + #97, #127
  static inicio + #98, #127
  static inicio + #99, #127
  static inicio + #100, #127
  static inicio + #101, #127
  static inicio + #102, #127
  static inicio + #103, #127
  static inicio + #104, #127
  static inicio + #105, #127
  static inicio + #106, #127
  static inicio + #107, #127
  static inicio + #108, #127
  static inicio + #109, #127
  static inicio + #110, #127
  static inicio + #111, #127
  static inicio + #112, #127
  static inicio + #113, #127
  static inicio + #114, #127
  static inicio + #115, #3967
  static inicio + #116, #3967
  static inicio + #117, #3967
  static inicio + #118, #127
  static inicio + #119, #94

  ;Linha 3
  static inicio + #120, #94
  static inicio + #121, #127
  static inicio + #122, #127
  static inicio + #123, #2429
  static inicio + #124, #2429
  static inicio + #125, #127
  static inicio + #126, #2429
  static inicio + #127, #2429
  static inicio + #128, #127
  static inicio + #129, #127
  static inicio + #130, #2429
  static inicio + #131, #2429
  static inicio + #132, #127
  static inicio + #133, #127
  static inicio + #134, #127
  static inicio + #135, #2429
  static inicio + #136, #2429
  static inicio + #137, #2429
  static inicio + #138, #127
  static inicio + #139, #127
  static inicio + #140, #2429
  static inicio + #141, #127
  static inicio + #142, #127
  static inicio + #143, #2429
  static inicio + #144, #2429
  static inicio + #145, #127
  static inicio + #146, #127
  static inicio + #147, #2429
  static inicio + #148, #127
  static inicio + #149, #127
  static inicio + #150, #127
  static inicio + #151, #127
  static inicio + #152, #127
  static inicio + #153, #127
  static inicio + #154, #127
  static inicio + #155, #3967
  static inicio + #156, #3967
  static inicio + #157, #3967
  static inicio + #158, #127
  static inicio + #159, #94

  ;Linha 4
  static inicio + #160, #94
  static inicio + #161, #127
  static inicio + #162, #127
  static inicio + #163, #2429
  static inicio + #164, #127
  static inicio + #165, #2429
  static inicio + #166, #127
  static inicio + #167, #2429
  static inicio + #168, #127
  static inicio + #169, #2429
  static inicio + #170, #127
  static inicio + #171, #127
  static inicio + #172, #2429
  static inicio + #173, #127
  static inicio + #174, #2429
  static inicio + #175, #2429
  static inicio + #176, #127
  static inicio + #177, #127
  static inicio + #178, #2429
  static inicio + #179, #127
  static inicio + #180, #3967
  static inicio + #181, #127
  static inicio + #182, #2429
  static inicio + #183, #127
  static inicio + #184, #127
  static inicio + #185, #2429
  static inicio + #186, #127
  static inicio + #187, #2429
  static inicio + #188, #127
  static inicio + #189, #127
  static inicio + #190, #2429
  static inicio + #191, #2429
  static inicio + #192, #2429
  static inicio + #193, #2429
  static inicio + #194, #127
  static inicio + #195, #3967
  static inicio + #196, #127
  static inicio + #197, #3967
  static inicio + #198, #127
  static inicio + #199, #94

  ;Linha 5
  static inicio + #200, #94
  static inicio + #201, #127
  static inicio + #202, #127
  static inicio + #203, #2429
  static inicio + #204, #127
  static inicio + #205, #2429
  static inicio + #206, #127
  static inicio + #207, #2429
  static inicio + #208, #127
  static inicio + #209, #2429
  static inicio + #210, #127
  static inicio + #211, #127
  static inicio + #212, #2429
  static inicio + #213, #127
  static inicio + #214, #2429
  static inicio + #215, #2429
  static inicio + #216, #127
  static inicio + #217, #127
  static inicio + #218, #2429
  static inicio + #219, #127
  static inicio + #220, #2429
  static inicio + #221, #127
  static inicio + #222, #2429
  static inicio + #223, #127
  static inicio + #224, #127
  static inicio + #225, #2429
  static inicio + #226, #127
  static inicio + #227, #127
  static inicio + #228, #127
  static inicio + #229, #2429
  static inicio + #230, #2429
  static inicio + #231, #127
  static inicio + #232, #127
  static inicio + #233, #127
  static inicio + #234, #127
  static inicio + #235, #3967
  static inicio + #236, #3967
  static inicio + #237, #3967
  static inicio + #238, #127
  static inicio + #239, #94

  ;Linha 6
  static inicio + #240, #94
  static inicio + #241, #3967
  static inicio + #242, #127
  static inicio + #243, #2429
  static inicio + #244, #127
  static inicio + #245, #2429
  static inicio + #246, #127
  static inicio + #247, #2429
  static inicio + #248, #127
  static inicio + #249, #2429
  static inicio + #250, #2429
  static inicio + #251, #2429
  static inicio + #252, #2429
  static inicio + #253, #127
  static inicio + #254, #2429
  static inicio + #255, #2429
  static inicio + #256, #127
  static inicio + #257, #127
  static inicio + #258, #2429
  static inicio + #259, #127
  static inicio + #260, #2429
  static inicio + #261, #127
  static inicio + #262, #2429
  static inicio + #263, #127
  static inicio + #264, #127
  static inicio + #265, #2429
  static inicio + #266, #127
  static inicio + #267, #127
  static inicio + #268, #127
  static inicio + #269, #127
  static inicio + #270, #2429
  static inicio + #271, #2429
  static inicio + #272, #2429
  static inicio + #273, #2429
  static inicio + #274, #127
  static inicio + #275, #127
  static inicio + #276, #127
  static inicio + #277, #127
  static inicio + #278, #127
  static inicio + #279, #94

  ;Linha 7
  static inicio + #280, #94
  static inicio + #281, #3967
  static inicio + #282, #127
  static inicio + #283, #2429
  static inicio + #284, #127
  static inicio + #285, #127
  static inicio + #286, #127
  static inicio + #287, #2429
  static inicio + #288, #127
  static inicio + #289, #2429
  static inicio + #290, #127
  static inicio + #291, #127
  static inicio + #292, #2429
  static inicio + #293, #127
  static inicio + #294, #2429
  static inicio + #295, #2429
  static inicio + #296, #2429
  static inicio + #297, #2429
  static inicio + #298, #127
  static inicio + #299, #127
  static inicio + #300, #2429
  static inicio + #301, #127
  static inicio + #302, #2429
  static inicio + #303, #127
  static inicio + #304, #127
  static inicio + #305, #2429
  static inicio + #306, #127
  static inicio + #307, #127
  static inicio + #308, #127
  static inicio + #309, #127
  static inicio + #310, #3967
  static inicio + #311, #127
  static inicio + #312, #127
  static inicio + #313, #2429
  static inicio + #314, #2429
  static inicio + #315, #127
  static inicio + #316, #127
  static inicio + #317, #127
  static inicio + #318, #127
  static inicio + #319, #94

  ;Linha 8
  static inicio + #320, #94
  static inicio + #321, #3967
  static inicio + #322, #127
  static inicio + #323, #2429
  static inicio + #324, #127
  static inicio + #325, #127
  static inicio + #326, #127
  static inicio + #327, #2429
  static inicio + #328, #127
  static inicio + #329, #2429
  static inicio + #330, #127
  static inicio + #331, #127
  static inicio + #332, #2429
  static inicio + #333, #127
  static inicio + #334, #2429
  static inicio + #335, #2429
  static inicio + #336, #127
  static inicio + #337, #2429
  static inicio + #338, #2429
  static inicio + #339, #127
  static inicio + #340, #2429
  static inicio + #341, #127
  static inicio + #342, #127
  static inicio + #343, #2429
  static inicio + #344, #2429
  static inicio + #345, #127
  static inicio + #346, #127
  static inicio + #347, #127
  static inicio + #348, #127
  static inicio + #349, #127
  static inicio + #350, #2429
  static inicio + #351, #2429
  static inicio + #352, #2429
  static inicio + #353, #2429
  static inicio + #354, #127
  static inicio + #355, #127
  static inicio + #356, #127
  static inicio + #357, #127
  static inicio + #358, #127
  static inicio + #359, #94

  ;Linha 9
  static inicio + #360, #94
  static inicio + #361, #3967
  static inicio + #362, #127
  static inicio + #363, #127
  static inicio + #364, #127
  static inicio + #365, #127
  static inicio + #366, #127
  static inicio + #367, #127
  static inicio + #368, #127
  static inicio + #369, #127
  static inicio + #370, #127
  static inicio + #371, #127
  static inicio + #372, #127
  static inicio + #373, #127
  static inicio + #374, #127
  static inicio + #375, #127
  static inicio + #376, #127
  static inicio + #377, #127
  static inicio + #378, #127
  static inicio + #379, #127
  static inicio + #380, #127
  static inicio + #381, #127
  static inicio + #382, #127
  static inicio + #383, #127
  static inicio + #384, #127
  static inicio + #385, #127
  static inicio + #386, #127
  static inicio + #387, #127
  static inicio + #388, #127
  static inicio + #389, #127
  static inicio + #390, #127
  static inicio + #391, #127
  static inicio + #392, #127
  static inicio + #393, #127
  static inicio + #394, #127
  static inicio + #395, #127
  static inicio + #396, #127
  static inicio + #397, #127
  static inicio + #398, #127
  static inicio + #399, #94

  ;Linha 10
  static inicio + #400, #94
  static inicio + #401, #3967
  static inicio + #402, #127
  static inicio + #403, #127
  static inicio + #404, #127
  static inicio + #405, #127
  static inicio + #406, #127
  static inicio + #407, #127
  static inicio + #408, #127
  static inicio + #409, #127
  static inicio + #410, #127
  static inicio + #411, #127
  static inicio + #412, #3967
  static inicio + #413, #127
  static inicio + #414, #127
  static inicio + #415, #127
  static inicio + #416, #127
  static inicio + #417, #127
  static inicio + #418, #127
  static inicio + #419, #127
  static inicio + #420, #127
  static inicio + #421, #127
  static inicio + #422, #127
  static inicio + #423, #127
  static inicio + #424, #127
  static inicio + #425, #127
  static inicio + #426, #127
  static inicio + #427, #127
  static inicio + #428, #127
  static inicio + #429, #127
  static inicio + #430, #127
  static inicio + #431, #127
  static inicio + #432, #127
  static inicio + #433, #127
  static inicio + #434, #127
  static inicio + #435, #127
  static inicio + #436, #127
  static inicio + #437, #127
  static inicio + #438, #127
  static inicio + #439, #94

  ;Linha 11
  static inicio + #440, #94
  static inicio + #441, #3967
  static inicio + #442, #127
  static inicio + #443, #127
  static inicio + #444, #127
  static inicio + #445, #127
  static inicio + #446, #127
  static inicio + #447, #127
  static inicio + #448, #127
  static inicio + #449, #127
  static inicio + #450, #127
  static inicio + #451, #127
  static inicio + #452, #127
  static inicio + #453, #127
  static inicio + #454, #127
  static inicio + #455, #127
  static inicio + #456, #127
  static inicio + #457, #127
  static inicio + #458, #127
  static inicio + #459, #127
  static inicio + #460, #127
  static inicio + #461, #127
  static inicio + #462, #127
  static inicio + #463, #127
  static inicio + #464, #127
  static inicio + #465, #127
  static inicio + #466, #127
  static inicio + #467, #127
  static inicio + #468, #127
  static inicio + #469, #127
  static inicio + #470, #127
  static inicio + #471, #127
  static inicio + #472, #127
  static inicio + #473, #127
  static inicio + #474, #127
  static inicio + #475, #127
  static inicio + #476, #127
  static inicio + #477, #127
  static inicio + #478, #127
  static inicio + #479, #94

  ;Linha 12
  static inicio + #480, #94
  static inicio + #481, #127
  static inicio + #482, #127
  static inicio + #483, #127
  static inicio + #484, #127
  static inicio + #485, #127
  static inicio + #486, #2429
  static inicio + #487, #2429
  static inicio + #488, #3967
  static inicio + #489, #2429
  static inicio + #490, #2429
  static inicio + #491, #127
  static inicio + #492, #2429
  static inicio + #493, #2429
  static inicio + #494, #2429
  static inicio + #495, #127
  static inicio + #496, #2429
  static inicio + #497, #2429
  static inicio + #498, #127
  static inicio + #499, #2429
  static inicio + #500, #2429
  static inicio + #501, #127
  static inicio + #502, #3967
  static inicio + #503, #2429
  static inicio + #504, #2429
  static inicio + #505, #127
  static inicio + #506, #127
  static inicio + #507, #127
  static inicio + #508, #2429
  static inicio + #509, #2429
  static inicio + #510, #2429
  static inicio + #511, #127
  static inicio + #512, #127
  static inicio + #513, #2429
  static inicio + #514, #127
  static inicio + #515, #2429
  static inicio + #516, #127
  static inicio + #517, #127
  static inicio + #518, #127
  static inicio + #519, #94

  ;Linha 13
  static inicio + #520, #94
  static inicio + #521, #127
  static inicio + #522, #127
  static inicio + #523, #127
  static inicio + #524, #127
  static inicio + #525, #127
  static inicio + #526, #2429
  static inicio + #527, #127
  static inicio + #528, #2429
  static inicio + #529, #127
  static inicio + #530, #2429
  static inicio + #531, #127
  static inicio + #532, #2429
  static inicio + #533, #127
  static inicio + #534, #127
  static inicio + #535, #127
  static inicio + #536, #2429
  static inicio + #537, #127
  static inicio + #538, #2429
  static inicio + #539, #127
  static inicio + #540, #2429
  static inicio + #541, #127
  static inicio + #542, #2429
  static inicio + #543, #127
  static inicio + #544, #127
  static inicio + #545, #2429
  static inicio + #546, #127
  static inicio + #547, #2429
  static inicio + #548, #2429
  static inicio + #549, #127
  static inicio + #550, #127
  static inicio + #551, #2429
  static inicio + #552, #127
  static inicio + #553, #2429
  static inicio + #554, #127
  static inicio + #555, #2429
  static inicio + #556, #127
  static inicio + #557, #127
  static inicio + #558, #127
  static inicio + #559, #94

  ;Linha 14
  static inicio + #560, #94
  static inicio + #561, #127
  static inicio + #562, #127
  static inicio + #563, #127
  static inicio + #564, #127
  static inicio + #565, #127
  static inicio + #566, #2429
  static inicio + #567, #127
  static inicio + #568, #2429
  static inicio + #569, #127
  static inicio + #570, #2429
  static inicio + #571, #127
  static inicio + #572, #2429
  static inicio + #573, #2429
  static inicio + #574, #127
  static inicio + #575, #127
  static inicio + #576, #2429
  static inicio + #577, #127
  static inicio + #578, #2429
  static inicio + #579, #127
  static inicio + #580, #2429
  static inicio + #581, #127
  static inicio + #582, #2429
  static inicio + #583, #127
  static inicio + #584, #127
  static inicio + #585, #2429
  static inicio + #586, #127
  static inicio + #587, #2429
  static inicio + #588, #2429
  static inicio + #589, #127
  static inicio + #590, #127
  static inicio + #591, #2429
  static inicio + #592, #127
  static inicio + #593, #2429
  static inicio + #594, #127
  static inicio + #595, #2429
  static inicio + #596, #127
  static inicio + #597, #127
  static inicio + #598, #127
  static inicio + #599, #94

  ;Linha 15
  static inicio + #600, #95
  static inicio + #601, #127
  static inicio + #602, #127
  static inicio + #603, #127
  static inicio + #604, #127
  static inicio + #605, #127
  static inicio + #606, #2429
  static inicio + #607, #127
  static inicio + #608, #2429
  static inicio + #609, #127
  static inicio + #610, #2429
  static inicio + #611, #127
  static inicio + #612, #2429
  static inicio + #613, #2429
  static inicio + #614, #127
  static inicio + #615, #127
  static inicio + #616, #2429
  static inicio + #617, #127
  static inicio + #618, #2429
  static inicio + #619, #127
  static inicio + #620, #2429
  static inicio + #621, #127
  static inicio + #622, #2429
  static inicio + #623, #127
  static inicio + #624, #127
  static inicio + #625, #2429
  static inicio + #626, #127
  static inicio + #627, #2429
  static inicio + #628, #2429
  static inicio + #629, #127
  static inicio + #630, #127
  static inicio + #631, #2429
  static inicio + #632, #127
  static inicio + #633, #127
  static inicio + #634, #2429
  static inicio + #635, #127
  static inicio + #636, #127
  static inicio + #637, #127
  static inicio + #638, #127
  static inicio + #639, #95

  ;Linha 16
  static inicio + #640, #95
  static inicio + #641, #127
  static inicio + #642, #127
  static inicio + #643, #127
  static inicio + #644, #127
  static inicio + #645, #127
  static inicio + #646, #2429
  static inicio + #647, #127
  static inicio + #648, #127
  static inicio + #649, #127
  static inicio + #650, #2429
  static inicio + #651, #127
  static inicio + #652, #2429
  static inicio + #653, #127
  static inicio + #654, #127
  static inicio + #655, #127
  static inicio + #656, #2429
  static inicio + #657, #127
  static inicio + #658, #127
  static inicio + #659, #127
  static inicio + #660, #2429
  static inicio + #661, #127
  static inicio + #662, #2429
  static inicio + #663, #127
  static inicio + #664, #127
  static inicio + #665, #2429
  static inicio + #666, #127
  static inicio + #667, #2429
  static inicio + #668, #2429
  static inicio + #669, #2429
  static inicio + #670, #2429
  static inicio + #671, #127
  static inicio + #672, #127
  static inicio + #673, #127
  static inicio + #674, #2429
  static inicio + #675, #127
  static inicio + #676, #127
  static inicio + #677, #127
  static inicio + #678, #127
  static inicio + #679, #95

  ;Linha 17
  static inicio + #680, #95
  static inicio + #681, #127
  static inicio + #682, #127
  static inicio + #683, #127
  static inicio + #684, #127
  static inicio + #685, #127
  static inicio + #686, #2429
  static inicio + #687, #127
  static inicio + #688, #127
  static inicio + #689, #127
  static inicio + #690, #2429
  static inicio + #691, #127
  static inicio + #692, #2429
  static inicio + #693, #2429
  static inicio + #694, #2429
  static inicio + #695, #127
  static inicio + #696, #2429
  static inicio + #697, #127
  static inicio + #698, #127
  static inicio + #699, #127
  static inicio + #700, #2429
  static inicio + #701, #127
  static inicio + #702, #3967
  static inicio + #703, #2429
  static inicio + #704, #2429
  static inicio + #705, #127
  static inicio + #706, #127
  static inicio + #707, #2429
  static inicio + #708, #2429
  static inicio + #709, #127
  static inicio + #710, #2429
  static inicio + #711, #2429
  static inicio + #712, #127
  static inicio + #713, #127
  static inicio + #714, #2429
  static inicio + #715, #127
  static inicio + #716, #127
  static inicio + #717, #127
  static inicio + #718, #127
  static inicio + #719, #95

  ;Linha 18
  static inicio + #720, #95
  static inicio + #721, #127
  static inicio + #722, #127
  static inicio + #723, #127
  static inicio + #724, #127
  static inicio + #725, #127
  static inicio + #726, #127
  static inicio + #727, #127
  static inicio + #728, #127
  static inicio + #729, #127
  static inicio + #730, #127
  static inicio + #731, #127
  static inicio + #732, #127
  static inicio + #733, #127
  static inicio + #734, #127
  static inicio + #735, #127
  static inicio + #736, #127
  static inicio + #737, #127
  static inicio + #738, #127
  static inicio + #739, #127
  static inicio + #740, #127
  static inicio + #741, #127
  static inicio + #742, #127
  static inicio + #743, #127
  static inicio + #744, #127
  static inicio + #745, #127
  static inicio + #746, #127
  static inicio + #747, #127
  static inicio + #748, #127
  static inicio + #749, #127
  static inicio + #750, #127
  static inicio + #751, #127
  static inicio + #752, #127
  static inicio + #753, #127
  static inicio + #754, #127
  static inicio + #755, #127
  static inicio + #756, #127
  static inicio + #757, #127
  static inicio + #758, #127
  static inicio + #759, #95

  ;Linha 19
  static inicio + #760, #95
  static inicio + #761, #127
  static inicio + #762, #127
  static inicio + #763, #127
  static inicio + #764, #127
  static inicio + #765, #127
  static inicio + #766, #127
  static inicio + #767, #127
  static inicio + #768, #127
  static inicio + #769, #127
  static inicio + #770, #127
  static inicio + #771, #127
  static inicio + #772, #127
  static inicio + #773, #127
  static inicio + #774, #127
  static inicio + #775, #127
  static inicio + #776, #127
  static inicio + #777, #127
  static inicio + #778, #127
  static inicio + #779, #127
  static inicio + #780, #127
  static inicio + #781, #127
  static inicio + #782, #127
  static inicio + #783, #127
  static inicio + #784, #127
  static inicio + #785, #127
  static inicio + #786, #127
  static inicio + #787, #127
  static inicio + #788, #127
  static inicio + #789, #127
  static inicio + #790, #127
  static inicio + #791, #127
  static inicio + #792, #127
  static inicio + #793, #127
  static inicio + #794, #127
  static inicio + #795, #127
  static inicio + #796, #127
  static inicio + #797, #127
  static inicio + #798, #127
  static inicio + #799, #95

  ;Linha 20
  static inicio + #800, #95
  static inicio + #801, #127
  static inicio + #802, #127
  static inicio + #803, #127
  static inicio + #804, #127
  static inicio + #805, #127
  static inicio + #806, #127
  static inicio + #807, #127
  static inicio + #808, #127
  static inicio + #809, #127
  static inicio + #810, #127
  static inicio + #811, #127
  static inicio + #812, #127
  static inicio + #813, #127
  static inicio + #814, #127
  static inicio + #815, #127
  static inicio + #816, #127
  static inicio + #817, #127
  static inicio + #818, #127
  static inicio + #819, #127
  static inicio + #820, #127
  static inicio + #821, #127
  static inicio + #822, #127
  static inicio + #823, #127
  static inicio + #824, #127
  static inicio + #825, #127
  static inicio + #826, #127
  static inicio + #827, #127
  static inicio + #828, #127
  static inicio + #829, #127
  static inicio + #830, #127
  static inicio + #831, #127
  static inicio + #832, #127
  static inicio + #833, #127
  static inicio + #834, #127
  static inicio + #835, #127
  static inicio + #836, #127
  static inicio + #837, #127
  static inicio + #838, #127
  static inicio + #839, #95

  ;Linha 21
  static inicio + #840, #95
  static inicio + #841, #127
  static inicio + #842, #127
  static inicio + #843, #127
  static inicio + #844, #127
  static inicio + #845, #127
  static inicio + #846, #127
  static inicio + #847, #127
  static inicio + #848, #2349
  static inicio + #849, #2349
  static inicio + #850, #2349
  static inicio + #851, #2349
  static inicio + #852, #2349
  static inicio + #853, #2349
  static inicio + #854, #2349
  static inicio + #855, #2349
  static inicio + #856, #2349
  static inicio + #857, #2349
  static inicio + #858, #2349
  static inicio + #859, #2349
  static inicio + #860, #2349
  static inicio + #861, #2349
  static inicio + #862, #2349
  static inicio + #863, #2349
  static inicio + #864, #2349
  static inicio + #865, #2349
  static inicio + #866, #2349
  static inicio + #867, #2349
  static inicio + #868, #2349
  static inicio + #869, #2349
  static inicio + #870, #2349
  static inicio + #871, #2349
  static inicio + #872, #2349
  static inicio + #873, #127
  static inicio + #874, #127
  static inicio + #875, #127
  static inicio + #876, #127
  static inicio + #877, #127
  static inicio + #878, #127
  static inicio + #879, #95

  ;Linha 22
  static inicio + #880, #95
  static inicio + #881, #127
  static inicio + #882, #127
  static inicio + #883, #2428
  static inicio + #884, #2428
  static inicio + #885, #2428
  static inicio + #886, #127
  static inicio + #887, #127
  static inicio + #888, #127
  static inicio + #889, #127
  static inicio + #890, #127
  static inicio + #891, #127
  static inicio + #892, #127
  static inicio + #893, #127
  static inicio + #894, #127
  static inicio + #895, #127
  static inicio + #896, #127
  static inicio + #897, #127
  static inicio + #898, #127
  static inicio + #899, #127
  static inicio + #900, #127
  static inicio + #901, #127
  static inicio + #902, #127
  static inicio + #903, #127
  static inicio + #904, #2431
  static inicio + #905, #2431
  static inicio + #906, #127
  static inicio + #907, #127
  static inicio + #908, #127
  static inicio + #909, #127
  static inicio + #910, #127
  static inicio + #911, #127
  static inicio + #912, #127
  static inicio + #913, #127
  static inicio + #914, #127
  static inicio + #915, #127
  static inicio + #916, #127
  static inicio + #917, #127
  static inicio + #918, #127
  static inicio + #919, #95

  ;Linha 23
  static inicio + #920, #95
  static inicio + #921, #127
  static inicio + #922, #2428
  static inicio + #923, #124
  static inicio + #924, #2940
  static inicio + #925, #124
  static inicio + #926, #2428
  static inicio + #927, #127
  static inicio + #928, #127
  static inicio + #929, #127
  static inicio + #930, #2416
  static inicio + #931, #2418
  static inicio + #932, #2405
  static inicio + #933, #2419
  static inicio + #934, #2419
  static inicio + #935, #2431
  static inicio + #936, #2397
  static inicio + #937, #2405
  static inicio + #938, #2414
  static inicio + #939, #2420
  static inicio + #940, #2405
  static inicio + #941, #2418
  static inicio + #942, #2397
  static inicio + #943, #2431
  static inicio + #944, #2420
  static inicio + #945, #2415
  static inicio + #946, #2431
  static inicio + #947, #2416
  static inicio + #948, #2412
  static inicio + #949, #2401
  static inicio + #950, #2425
  static inicio + #951, #2431
  static inicio + #952, #127
  static inicio + #953, #2684
  static inicio + #954, #2684
  static inicio + #955, #2684
  static inicio + #956, #2684
  static inicio + #957, #2684
  static inicio + #958, #2684
  static inicio + #959, #95

  ;Linha 24
  static inicio + #960, #95
  static inicio + #961, #2428
  static inicio + #962, #2940
  static inicio + #963, #127
  static inicio + #964, #2940
  static inicio + #965, #127
  static inicio + #966, #2428
  static inicio + #967, #127
  static inicio + #968, #127
  static inicio + #969, #127
  static inicio + #970, #127
  static inicio + #971, #127
  static inicio + #972, #127
  static inicio + #973, #127
  static inicio + #974, #127
  static inicio + #975, #127
  static inicio + #976, #127
  static inicio + #977, #127
  static inicio + #978, #127
  static inicio + #979, #127
  static inicio + #980, #127
  static inicio + #981, #127
  static inicio + #982, #127
  static inicio + #983, #127
  static inicio + #984, #127
  static inicio + #985, #127
  static inicio + #986, #127
  static inicio + #987, #127
  static inicio + #988, #127
  static inicio + #989, #127
  static inicio + #990, #127
  static inicio + #991, #127
  static inicio + #992, #127
  static inicio + #993, #2684
  static inicio + #994, #2684
  static inicio + #995, #2684
  static inicio + #996, #2684
  static inicio + #997, #2684
  static inicio + #998, #2684
  static inicio + #999, #95

  ;Linha 25
  static inicio + #1000, #95
  static inicio + #1001, #127
  static inicio + #1002, #2428
  static inicio + #1003, #2940
  static inicio + #1004, #2940
  static inicio + #1005, #2428
  static inicio + #1006, #2428
  static inicio + #1007, #127
  static inicio + #1008, #2349
  static inicio + #1009, #2349
  static inicio + #1010, #2349
  static inicio + #1011, #2349
  static inicio + #1012, #2349
  static inicio + #1013, #2349
  static inicio + #1014, #2349
  static inicio + #1015, #2349
  static inicio + #1016, #2349
  static inicio + #1017, #2349
  static inicio + #1018, #2349
  static inicio + #1019, #2349
  static inicio + #1020, #2349
  static inicio + #1021, #2349
  static inicio + #1022, #2349
  static inicio + #1023, #2349
  static inicio + #1024, #2349
  static inicio + #1025, #2349
  static inicio + #1026, #2349
  static inicio + #1027, #2349
  static inicio + #1028, #2349
  static inicio + #1029, #2349
  static inicio + #1030, #2349
  static inicio + #1031, #2349
  static inicio + #1032, #2349
  static inicio + #1033, #127
  static inicio + #1034, #2684
  static inicio + #1035, #124
  static inicio + #1036, #2684
  static inicio + #1037, #2684
  static inicio + #1038, #127
  static inicio + #1039, #95

  ;Linha 26
  static inicio + #1040, #95
  static inicio + #1041, #2684
  static inicio + #1042, #127
  static inicio + #1043, #2428
  static inicio + #1044, #2428
  static inicio + #1045, #2428
  static inicio + #1046, #2684
  static inicio + #1047, #127
  static inicio + #1048, #127
  static inicio + #1049, #127
  static inicio + #1050, #127
  static inicio + #1051, #127
  static inicio + #1052, #127
  static inicio + #1053, #127
  static inicio + #1054, #127
  static inicio + #1055, #127
  static inicio + #1056, #127
  static inicio + #1057, #127
  static inicio + #1058, #127
  static inicio + #1059, #127
  static inicio + #1060, #127
  static inicio + #1061, #127
  static inicio + #1062, #127
  static inicio + #1063, #127
  static inicio + #1064, #127
  static inicio + #1065, #127
  static inicio + #1066, #127
  static inicio + #1067, #127
  static inicio + #1068, #127
  static inicio + #1069, #127
  static inicio + #1070, #127
  static inicio + #1071, #127
  static inicio + #1072, #127
  static inicio + #1073, #127
  static inicio + #1074, #2684
  static inicio + #1075, #124
  static inicio + #1076, #2684
  static inicio + #1077, #2684
  static inicio + #1078, #127
  static inicio + #1079, #95

  ;Linha 27
  static inicio + #1080, #95
  static inicio + #1081, #127
  static inicio + #1082, #2684
  static inicio + #1083, #2684
  static inicio + #1084, #2684
  static inicio + #1085, #2684
  static inicio + #1086, #127
  static inicio + #1087, #127
  static inicio + #1088, #127
  static inicio + #1089, #127
  static inicio + #1090, #127
  static inicio + #1091, #127
  static inicio + #1092, #127
  static inicio + #1093, #127
  static inicio + #1094, #127
  static inicio + #1095, #127
  static inicio + #1096, #127
  static inicio + #1097, #127
  static inicio + #1098, #127
  static inicio + #1099, #127
  static inicio + #1100, #127
  static inicio + #1101, #127
  static inicio + #1102, #127
  static inicio + #1103, #127
  static inicio + #1104, #127
  static inicio + #1105, #127
  static inicio + #1106, #127
  static inicio + #1107, #127
  static inicio + #1108, #127
  static inicio + #1109, #127
  static inicio + #1110, #127
  static inicio + #1111, #127
  static inicio + #1112, #127
  static inicio + #1113, #127
  static inicio + #1114, #2684
  static inicio + #1115, #124
  static inicio + #1116, #2684
  static inicio + #1117, #2684
  static inicio + #1118, #127
  static inicio + #1119, #95

  ;Linha 28
  static inicio + #1120, #95
  static inicio + #1121, #127
  static inicio + #1122, #3967
  static inicio + #1123, #2684
  static inicio + #1124, #2684
  static inicio + #1125, #127
  static inicio + #1126, #127
  static inicio + #1127, #127
  static inicio + #1128, #127
  static inicio + #1129, #127
  static inicio + #1130, #127
  static inicio + #1131, #127
  static inicio + #1132, #127
  static inicio + #1133, #127
  static inicio + #1134, #127
  static inicio + #1135, #127
  static inicio + #1136, #127
  static inicio + #1137, #127
  static inicio + #1138, #127
  static inicio + #1139, #127
  static inicio + #1140, #127
  static inicio + #1141, #127
  static inicio + #1142, #127
  static inicio + #1143, #127
  static inicio + #1144, #127
  static inicio + #1145, #127
  static inicio + #1146, #127
  static inicio + #1147, #127
  static inicio + #1148, #127
  static inicio + #1149, #127
  static inicio + #1150, #127
  static inicio + #1151, #127
  static inicio + #1152, #127
  static inicio + #1153, #127
  static inicio + #1154, #2684
  static inicio + #1155, #2684
  static inicio + #1156, #2684
  static inicio + #1157, #2684
  static inicio + #1158, #127
  static inicio + #1159, #95

  ;Linha 29
  static inicio + #1160, #64
  static inicio + #1161, #60
  static inicio + #1162, #60
  static inicio + #1163, #60
  static inicio + #1164, #60
  static inicio + #1165, #60
  static inicio + #1166, #60
  static inicio + #1167, #60
  static inicio + #1168, #60
  static inicio + #1169, #60
  static inicio + #1170, #60
  static inicio + #1171, #60
  static inicio + #1172, #60
  static inicio + #1173, #60
  static inicio + #1174, #60
  static inicio + #1175, #60
  static inicio + #1176, #60
  static inicio + #1177, #60
  static inicio + #1178, #60
  static inicio + #1179, #60
  static inicio + #1180, #62
  static inicio + #1181, #62
  static inicio + #1182, #62
  static inicio + #1183, #62
  static inicio + #1184, #62
  static inicio + #1185, #62
  static inicio + #1186, #62
  static inicio + #1187, #62
  static inicio + #1188, #62
  static inicio + #1189, #62
  static inicio + #1190, #62
  static inicio + #1191, #62
  static inicio + #1192, #62
  static inicio + #1193, #62
  static inicio + #1194, #62
  static inicio + #1195, #62
  static inicio + #1196, #62
  static inicio + #1197, #62
  static inicio + #1198, #62
  static inicio + #1199, #64

;Function to print the start screen
printinicioScreen:
	push r0
	push r1
	push r2
	push r3

	loadn r0, #inicio
	loadn r1, #0
	loadn r2, #1200

  	printinicioScreenLoop:

    add r3,r0,r1
    loadi r3, r3
    outchar r3, r1
    inc r1
    cmp r1, r2
	jne printinicioScreenLoop

	pop r3
	pop r2
	pop r1
	pop r0

	rts
 
;screen that shows the player won the game 
telafinal_winT : var #1200
  ;Linha 0
  static telafinal_winT + #0, #64
  static telafinal_winT + #1, #60
  static telafinal_winT + #2, #60
  static telafinal_winT + #3, #60
  static telafinal_winT + #4, #60
  static telafinal_winT + #5, #60
  static telafinal_winT + #6, #60
  static telafinal_winT + #7, #60
  static telafinal_winT + #8, #60
  static telafinal_winT + #9, #60
  static telafinal_winT + #10, #60
  static telafinal_winT + #11, #60
  static telafinal_winT + #12, #60
  static telafinal_winT + #13, #60
  static telafinal_winT + #14, #60
  static telafinal_winT + #15, #60
  static telafinal_winT + #16, #60
  static telafinal_winT + #17, #60
  static telafinal_winT + #18, #60
  static telafinal_winT + #19, #60
  static telafinal_winT + #20, #62
  static telafinal_winT + #21, #62
  static telafinal_winT + #22, #62
  static telafinal_winT + #23, #62
  static telafinal_winT + #24, #62
  static telafinal_winT + #25, #62
  static telafinal_winT + #26, #62
  static telafinal_winT + #27, #62
  static telafinal_winT + #28, #62
  static telafinal_winT + #29, #62
  static telafinal_winT + #30, #62
  static telafinal_winT + #31, #62
  static telafinal_winT + #32, #62
  static telafinal_winT + #33, #62
  static telafinal_winT + #34, #62
  static telafinal_winT + #35, #62
  static telafinal_winT + #36, #62
  static telafinal_winT + #37, #62
  static telafinal_winT + #38, #62
  static telafinal_winT + #39, #64

  ;Linha 1
  static telafinal_winT + #40, #31
  static telafinal_winT + #41, #3967
  static telafinal_winT + #42, #3967
  static telafinal_winT + #43, #3967
  static telafinal_winT + #44, #3967
  static telafinal_winT + #45, #3967
  static telafinal_winT + #46, #3967
  static telafinal_winT + #47, #3967
  static telafinal_winT + #48, #3967
  static telafinal_winT + #49, #3967
  static telafinal_winT + #50, #2173
  static telafinal_winT + #51, #2173
  static telafinal_winT + #52, #2173
  static telafinal_winT + #53, #2173
  static telafinal_winT + #54, #3967
  static telafinal_winT + #55, #3967
  static telafinal_winT + #56, #3967
  static telafinal_winT + #57, #3967
  static telafinal_winT + #58, #3967
  static telafinal_winT + #59, #3967
  static telafinal_winT + #60, #3967
  static telafinal_winT + #61, #3967
  static telafinal_winT + #62, #3967
  static telafinal_winT + #63, #3967
  static telafinal_winT + #64, #3967
  static telafinal_winT + #65, #3967
  static telafinal_winT + #66, #3967
  static telafinal_winT + #67, #3967
  static telafinal_winT + #68, #3967
  static telafinal_winT + #69, #3967
  static telafinal_winT + #70, #3967
  static telafinal_winT + #71, #3967
  static telafinal_winT + #72, #3967
  static telafinal_winT + #73, #3967
  static telafinal_winT + #74, #3967
  static telafinal_winT + #75, #3967
  static telafinal_winT + #76, #3967
  static telafinal_winT + #77, #3967
  static telafinal_winT + #78, #3967
  static telafinal_winT + #79, #31

  ;Linha 2
  static telafinal_winT + #80, #31
  static telafinal_winT + #81, #3967
  static telafinal_winT + #82, #3967
  static telafinal_winT + #83, #3967
  static telafinal_winT + #84, #2173
  static telafinal_winT + #85, #2173
  static telafinal_winT + #86, #3967
  static telafinal_winT + #87, #2173
  static telafinal_winT + #88, #2173
  static telafinal_winT + #89, #2173
  static telafinal_winT + #90, #381
  static telafinal_winT + #91, #381
  static telafinal_winT + #92, #381
  static telafinal_winT + #93, #381
  static telafinal_winT + #94, #2173
  static telafinal_winT + #95, #2173
  static telafinal_winT + #96, #3967
  static telafinal_winT + #97, #3967
  static telafinal_winT + #98, #3967
  static telafinal_winT + #99, #3967
  static telafinal_winT + #100, #3967
  static telafinal_winT + #101, #3967
  static telafinal_winT + #102, #3967
  static telafinal_winT + #103, #3967
  static telafinal_winT + #104, #3967
  static telafinal_winT + #105, #3967
  static telafinal_winT + #106, #3967
  static telafinal_winT + #107, #3967
  static telafinal_winT + #108, #3967
  static telafinal_winT + #109, #3967
  static telafinal_winT + #110, #3967
  static telafinal_winT + #111, #3967
  static telafinal_winT + #112, #3967
  static telafinal_winT + #113, #3967
  static telafinal_winT + #114, #3967
  static telafinal_winT + #115, #3967
  static telafinal_winT + #116, #3967
  static telafinal_winT + #117, #3967
  static telafinal_winT + #118, #3967
  static telafinal_winT + #119, #31

  ;Linha 3
  static telafinal_winT + #120, #31
  static telafinal_winT + #121, #3967
  static telafinal_winT + #122, #3967
  static telafinal_winT + #123, #3967
  static telafinal_winT + #124, #2173
  static telafinal_winT + #125, #125
  static telafinal_winT + #126, #2173
  static telafinal_winT + #127, #125
  static telafinal_winT + #128, #2173
  static telafinal_winT + #129, #381
  static telafinal_winT + #130, #381
  static telafinal_winT + #131, #2173
  static telafinal_winT + #132, #2941
  static telafinal_winT + #133, #381
  static telafinal_winT + #134, #381
  static telafinal_winT + #135, #381
  static telafinal_winT + #136, #2173
  static telafinal_winT + #137, #3967
  static telafinal_winT + #138, #3967
  static telafinal_winT + #139, #3967
  static telafinal_winT + #140, #3967
  static telafinal_winT + #141, #3967
  static telafinal_winT + #142, #3967
  static telafinal_winT + #143, #3967
  static telafinal_winT + #144, #3967
  static telafinal_winT + #145, #3967
  static telafinal_winT + #146, #3967
  static telafinal_winT + #147, #3967
  static telafinal_winT + #148, #3967
  static telafinal_winT + #149, #3967
  static telafinal_winT + #150, #3967
  static telafinal_winT + #151, #3967
  static telafinal_winT + #152, #3967
  static telafinal_winT + #153, #3967
  static telafinal_winT + #154, #3967
  static telafinal_winT + #155, #3967
  static telafinal_winT + #156, #3967
  static telafinal_winT + #157, #3967
  static telafinal_winT + #158, #3967
  static telafinal_winT + #159, #31

  ;Linha 4
  static telafinal_winT + #160, #31
  static telafinal_winT + #161, #3967
  static telafinal_winT + #162, #3967
  static telafinal_winT + #163, #3967
  static telafinal_winT + #164, #3967
  static telafinal_winT + #165, #2173
  static telafinal_winT + #166, #125
  static telafinal_winT + #167, #125
  static telafinal_winT + #168, #2173
  static telafinal_winT + #169, #381
  static telafinal_winT + #170, #2173
  static telafinal_winT + #171, #125
  static telafinal_winT + #172, #125
  static telafinal_winT + #173, #2173
  static telafinal_winT + #174, #381
  static telafinal_winT + #175, #381
  static telafinal_winT + #176, #381
  static telafinal_winT + #177, #2173
  static telafinal_winT + #178, #3967
  static telafinal_winT + #179, #3967
  static telafinal_winT + #180, #3967
  static telafinal_winT + #181, #3967
  static telafinal_winT + #182, #3967
  static telafinal_winT + #183, #3967
  static telafinal_winT + #184, #125
  static telafinal_winT + #185, #3967
  static telafinal_winT + #186, #125
  static telafinal_winT + #187, #3967
  static telafinal_winT + #188, #3967
  static telafinal_winT + #189, #125
  static telafinal_winT + #190, #125
  static telafinal_winT + #191, #3967
  static telafinal_winT + #192, #3967
  static telafinal_winT + #193, #125
  static telafinal_winT + #194, #3967
  static telafinal_winT + #195, #3967
  static telafinal_winT + #196, #125
  static telafinal_winT + #197, #3967
  static telafinal_winT + #198, #3967
  static telafinal_winT + #199, #31

  ;Linha 5
  static telafinal_winT + #200, #31
  static telafinal_winT + #201, #3967
  static telafinal_winT + #202, #3967
  static telafinal_winT + #203, #3967
  static telafinal_winT + #204, #2173
  static telafinal_winT + #205, #2173
  static telafinal_winT + #206, #2173
  static telafinal_winT + #207, #2173
  static telafinal_winT + #208, #2173
  static telafinal_winT + #209, #3967
  static telafinal_winT + #210, #3967
  static telafinal_winT + #211, #3967
  static telafinal_winT + #212, #3967
  static telafinal_winT + #213, #3967
  static telafinal_winT + #214, #3967
  static telafinal_winT + #215, #381
  static telafinal_winT + #216, #381
  static telafinal_winT + #217, #381
  static telafinal_winT + #218, #2173
  static telafinal_winT + #219, #3967
  static telafinal_winT + #220, #3967
  static telafinal_winT + #221, #3967
  static telafinal_winT + #222, #3967
  static telafinal_winT + #223, #3967
  static telafinal_winT + #224, #125
  static telafinal_winT + #225, #3967
  static telafinal_winT + #226, #125
  static telafinal_winT + #227, #3967
  static telafinal_winT + #228, #125
  static telafinal_winT + #229, #3967
  static telafinal_winT + #230, #3967
  static telafinal_winT + #231, #125
  static telafinal_winT + #232, #3967
  static telafinal_winT + #233, #125
  static telafinal_winT + #234, #3967
  static telafinal_winT + #235, #3967
  static telafinal_winT + #236, #125
  static telafinal_winT + #237, #3967
  static telafinal_winT + #238, #3967
  static telafinal_winT + #239, #31

  ;Linha 6
  static telafinal_winT + #240, #31
  static telafinal_winT + #241, #3967
  static telafinal_winT + #242, #3967
  static telafinal_winT + #243, #2173
  static telafinal_winT + #244, #125
  static telafinal_winT + #245, #125
  static telafinal_winT + #246, #125
  static telafinal_winT + #247, #125
  static telafinal_winT + #248, #2173
  static telafinal_winT + #249, #3967
  static telafinal_winT + #250, #3967
  static telafinal_winT + #251, #3967
  static telafinal_winT + #252, #3967
  static telafinal_winT + #253, #3967
  static telafinal_winT + #254, #3967
  static telafinal_winT + #255, #3967
  static telafinal_winT + #256, #381
  static telafinal_winT + #257, #381
  static telafinal_winT + #258, #2173
  static telafinal_winT + #259, #3967
  static telafinal_winT + #260, #3967
  static telafinal_winT + #261, #3967
  static telafinal_winT + #262, #3967
  static telafinal_winT + #263, #3967
  static telafinal_winT + #264, #3967
  static telafinal_winT + #265, #125
  static telafinal_winT + #266, #3967
  static telafinal_winT + #267, #3967
  static telafinal_winT + #268, #125
  static telafinal_winT + #269, #3967
  static telafinal_winT + #270, #3967
  static telafinal_winT + #271, #125
  static telafinal_winT + #272, #3967
  static telafinal_winT + #273, #125
  static telafinal_winT + #274, #3967
  static telafinal_winT + #275, #3967
  static telafinal_winT + #276, #125
  static telafinal_winT + #277, #3967
  static telafinal_winT + #278, #3967
  static telafinal_winT + #279, #31

  ;Linha 7
  static telafinal_winT + #280, #31
  static telafinal_winT + #281, #3967
  static telafinal_winT + #282, #3967
  static telafinal_winT + #283, #2173
  static telafinal_winT + #284, #125
  static telafinal_winT + #285, #2173
  static telafinal_winT + #286, #125
  static telafinal_winT + #287, #125
  static telafinal_winT + #288, #2173
  static telafinal_winT + #289, #125
  static telafinal_winT + #290, #125
  static telafinal_winT + #291, #3453
  static telafinal_winT + #292, #125
  static telafinal_winT + #293, #125
  static telafinal_winT + #294, #3453
  static telafinal_winT + #295, #3967
  static telafinal_winT + #296, #3967
  static telafinal_winT + #297, #381
  static telafinal_winT + #298, #381
  static telafinal_winT + #299, #2173
  static telafinal_winT + #300, #3967
  static telafinal_winT + #301, #3967
  static telafinal_winT + #302, #3967
  static telafinal_winT + #303, #3967
  static telafinal_winT + #304, #3967
  static telafinal_winT + #305, #125
  static telafinal_winT + #306, #3967
  static telafinal_winT + #307, #3967
  static telafinal_winT + #308, #125
  static telafinal_winT + #309, #3967
  static telafinal_winT + #310, #3967
  static telafinal_winT + #311, #125
  static telafinal_winT + #312, #3967
  static telafinal_winT + #313, #125
  static telafinal_winT + #314, #3967
  static telafinal_winT + #315, #3967
  static telafinal_winT + #316, #125
  static telafinal_winT + #317, #3967
  static telafinal_winT + #318, #3967
  static telafinal_winT + #319, #31

  ;Linha 8
  static telafinal_winT + #320, #31
  static telafinal_winT + #321, #3967
  static telafinal_winT + #322, #3967
  static telafinal_winT + #323, #2173
  static telafinal_winT + #324, #2173
  static telafinal_winT + #325, #2173
  static telafinal_winT + #326, #2173
  static telafinal_winT + #327, #125
  static telafinal_winT + #328, #2173
  static telafinal_winT + #329, #125
  static telafinal_winT + #330, #3967
  static telafinal_winT + #331, #3453
  static telafinal_winT + #332, #3967
  static telafinal_winT + #333, #125
  static telafinal_winT + #334, #3453
  static telafinal_winT + #335, #3453
  static telafinal_winT + #336, #3453
  static telafinal_winT + #337, #3967
  static telafinal_winT + #338, #381
  static telafinal_winT + #339, #2173
  static telafinal_winT + #340, #3967
  static telafinal_winT + #341, #3967
  static telafinal_winT + #342, #3967
  static telafinal_winT + #343, #3967
  static telafinal_winT + #344, #3967
  static telafinal_winT + #345, #125
  static telafinal_winT + #346, #3967
  static telafinal_winT + #347, #3967
  static telafinal_winT + #348, #3967
  static telafinal_winT + #349, #125
  static telafinal_winT + #350, #125
  static telafinal_winT + #351, #3967
  static telafinal_winT + #352, #3967
  static telafinal_winT + #353, #3967
  static telafinal_winT + #354, #125
  static telafinal_winT + #355, #125
  static telafinal_winT + #356, #3967
  static telafinal_winT + #357, #3967
  static telafinal_winT + #358, #3967
  static telafinal_winT + #359, #31

  ;Linha 9
  static telafinal_winT + #360, #31
  static telafinal_winT + #361, #3967
  static telafinal_winT + #362, #3967
  static telafinal_winT + #363, #3967
  static telafinal_winT + #364, #125
  static telafinal_winT + #365, #125
  static telafinal_winT + #366, #125
  static telafinal_winT + #367, #125
  static telafinal_winT + #368, #3453
  static telafinal_winT + #369, #125
  static telafinal_winT + #370, #3967
  static telafinal_winT + #371, #3453
  static telafinal_winT + #372, #3967
  static telafinal_winT + #373, #125
  static telafinal_winT + #374, #3453
  static telafinal_winT + #375, #3453
  static telafinal_winT + #376, #3453
  static telafinal_winT + #377, #3967
  static telafinal_winT + #378, #381
  static telafinal_winT + #379, #2173
  static telafinal_winT + #380, #3967
  static telafinal_winT + #381, #3967
  static telafinal_winT + #382, #3967
  static telafinal_winT + #383, #3967
  static telafinal_winT + #384, #3967
  static telafinal_winT + #385, #3967
  static telafinal_winT + #386, #3967
  static telafinal_winT + #387, #3967
  static telafinal_winT + #388, #3967
  static telafinal_winT + #389, #3967
  static telafinal_winT + #390, #3967
  static telafinal_winT + #391, #3967
  static telafinal_winT + #392, #3967
  static telafinal_winT + #393, #3967
  static telafinal_winT + #394, #3967
  static telafinal_winT + #395, #3967
  static telafinal_winT + #396, #3967
  static telafinal_winT + #397, #3967
  static telafinal_winT + #398, #3967
  static telafinal_winT + #399, #31

  ;Linha 10
  static telafinal_winT + #400, #31
  static telafinal_winT + #401, #3967
  static telafinal_winT + #402, #3967
  static telafinal_winT + #403, #2173
  static telafinal_winT + #404, #381
  static telafinal_winT + #405, #381
  static telafinal_winT + #406, #381
  static telafinal_winT + #407, #2173
  static telafinal_winT + #408, #3453
  static telafinal_winT + #409, #1405
  static telafinal_winT + #410, #3453
  static telafinal_winT + #411, #3453
  static telafinal_winT + #412, #3453
  static telafinal_winT + #413, #1405
  static telafinal_winT + #414, #3453
  static telafinal_winT + #415, #3453
  static telafinal_winT + #416, #3840
  static telafinal_winT + #417, #3967
  static telafinal_winT + #418, #381
  static telafinal_winT + #419, #2173
  static telafinal_winT + #420, #3967
  static telafinal_winT + #421, #3967
  static telafinal_winT + #422, #3967
  static telafinal_winT + #423, #3967
  static telafinal_winT + #424, #3967
  static telafinal_winT + #425, #3967
  static telafinal_winT + #426, #3967
  static telafinal_winT + #427, #3967
  static telafinal_winT + #428, #3967
  static telafinal_winT + #429, #3967
  static telafinal_winT + #430, #3967
  static telafinal_winT + #431, #3967
  static telafinal_winT + #432, #3967
  static telafinal_winT + #433, #3967
  static telafinal_winT + #434, #3967
  static telafinal_winT + #435, #3967
  static telafinal_winT + #436, #3967
  static telafinal_winT + #437, #3967
  static telafinal_winT + #438, #3967
  static telafinal_winT + #439, #31

  ;Linha 11
  static telafinal_winT + #440, #31
  static telafinal_winT + #441, #3967
  static telafinal_winT + #442, #3967
  static telafinal_winT + #443, #2173
  static telafinal_winT + #444, #381
  static telafinal_winT + #445, #381
  static telafinal_winT + #446, #381
  static telafinal_winT + #447, #2173
  static telafinal_winT + #448, #3967
  static telafinal_winT + #449, #3967
  static telafinal_winT + #450, #1405
  static telafinal_winT + #451, #1405
  static telafinal_winT + #452, #1405
  static telafinal_winT + #453, #3453
  static telafinal_winT + #454, #3967
  static telafinal_winT + #455, #3967
  static telafinal_winT + #456, #3453
  static telafinal_winT + #457, #381
  static telafinal_winT + #458, #381
  static telafinal_winT + #459, #2173
  static telafinal_winT + #460, #3967
  static telafinal_winT + #461, #3967
  static telafinal_winT + #462, #3967
  static telafinal_winT + #463, #3967
  static telafinal_winT + #464, #3967
  static telafinal_winT + #465, #3967
  static telafinal_winT + #466, #3967
  static telafinal_winT + #467, #3967
  static telafinal_winT + #468, #3967
  static telafinal_winT + #469, #3967
  static telafinal_winT + #470, #3967
  static telafinal_winT + #471, #3967
  static telafinal_winT + #472, #3967
  static telafinal_winT + #473, #3967
  static telafinal_winT + #474, #3967
  static telafinal_winT + #475, #3967
  static telafinal_winT + #476, #3967
  static telafinal_winT + #477, #3967
  static telafinal_winT + #478, #3967
  static telafinal_winT + #479, #31

  ;Linha 12
  static telafinal_winT + #480, #31
  static telafinal_winT + #481, #3967
  static telafinal_winT + #482, #3967
  static telafinal_winT + #483, #2173
  static telafinal_winT + #484, #381
  static telafinal_winT + #485, #381
  static telafinal_winT + #486, #381
  static telafinal_winT + #487, #2173
  static telafinal_winT + #488, #3967
  static telafinal_winT + #489, #3967
  static telafinal_winT + #490, #3967
  static telafinal_winT + #491, #3967
  static telafinal_winT + #492, #3967
  static telafinal_winT + #493, #3967
  static telafinal_winT + #494, #3967
  static telafinal_winT + #495, #3453
  static telafinal_winT + #496, #381
  static telafinal_winT + #497, #381
  static telafinal_winT + #498, #2173
  static telafinal_winT + #499, #3967
  static telafinal_winT + #500, #3967
  static telafinal_winT + #501, #3967
  static telafinal_winT + #502, #3967
  static telafinal_winT + #503, #125
  static telafinal_winT + #504, #3967
  static telafinal_winT + #505, #3967
  static telafinal_winT + #506, #3967
  static telafinal_winT + #507, #125
  static telafinal_winT + #508, #3967
  static telafinal_winT + #509, #125
  static telafinal_winT + #510, #3967
  static telafinal_winT + #511, #125
  static telafinal_winT + #512, #3967
  static telafinal_winT + #513, #3967
  static telafinal_winT + #514, #125
  static telafinal_winT + #515, #3967
  static telafinal_winT + #516, #3967
  static telafinal_winT + #517, #125
  static telafinal_winT + #518, #3967
  static telafinal_winT + #519, #31

  ;Linha 13
  static telafinal_winT + #520, #31
  static telafinal_winT + #521, #3967
  static telafinal_winT + #522, #3967
  static telafinal_winT + #523, #3967
  static telafinal_winT + #524, #2173
  static telafinal_winT + #525, #381
  static telafinal_winT + #526, #381
  static telafinal_winT + #527, #2173
  static telafinal_winT + #528, #3453
  static telafinal_winT + #529, #3967
  static telafinal_winT + #530, #3967
  static telafinal_winT + #531, #3967
  static telafinal_winT + #532, #3967
  static telafinal_winT + #533, #3967
  static telafinal_winT + #534, #3453
  static telafinal_winT + #535, #381
  static telafinal_winT + #536, #381
  static telafinal_winT + #537, #2173
  static telafinal_winT + #538, #3967
  static telafinal_winT + #539, #3967
  static telafinal_winT + #540, #3967
  static telafinal_winT + #541, #3967
  static telafinal_winT + #542, #3967
  static telafinal_winT + #543, #125
  static telafinal_winT + #544, #3967
  static telafinal_winT + #545, #125
  static telafinal_winT + #546, #3967
  static telafinal_winT + #547, #125
  static telafinal_winT + #548, #3967
  static telafinal_winT + #549, #3967
  static telafinal_winT + #550, #3967
  static telafinal_winT + #551, #125
  static telafinal_winT + #552, #125
  static telafinal_winT + #553, #3967
  static telafinal_winT + #554, #125
  static telafinal_winT + #555, #3967
  static telafinal_winT + #556, #3967
  static telafinal_winT + #557, #125
  static telafinal_winT + #558, #3967
  static telafinal_winT + #559, #31

  ;Linha 14
  static telafinal_winT + #560, #31
  static telafinal_winT + #561, #3967
  static telafinal_winT + #562, #3967
  static telafinal_winT + #563, #3967
  static telafinal_winT + #564, #2173
  static telafinal_winT + #565, #381
  static telafinal_winT + #566, #381
  static telafinal_winT + #567, #381
  static telafinal_winT + #568, #2173
  static telafinal_winT + #569, #3453
  static telafinal_winT + #570, #3453
  static telafinal_winT + #571, #3453
  static telafinal_winT + #572, #3453
  static telafinal_winT + #573, #3453
  static telafinal_winT + #574, #3453
  static telafinal_winT + #575, #381
  static telafinal_winT + #576, #381
  static telafinal_winT + #577, #2173
  static telafinal_winT + #578, #3967
  static telafinal_winT + #579, #3967
  static telafinal_winT + #580, #3967
  static telafinal_winT + #581, #3967
  static telafinal_winT + #582, #3967
  static telafinal_winT + #583, #125
  static telafinal_winT + #584, #3967
  static telafinal_winT + #585, #125
  static telafinal_winT + #586, #3967
  static telafinal_winT + #587, #125
  static telafinal_winT + #588, #3967
  static telafinal_winT + #589, #125
  static telafinal_winT + #590, #3967
  static telafinal_winT + #591, #125
  static telafinal_winT + #592, #3967
  static telafinal_winT + #593, #125
  static telafinal_winT + #594, #125
  static telafinal_winT + #595, #3967
  static telafinal_winT + #596, #3967
  static telafinal_winT + #597, #3967
  static telafinal_winT + #598, #3967
  static telafinal_winT + #599, #31

  ;Linha 15
  static telafinal_winT + #600, #30
  static telafinal_winT + #601, #3967
  static telafinal_winT + #602, #3967
  static telafinal_winT + #603, #3967
  static telafinal_winT + #604, #2173
  static telafinal_winT + #605, #381
  static telafinal_winT + #606, #381
  static telafinal_winT + #607, #381
  static telafinal_winT + #608, #2173
  static telafinal_winT + #609, #381
  static telafinal_winT + #610, #381
  static telafinal_winT + #611, #2941
  static telafinal_winT + #612, #2941
  static telafinal_winT + #613, #381
  static telafinal_winT + #614, #381
  static telafinal_winT + #615, #381
  static telafinal_winT + #616, #2173
  static telafinal_winT + #617, #2173
  static telafinal_winT + #618, #3967
  static telafinal_winT + #619, #3967
  static telafinal_winT + #620, #3967
  static telafinal_winT + #621, #3967
  static telafinal_winT + #622, #3967
  static telafinal_winT + #623, #3967
  static telafinal_winT + #624, #125
  static telafinal_winT + #625, #3967
  static telafinal_winT + #626, #125
  static telafinal_winT + #627, #3967
  static telafinal_winT + #628, #3967
  static telafinal_winT + #629, #125
  static telafinal_winT + #630, #3967
  static telafinal_winT + #631, #125
  static telafinal_winT + #632, #3967
  static telafinal_winT + #633, #3967
  static telafinal_winT + #634, #125
  static telafinal_winT + #635, #3967
  static telafinal_winT + #636, #3967
  static telafinal_winT + #637, #125
  static telafinal_winT + #638, #3967
  static telafinal_winT + #639, #30

  ;Linha 16
  static telafinal_winT + #640, #30
  static telafinal_winT + #641, #3967
  static telafinal_winT + #642, #3967
  static telafinal_winT + #643, #3967
  static telafinal_winT + #644, #3967
  static telafinal_winT + #645, #2173
  static telafinal_winT + #646, #381
  static telafinal_winT + #647, #381
  static telafinal_winT + #648, #2173
  static telafinal_winT + #649, #1149
  static telafinal_winT + #650, #1149
  static telafinal_winT + #651, #381
  static telafinal_winT + #652, #381
  static telafinal_winT + #653, #1149
  static telafinal_winT + #654, #1149
  static telafinal_winT + #655, #1149
  static telafinal_winT + #656, #125
  static telafinal_winT + #657, #125
  static telafinal_winT + #658, #2173
  static telafinal_winT + #659, #3967
  static telafinal_winT + #660, #3967
  static telafinal_winT + #661, #3967
  static telafinal_winT + #662, #3967
  static telafinal_winT + #663, #3967
  static telafinal_winT + #664, #3967
  static telafinal_winT + #665, #3967
  static telafinal_winT + #666, #3967
  static telafinal_winT + #667, #3967
  static telafinal_winT + #668, #3967
  static telafinal_winT + #669, #3967
  static telafinal_winT + #670, #3967
  static telafinal_winT + #671, #3967
  static telafinal_winT + #672, #3967
  static telafinal_winT + #673, #3967
  static telafinal_winT + #674, #3967
  static telafinal_winT + #675, #3967
  static telafinal_winT + #676, #3967
  static telafinal_winT + #677, #3967
  static telafinal_winT + #678, #3967
  static telafinal_winT + #679, #30

  ;Linha 17
  static telafinal_winT + #680, #30
  static telafinal_winT + #681, #3967
  static telafinal_winT + #682, #3967
  static telafinal_winT + #683, #3967
  static telafinal_winT + #684, #3967
  static telafinal_winT + #685, #2173
  static telafinal_winT + #686, #381
  static telafinal_winT + #687, #1149
  static telafinal_winT + #688, #1149
  static telafinal_winT + #689, #1149
  static telafinal_winT + #690, #1149
  static telafinal_winT + #691, #1149
  static telafinal_winT + #692, #1149
  static telafinal_winT + #693, #1149
  static telafinal_winT + #694, #1149
  static telafinal_winT + #695, #1149
  static telafinal_winT + #696, #1149
  static telafinal_winT + #697, #125
  static telafinal_winT + #698, #2173
  static telafinal_winT + #699, #3967
  static telafinal_winT + #700, #3967
  static telafinal_winT + #701, #3967
  static telafinal_winT + #702, #3967
  static telafinal_winT + #703, #3967
  static telafinal_winT + #704, #3967
  static telafinal_winT + #705, #3967
  static telafinal_winT + #706, #3967
  static telafinal_winT + #707, #3967
  static telafinal_winT + #708, #3967
  static telafinal_winT + #709, #3967
  static telafinal_winT + #710, #3967
  static telafinal_winT + #711, #3967
  static telafinal_winT + #712, #3967
  static telafinal_winT + #713, #3967
  static telafinal_winT + #714, #3967
  static telafinal_winT + #715, #3967
  static telafinal_winT + #716, #3967
  static telafinal_winT + #717, #3967
  static telafinal_winT + #718, #3967
  static telafinal_winT + #719, #30

  ;Linha 18
  static telafinal_winT + #720, #30
  static telafinal_winT + #721, #3967
  static telafinal_winT + #722, #3967
  static telafinal_winT + #723, #3967
  static telafinal_winT + #724, #3967
  static telafinal_winT + #725, #2173
  static telafinal_winT + #726, #1149
  static telafinal_winT + #727, #1149
  static telafinal_winT + #728, #125
  static telafinal_winT + #729, #125
  static telafinal_winT + #730, #1149
  static telafinal_winT + #731, #1149
  static telafinal_winT + #732, #1149
  static telafinal_winT + #733, #1149
  static telafinal_winT + #734, #125
  static telafinal_winT + #735, #125
  static telafinal_winT + #736, #1149
  static telafinal_winT + #737, #125
  static telafinal_winT + #738, #2173
  static telafinal_winT + #739, #3967
  static telafinal_winT + #740, #3967
  static telafinal_winT + #741, #3967
  static telafinal_winT + #742, #3967
  static telafinal_winT + #743, #3967
  static telafinal_winT + #744, #3967
  static telafinal_winT + #745, #3967
  static telafinal_winT + #746, #3967
  static telafinal_winT + #747, #3967
  static telafinal_winT + #748, #3967
  static telafinal_winT + #749, #3967
  static telafinal_winT + #750, #3967
  static telafinal_winT + #751, #3967
  static telafinal_winT + #752, #3967
  static telafinal_winT + #753, #3967
  static telafinal_winT + #754, #3967
  static telafinal_winT + #755, #3967
  static telafinal_winT + #756, #3967
  static telafinal_winT + #757, #3967
  static telafinal_winT + #758, #3967
  static telafinal_winT + #759, #30

  ;Linha 19
  static telafinal_winT + #760, #30
  static telafinal_winT + #761, #3967
  static telafinal_winT + #762, #3967
  static telafinal_winT + #763, #3967
  static telafinal_winT + #764, #3967
  static telafinal_winT + #765, #2173
  static telafinal_winT + #766, #1149
  static telafinal_winT + #767, #1149
  static telafinal_winT + #768, #125
  static telafinal_winT + #769, #125
  static telafinal_winT + #770, #1149
  static telafinal_winT + #771, #1149
  static telafinal_winT + #772, #1149
  static telafinal_winT + #773, #1149
  static telafinal_winT + #774, #125
  static telafinal_winT + #775, #125
  static telafinal_winT + #776, #1149
  static telafinal_winT + #777, #2173
  static telafinal_winT + #778, #2173
  static telafinal_winT + #779, #3967
  static telafinal_winT + #780, #3967
  static telafinal_winT + #781, #3967
  static telafinal_winT + #782, #3967
  static telafinal_winT + #783, #3967
  static telafinal_winT + #784, #3967
  static telafinal_winT + #785, #3967
  static telafinal_winT + #786, #3967
  static telafinal_winT + #787, #3967
  static telafinal_winT + #788, #3967
  static telafinal_winT + #789, #3967
  static telafinal_winT + #790, #3967
  static telafinal_winT + #791, #3967
  static telafinal_winT + #792, #3967
  static telafinal_winT + #793, #3967
  static telafinal_winT + #794, #3967
  static telafinal_winT + #795, #3967
  static telafinal_winT + #796, #3967
  static telafinal_winT + #797, #3967
  static telafinal_winT + #798, #3967
  static telafinal_winT + #799, #30

  ;Linha 20
  static telafinal_winT + #800, #30
  static telafinal_winT + #801, #3967
  static telafinal_winT + #802, #3967
  static telafinal_winT + #803, #3967
  static telafinal_winT + #804, #3967
  static telafinal_winT + #805, #2173
  static telafinal_winT + #806, #1149
  static telafinal_winT + #807, #1149
  static telafinal_winT + #808, #1149
  static telafinal_winT + #809, #1149
  static telafinal_winT + #810, #1149
  static telafinal_winT + #811, #1149
  static telafinal_winT + #812, #1149
  static telafinal_winT + #813, #1149
  static telafinal_winT + #814, #1149
  static telafinal_winT + #815, #1149
  static telafinal_winT + #816, #1149
  static telafinal_winT + #817, #1149
  static telafinal_winT + #818, #2173
  static telafinal_winT + #819, #3967
  static telafinal_winT + #820, #3967
  static telafinal_winT + #821, #3967
  static telafinal_winT + #822, #59
  static telafinal_winT + #823, #59
  static telafinal_winT + #824, #59
  static telafinal_winT + #825, #59
  static telafinal_winT + #826, #59
  static telafinal_winT + #827, #59
  static telafinal_winT + #828, #59
  static telafinal_winT + #829, #59
  static telafinal_winT + #830, #59
  static telafinal_winT + #831, #59
  static telafinal_winT + #832, #59
  static telafinal_winT + #833, #59
  static telafinal_winT + #834, #59
  static telafinal_winT + #835, #59
  static telafinal_winT + #836, #59
  static telafinal_winT + #837, #3967
  static telafinal_winT + #838, #3967
  static telafinal_winT + #839, #30

  ;Linha 21
  static telafinal_winT + #840, #30
  static telafinal_winT + #841, #3967
  static telafinal_winT + #842, #3967
  static telafinal_winT + #843, #3967
  static telafinal_winT + #844, #2173
  static telafinal_winT + #845, #1149
  static telafinal_winT + #846, #1149
  static telafinal_winT + #847, #1149
  static telafinal_winT + #848, #1149
  static telafinal_winT + #849, #1149
  static telafinal_winT + #850, #1149
  static telafinal_winT + #851, #1149
  static telafinal_winT + #852, #1149
  static telafinal_winT + #853, #1149
  static telafinal_winT + #854, #1149
  static telafinal_winT + #855, #1149
  static telafinal_winT + #856, #1149
  static telafinal_winT + #857, #1149
  static telafinal_winT + #858, #2173
  static telafinal_winT + #859, #3967
  static telafinal_winT + #860, #3967
  static telafinal_winT + #861, #3967
  static telafinal_winT + #862, #3967
  static telafinal_winT + #863, #3967
  static telafinal_winT + #864, #3967
  static telafinal_winT + #865, #3967
  static telafinal_winT + #866, #3967
  static telafinal_winT + #867, #3967
  static telafinal_winT + #868, #3967
  static telafinal_winT + #869, #3967
  static telafinal_winT + #870, #3967
  static telafinal_winT + #871, #3967
  static telafinal_winT + #872, #3967
  static telafinal_winT + #873, #3967
  static telafinal_winT + #874, #3967
  static telafinal_winT + #875, #3967
  static telafinal_winT + #876, #3967
  static telafinal_winT + #877, #3967
  static telafinal_winT + #878, #3967
  static telafinal_winT + #879, #30

  ;Linha 22
  static telafinal_winT + #880, #30
  static telafinal_winT + #881, #3967
  static telafinal_winT + #882, #3967
  static telafinal_winT + #883, #3967
  static telafinal_winT + #884, #2173
  static telafinal_winT + #885, #1149
  static telafinal_winT + #886, #1149
  static telafinal_winT + #887, #1149
  static telafinal_winT + #888, #1149
  static telafinal_winT + #889, #1149
  static telafinal_winT + #890, #1149
  static telafinal_winT + #891, #1149
  static telafinal_winT + #892, #1149
  static telafinal_winT + #893, #1149
  static telafinal_winT + #894, #1149
  static telafinal_winT + #895, #1149
  static telafinal_winT + #896, #1149
  static telafinal_winT + #897, #1149
  static telafinal_winT + #898, #2173
  static telafinal_winT + #899, #3967
  static telafinal_winT + #900, #3967
  static telafinal_winT + #901, #3967
  static telafinal_winT + #902, #3967
  static telafinal_winT + #903, #3967
  static telafinal_winT + #904, #112
  static telafinal_winT + #905, #108
  static telafinal_winT + #906, #97
  static telafinal_winT + #907, #121
  static telafinal_winT + #908, #3967
  static telafinal_winT + #909, #97
  static telafinal_winT + #910, #103
  static telafinal_winT + #911, #97
  static telafinal_winT + #912, #105
  static telafinal_winT + #913, #110
  static telafinal_winT + #914, #37
  static telafinal_winT + #915, #3967
  static telafinal_winT + #916, #3967
  static telafinal_winT + #917, #3967
  static telafinal_winT + #918, #3967
  static telafinal_winT + #919, #30

  ;Linha 23
  static telafinal_winT + #920, #30
  static telafinal_winT + #921, #3967
  static telafinal_winT + #922, #3967
  static telafinal_winT + #923, #3967
  static telafinal_winT + #924, #2173
  static telafinal_winT + #925, #1149
  static telafinal_winT + #926, #1149
  static telafinal_winT + #927, #1149
  static telafinal_winT + #928, #1149
  static telafinal_winT + #929, #1149
  static telafinal_winT + #930, #2173
  static telafinal_winT + #931, #2173
  static telafinal_winT + #932, #2173
  static telafinal_winT + #933, #1149
  static telafinal_winT + #934, #1149
  static telafinal_winT + #935, #1149
  static telafinal_winT + #936, #1149
  static telafinal_winT + #937, #1149
  static telafinal_winT + #938, #2173
  static telafinal_winT + #939, #3967
  static telafinal_winT + #940, #3967
  static telafinal_winT + #941, #3967
  static telafinal_winT + #942, #3967
  static telafinal_winT + #943, #3967
  static telafinal_winT + #944, #3967
  static telafinal_winT + #945, #3967
  static telafinal_winT + #946, #3967
  static telafinal_winT + #947, #3967
  static telafinal_winT + #948, #3967
  static telafinal_winT + #949, #3967
  static telafinal_winT + #950, #3967
  static telafinal_winT + #951, #3967
  static telafinal_winT + #952, #3967
  static telafinal_winT + #953, #3967
  static telafinal_winT + #954, #3967
  static telafinal_winT + #955, #3967
  static telafinal_winT + #956, #3967
  static telafinal_winT + #957, #3967
  static telafinal_winT + #958, #3967
  static telafinal_winT + #959, #30

  ;Linha 24
  static telafinal_winT + #960, #30
  static telafinal_winT + #961, #3967
  static telafinal_winT + #962, #3967
  static telafinal_winT + #963, #3967
  static telafinal_winT + #964, #2173
  static telafinal_winT + #965, #2173
  static telafinal_winT + #966, #2173
  static telafinal_winT + #967, #2173
  static telafinal_winT + #968, #1149
  static telafinal_winT + #969, #2173
  static telafinal_winT + #970, #3967
  static telafinal_winT + #971, #3967
  static telafinal_winT + #972, #2173
  static telafinal_winT + #973, #1149
  static telafinal_winT + #974, #2173
  static telafinal_winT + #975, #2173
  static telafinal_winT + #976, #2173
  static telafinal_winT + #977, #2173
  static telafinal_winT + #978, #2173
  static telafinal_winT + #979, #3967
  static telafinal_winT + #980, #3967
  static telafinal_winT + #981, #3967
  static telafinal_winT + #982, #3967
  static telafinal_winT + #983, #3967
  static telafinal_winT + #984, #3967
  static telafinal_winT + #985, #3967
  static telafinal_winT + #986, #3967
  static telafinal_winT + #987, #889
  static telafinal_winT + #988, #47
  static telafinal_winT + #989, #47
  static telafinal_winT + #990, #366
  static telafinal_winT + #991, #3967
  static telafinal_winT + #992, #3967
  static telafinal_winT + #993, #3967
  static telafinal_winT + #994, #3967
  static telafinal_winT + #995, #3967
  static telafinal_winT + #996, #3967
  static telafinal_winT + #997, #3967
  static telafinal_winT + #998, #3967
  static telafinal_winT + #999, #30

  ;Linha 25
  static telafinal_winT + #1000, #30
  static telafinal_winT + #1001, #3967
  static telafinal_winT + #1002, #3967
  static telafinal_winT + #1003, #3967
  static telafinal_winT + #1004, #2173
  static telafinal_winT + #1005, #2941
  static telafinal_winT + #1006, #2941
  static telafinal_winT + #1007, #2941
  static telafinal_winT + #1008, #2173
  static telafinal_winT + #1009, #3967
  static telafinal_winT + #1010, #3967
  static telafinal_winT + #1011, #3967
  static telafinal_winT + #1012, #3967
  static telafinal_winT + #1013, #2173
  static telafinal_winT + #1014, #2941
  static telafinal_winT + #1015, #2941
  static telafinal_winT + #1016, #2941
  static telafinal_winT + #1017, #2941
  static telafinal_winT + #1018, #2173
  static telafinal_winT + #1019, #3967
  static telafinal_winT + #1020, #3967
  static telafinal_winT + #1021, #3967
  static telafinal_winT + #1022, #3967
  static telafinal_winT + #1023, #3967
  static telafinal_winT + #1024, #3967
  static telafinal_winT + #1025, #3967
  static telafinal_winT + #1026, #3967
  static telafinal_winT + #1027, #3967
  static telafinal_winT + #1028, #3967
  static telafinal_winT + #1029, #3967
  static telafinal_winT + #1030, #3967
  static telafinal_winT + #1031, #3967
  static telafinal_winT + #1032, #3967
  static telafinal_winT + #1033, #3967
  static telafinal_winT + #1034, #3967
  static telafinal_winT + #1035, #3967
  static telafinal_winT + #1036, #3967
  static telafinal_winT + #1037, #3967
  static telafinal_winT + #1038, #3967
  static telafinal_winT + #1039, #30

  ;Linha 26
  static telafinal_winT + #1040, #30
  static telafinal_winT + #1041, #3967
  static telafinal_winT + #1042, #3967
  static telafinal_winT + #1043, #2173
  static telafinal_winT + #1044, #2941
  static telafinal_winT + #1045, #2941
  static telafinal_winT + #1046, #2941
  static telafinal_winT + #1047, #2941
  static telafinal_winT + #1048, #2173
  static telafinal_winT + #1049, #3967
  static telafinal_winT + #1050, #3967
  static telafinal_winT + #1051, #3967
  static telafinal_winT + #1052, #3967
  static telafinal_winT + #1053, #2173
  static telafinal_winT + #1054, #2941
  static telafinal_winT + #1055, #2941
  static telafinal_winT + #1056, #2941
  static telafinal_winT + #1057, #2941
  static telafinal_winT + #1058, #2941
  static telafinal_winT + #1059, #2173
  static telafinal_winT + #1060, #3967
  static telafinal_winT + #1061, #3967
  static telafinal_winT + #1062, #59
  static telafinal_winT + #1063, #59
  static telafinal_winT + #1064, #59
  static telafinal_winT + #1065, #59
  static telafinal_winT + #1066, #59
  static telafinal_winT + #1067, #59
  static telafinal_winT + #1068, #59
  static telafinal_winT + #1069, #59
  static telafinal_winT + #1070, #59
  static telafinal_winT + #1071, #59
  static telafinal_winT + #1072, #59
  static telafinal_winT + #1073, #59
  static telafinal_winT + #1074, #59
  static telafinal_winT + #1075, #59
  static telafinal_winT + #1076, #59
  static telafinal_winT + #1077, #3967
  static telafinal_winT + #1078, #3967
  static telafinal_winT + #1079, #30

  ;Linha 27
  static telafinal_winT + #1080, #30
  static telafinal_winT + #1081, #3967
  static telafinal_winT + #1082, #3967
  static telafinal_winT + #1083, #2173
  static telafinal_winT + #1084, #2173
  static telafinal_winT + #1085, #2173
  static telafinal_winT + #1086, #2173
  static telafinal_winT + #1087, #2173
  static telafinal_winT + #1088, #2173
  static telafinal_winT + #1089, #3967
  static telafinal_winT + #1090, #3967
  static telafinal_winT + #1091, #3967
  static telafinal_winT + #1092, #3967
  static telafinal_winT + #1093, #2173
  static telafinal_winT + #1094, #2173
  static telafinal_winT + #1095, #2173
  static telafinal_winT + #1096, #2173
  static telafinal_winT + #1097, #2173
  static telafinal_winT + #1098, #2173
  static telafinal_winT + #1099, #2173
  static telafinal_winT + #1100, #3967
  static telafinal_winT + #1101, #3967
  static telafinal_winT + #1102, #3967
  static telafinal_winT + #1103, #3967
  static telafinal_winT + #1104, #3967
  static telafinal_winT + #1105, #3967
  static telafinal_winT + #1106, #3967
  static telafinal_winT + #1107, #3967
  static telafinal_winT + #1108, #3967
  static telafinal_winT + #1109, #3967
  static telafinal_winT + #1110, #3967
  static telafinal_winT + #1111, #3967
  static telafinal_winT + #1112, #3967
  static telafinal_winT + #1113, #3967
  static telafinal_winT + #1114, #3967
  static telafinal_winT + #1115, #3967
  static telafinal_winT + #1116, #3967
  static telafinal_winT + #1117, #3967
  static telafinal_winT + #1118, #3967
  static telafinal_winT + #1119, #30

  ;Linha 28
  static telafinal_winT + #1120, #30
  static telafinal_winT + #1121, #3967
  static telafinal_winT + #1122, #3967
  static telafinal_winT + #1123, #3967
  static telafinal_winT + #1124, #3967
  static telafinal_winT + #1125, #3967
  static telafinal_winT + #1126, #3967
  static telafinal_winT + #1127, #3967
  static telafinal_winT + #1128, #3967
  static telafinal_winT + #1129, #3967
  static telafinal_winT + #1130, #3967
  static telafinal_winT + #1131, #3967
  static telafinal_winT + #1132, #3967
  static telafinal_winT + #1133, #3967
  static telafinal_winT + #1134, #3967
  static telafinal_winT + #1135, #3967
  static telafinal_winT + #1136, #3967
  static telafinal_winT + #1137, #3967
  static telafinal_winT + #1138, #3967
  static telafinal_winT + #1139, #3967
  static telafinal_winT + #1140, #3967
  static telafinal_winT + #1141, #3967
  static telafinal_winT + #1142, #3967
  static telafinal_winT + #1143, #3967
  static telafinal_winT + #1144, #3967
  static telafinal_winT + #1145, #3967
  static telafinal_winT + #1146, #3967
  static telafinal_winT + #1147, #3967
  static telafinal_winT + #1148, #3967
  static telafinal_winT + #1149, #3967
  static telafinal_winT + #1150, #3967
  static telafinal_winT + #1151, #3967
  static telafinal_winT + #1152, #3967
  static telafinal_winT + #1153, #3967
  static telafinal_winT + #1154, #3967
  static telafinal_winT + #1155, #3967
  static telafinal_winT + #1156, #3967
  static telafinal_winT + #1157, #3967
  static telafinal_winT + #1158, #3967
  static telafinal_winT + #1159, #30

  ;Linha 29
  static telafinal_winT + #1160, #64
  static telafinal_winT + #1161, #60
  static telafinal_winT + #1162, #60
  static telafinal_winT + #1163, #60
  static telafinal_winT + #1164, #60
  static telafinal_winT + #1165, #60
  static telafinal_winT + #1166, #60
  static telafinal_winT + #1167, #60
  static telafinal_winT + #1168, #60
  static telafinal_winT + #1169, #60
  static telafinal_winT + #1170, #60
  static telafinal_winT + #1171, #60
  static telafinal_winT + #1172, #60
  static telafinal_winT + #1173, #60
  static telafinal_winT + #1174, #60
  static telafinal_winT + #1175, #60
  static telafinal_winT + #1176, #60
  static telafinal_winT + #1177, #60
  static telafinal_winT + #1178, #60
  static telafinal_winT + #1179, #60
  static telafinal_winT + #1180, #62
  static telafinal_winT + #1181, #62
  static telafinal_winT + #1182, #62
  static telafinal_winT + #1183, #62
  static telafinal_winT + #1184, #62
  static telafinal_winT + #1185, #62
  static telafinal_winT + #1186, #62
  static telafinal_winT + #1187, #62
  static telafinal_winT + #1188, #62
  static telafinal_winT + #1189, #62
  static telafinal_winT + #1190, #62
  static telafinal_winT + #1191, #62
  static telafinal_winT + #1192, #62
  static telafinal_winT + #1193, #62
  static telafinal_winT + #1194, #62
  static telafinal_winT + #1195, #62
  static telafinal_winT + #1196, #62
  static telafinal_winT + #1197, #62
  static telafinal_winT + #1198, #62
  static telafinal_winT + #1199, #64

;function to print the winner screen
printtelafinal_winTScreen:
	push r0
	push r1
	push r2
	push r3

	loadn r0, #telafinal_winT
	loadn r1, #0
	loadn r2, #1200

	printtelafinal_winTScreenLoop:

    add r3,r0,r1
    loadi r3, r3
    outchar r3, r1
    inc r1
    cmp r1, r2
	jne printtelafinal_winTScreenLoop

	pop r3 
	pop r2
	pop r1
	pop r0
	
	rts

;screen that shows the player lost the game
tela_fimT : var #1200
  ;Linha 0
  static tela_fimT + #0, #64
  static tela_fimT + #1, #60
  static tela_fimT + #2, #60
  static tela_fimT + #3, #60
  static tela_fimT + #4, #60
  static tela_fimT + #5, #60
  static tela_fimT + #6, #60
  static tela_fimT + #7, #60
  static tela_fimT + #8, #60
  static tela_fimT + #9, #60
  static tela_fimT + #10, #60
  static tela_fimT + #11, #60
  static tela_fimT + #12, #60
  static tela_fimT + #13, #60
  static tela_fimT + #14, #60
  static tela_fimT + #15, #60
  static tela_fimT + #16, #60
  static tela_fimT + #17, #60
  static tela_fimT + #18, #60
  static tela_fimT + #19, #60
  static tela_fimT + #20, #62
  static tela_fimT + #21, #62
  static tela_fimT + #22, #62
  static tela_fimT + #23, #62
  static tela_fimT + #24, #62
  static tela_fimT + #25, #62
  static tela_fimT + #26, #62
  static tela_fimT + #27, #62
  static tela_fimT + #28, #62
  static tela_fimT + #29, #62
  static tela_fimT + #30, #62
  static tela_fimT + #31, #62
  static tela_fimT + #32, #62
  static tela_fimT + #33, #62
  static tela_fimT + #34, #62
  static tela_fimT + #35, #62
  static tela_fimT + #36, #62
  static tela_fimT + #37, #62
  static tela_fimT + #38, #62
  static tela_fimT + #39, #64

  ;Linha 1
  static tela_fimT + #40, #31
  static tela_fimT + #41, #3967
  static tela_fimT + #42, #3967
  static tela_fimT + #43, #3967
  static tela_fimT + #44, #3967
  static tela_fimT + #45, #3967
  static tela_fimT + #46, #3967
  static tela_fimT + #47, #3967
  static tela_fimT + #48, #3967
  static tela_fimT + #49, #3967
  static tela_fimT + #50, #3967
  static tela_fimT + #51, #3967
  static tela_fimT + #52, #3967
  static tela_fimT + #53, #3967
  static tela_fimT + #54, #3967
  static tela_fimT + #55, #3967
  static tela_fimT + #56, #3967
  static tela_fimT + #57, #3967
  static tela_fimT + #58, #3967
  static tela_fimT + #59, #3967
  static tela_fimT + #60, #3967
  static tela_fimT + #61, #3967
  static tela_fimT + #62, #3967
  static tela_fimT + #63, #3967
  static tela_fimT + #64, #3967
  static tela_fimT + #65, #3967
  static tela_fimT + #66, #3967
  static tela_fimT + #67, #3967
  static tela_fimT + #68, #3967
  static tela_fimT + #69, #3967
  static tela_fimT + #70, #3967
  static tela_fimT + #71, #3967
  static tela_fimT + #72, #3967
  static tela_fimT + #73, #3967
  static tela_fimT + #74, #3967
  static tela_fimT + #75, #3967
  static tela_fimT + #76, #3967
  static tela_fimT + #77, #3967
  static tela_fimT + #78, #3967
  static tela_fimT + #79, #31

  ;Linha 2
  static tela_fimT + #80, #31
  static tela_fimT + #81, #3967
  static tela_fimT + #82, #3967
  static tela_fimT + #83, #3967
  static tela_fimT + #84, #3967
  static tela_fimT + #85, #3967
  static tela_fimT + #86, #3967
  static tela_fimT + #87, #3967
  static tela_fimT + #88, #2173
  static tela_fimT + #89, #2173
  static tela_fimT + #90, #2173
  static tela_fimT + #91, #2173
  static tela_fimT + #92, #2173
  static tela_fimT + #93, #2173
  static tela_fimT + #94, #2173
  static tela_fimT + #95, #2173
  static tela_fimT + #96, #3967
  static tela_fimT + #97, #3967
  static tela_fimT + #98, #3967
  static tela_fimT + #99, #3967
  static tela_fimT + #100, #3967
  static tela_fimT + #101, #3967
  static tela_fimT + #102, #3967
  static tela_fimT + #103, #3967
  static tela_fimT + #104, #3967
  static tela_fimT + #105, #3967
  static tela_fimT + #106, #3967
  static tela_fimT + #107, #3967
  static tela_fimT + #108, #3967
  static tela_fimT + #109, #3967
  static tela_fimT + #110, #3967
  static tela_fimT + #111, #3967
  static tela_fimT + #112, #3967
  static tela_fimT + #113, #3967
  static tela_fimT + #114, #3967
  static tela_fimT + #115, #3967
  static tela_fimT + #116, #3967
  static tela_fimT + #117, #3967
  static tela_fimT + #118, #3967
  static tela_fimT + #119, #31

  ;Linha 3
  static tela_fimT + #120, #31
  static tela_fimT + #121, #3967
  static tela_fimT + #122, #3967
  static tela_fimT + #123, #3967
  static tela_fimT + #124, #3967
  static tela_fimT + #125, #3967
  static tela_fimT + #126, #3967
  static tela_fimT + #127, #2173
  static tela_fimT + #128, #2173
  static tela_fimT + #129, #381
  static tela_fimT + #130, #381
  static tela_fimT + #131, #381
  static tela_fimT + #132, #2941
  static tela_fimT + #133, #381
  static tela_fimT + #134, #381
  static tela_fimT + #135, #381
  static tela_fimT + #136, #2173
  static tela_fimT + #137, #3967
  static tela_fimT + #138, #3967
  static tela_fimT + #139, #3967
  static tela_fimT + #140, #3967
  static tela_fimT + #141, #3967
  static tela_fimT + #142, #125
  static tela_fimT + #143, #3967
  static tela_fimT + #144, #125
  static tela_fimT + #145, #3967
  static tela_fimT + #146, #3967
  static tela_fimT + #147, #125
  static tela_fimT + #148, #125
  static tela_fimT + #149, #3967
  static tela_fimT + #150, #3967
  static tela_fimT + #151, #125
  static tela_fimT + #152, #3967
  static tela_fimT + #153, #3967
  static tela_fimT + #154, #125
  static tela_fimT + #155, #3967
  static tela_fimT + #156, #3967
  static tela_fimT + #157, #3967
  static tela_fimT + #158, #3967
  static tela_fimT + #159, #31

  ;Linha 4
  static tela_fimT + #160, #31
  static tela_fimT + #161, #3967
  static tela_fimT + #162, #3967
  static tela_fimT + #163, #3967
  static tela_fimT + #164, #3967
  static tela_fimT + #165, #3967
  static tela_fimT + #166, #2173
  static tela_fimT + #167, #381
  static tela_fimT + #168, #381
  static tela_fimT + #169, #381
  static tela_fimT + #170, #381
  static tela_fimT + #171, #2941
  static tela_fimT + #172, #2941
  static tela_fimT + #173, #125
  static tela_fimT + #174, #381
  static tela_fimT + #175, #381
  static tela_fimT + #176, #2173
  static tela_fimT + #177, #3967
  static tela_fimT + #178, #3967
  static tela_fimT + #179, #3967
  static tela_fimT + #180, #3967
  static tela_fimT + #181, #3967
  static tela_fimT + #182, #125
  static tela_fimT + #183, #3967
  static tela_fimT + #184, #125
  static tela_fimT + #185, #3967
  static tela_fimT + #186, #125
  static tela_fimT + #187, #3967
  static tela_fimT + #188, #3967
  static tela_fimT + #189, #125
  static tela_fimT + #190, #3967
  static tela_fimT + #191, #125
  static tela_fimT + #192, #3967
  static tela_fimT + #193, #3967
  static tela_fimT + #194, #125
  static tela_fimT + #195, #3967
  static tela_fimT + #196, #3967
  static tela_fimT + #197, #3967
  static tela_fimT + #198, #3967
  static tela_fimT + #199, #31

  ;Linha 5
  static tela_fimT + #200, #31
  static tela_fimT + #201, #3967
  static tela_fimT + #202, #3967
  static tela_fimT + #203, #3967
  static tela_fimT + #204, #3967
  static tela_fimT + #205, #2173
  static tela_fimT + #206, #381
  static tela_fimT + #207, #381
  static tela_fimT + #208, #381
  static tela_fimT + #209, #381
  static tela_fimT + #210, #3967
  static tela_fimT + #211, #3967
  static tela_fimT + #212, #3967
  static tela_fimT + #213, #3967
  static tela_fimT + #214, #3967
  static tela_fimT + #215, #3967
  static tela_fimT + #216, #3967
  static tela_fimT + #217, #2173
  static tela_fimT + #218, #3967
  static tela_fimT + #219, #3967
  static tela_fimT + #220, #3967
  static tela_fimT + #221, #3967
  static tela_fimT + #222, #3967
  static tela_fimT + #223, #125
  static tela_fimT + #224, #3967
  static tela_fimT + #225, #3967
  static tela_fimT + #226, #125
  static tela_fimT + #227, #3967
  static tela_fimT + #228, #3967
  static tela_fimT + #229, #125
  static tela_fimT + #230, #3967
  static tela_fimT + #231, #125
  static tela_fimT + #232, #3967
  static tela_fimT + #233, #3967
  static tela_fimT + #234, #125
  static tela_fimT + #235, #3967
  static tela_fimT + #236, #3967
  static tela_fimT + #237, #3967
  static tela_fimT + #238, #3967
  static tela_fimT + #239, #31

  ;Linha 6
  static tela_fimT + #240, #31
  static tela_fimT + #241, #3967
  static tela_fimT + #242, #3967
  static tela_fimT + #243, #3967
  static tela_fimT + #244, #2173
  static tela_fimT + #245, #381
  static tela_fimT + #246, #381
  static tela_fimT + #247, #3967
  static tela_fimT + #248, #3967
  static tela_fimT + #249, #3967
  static tela_fimT + #250, #3967
  static tela_fimT + #251, #3967
  static tela_fimT + #252, #3967
  static tela_fimT + #253, #3967
  static tela_fimT + #254, #3967
  static tela_fimT + #255, #3967
  static tela_fimT + #256, #3967
  static tela_fimT + #257, #3967
  static tela_fimT + #258, #2173
  static tela_fimT + #259, #3967
  static tela_fimT + #260, #3967
  static tela_fimT + #261, #3967
  static tela_fimT + #262, #3967
  static tela_fimT + #263, #125
  static tela_fimT + #264, #3967
  static tela_fimT + #265, #3967
  static tela_fimT + #266, #125
  static tela_fimT + #267, #3967
  static tela_fimT + #268, #3967
  static tela_fimT + #269, #125
  static tela_fimT + #270, #3967
  static tela_fimT + #271, #125
  static tela_fimT + #272, #3967
  static tela_fimT + #273, #3967
  static tela_fimT + #274, #125
  static tela_fimT + #275, #3967
  static tela_fimT + #276, #3967
  static tela_fimT + #277, #3967
  static tela_fimT + #278, #3967
  static tela_fimT + #279, #31

  ;Linha 7
  static tela_fimT + #280, #31
  static tela_fimT + #281, #3967
  static tela_fimT + #282, #3967
  static tela_fimT + #283, #2173
  static tela_fimT + #284, #381
  static tela_fimT + #285, #381
  static tela_fimT + #286, #3967
  static tela_fimT + #287, #3967
  static tela_fimT + #288, #3967
  static tela_fimT + #289, #3967
  static tela_fimT + #290, #2173
  static tela_fimT + #291, #2173
  static tela_fimT + #292, #2173
  static tela_fimT + #293, #2173
  static tela_fimT + #294, #2173
  static tela_fimT + #295, #2173
  static tela_fimT + #296, #3967
  static tela_fimT + #297, #3967
  static tela_fimT + #298, #2173
  static tela_fimT + #299, #3967
  static tela_fimT + #300, #3967
  static tela_fimT + #301, #3967
  static tela_fimT + #302, #3967
  static tela_fimT + #303, #125
  static tela_fimT + #304, #3967
  static tela_fimT + #305, #3967
  static tela_fimT + #306, #3967
  static tela_fimT + #307, #125
  static tela_fimT + #308, #125
  static tela_fimT + #309, #3967
  static tela_fimT + #310, #3967
  static tela_fimT + #311, #3967
  static tela_fimT + #312, #125
  static tela_fimT + #313, #125
  static tela_fimT + #314, #3967
  static tela_fimT + #315, #3967
  static tela_fimT + #316, #3967
  static tela_fimT + #317, #3967
  static tela_fimT + #318, #3967
  static tela_fimT + #319, #31

  ;Linha 8
  static tela_fimT + #320, #31
  static tela_fimT + #321, #3967
  static tela_fimT + #322, #2173
  static tela_fimT + #323, #381
  static tela_fimT + #324, #381
  static tela_fimT + #325, #3967
  static tela_fimT + #326, #3967
  static tela_fimT + #327, #3967
  static tela_fimT + #328, #3453
  static tela_fimT + #329, #125
  static tela_fimT + #330, #3453
  static tela_fimT + #331, #3453
  static tela_fimT + #332, #3453
  static tela_fimT + #333, #125
  static tela_fimT + #334, #3453
  static tela_fimT + #335, #3967
  static tela_fimT + #336, #2173
  static tela_fimT + #337, #2173
  static tela_fimT + #338, #3967
  static tela_fimT + #339, #3967
  static tela_fimT + #340, #3967
  static tela_fimT + #341, #3967
  static tela_fimT + #342, #3967
  static tela_fimT + #343, #3967
  static tela_fimT + #344, #3967
  static tela_fimT + #345, #3967
  static tela_fimT + #346, #3967
  static tela_fimT + #347, #3967
  static tela_fimT + #348, #3967
  static tela_fimT + #349, #3967
  static tela_fimT + #350, #3967
  static tela_fimT + #351, #3967
  static tela_fimT + #352, #3967
  static tela_fimT + #353, #3967
  static tela_fimT + #354, #3967
  static tela_fimT + #355, #3967
  static tela_fimT + #356, #3967
  static tela_fimT + #357, #3967
  static tela_fimT + #358, #3967
  static tela_fimT + #359, #31

  ;Linha 9
  static tela_fimT + #360, #31
  static tela_fimT + #361, #3967
  static tela_fimT + #362, #2173
  static tela_fimT + #363, #381
  static tela_fimT + #364, #381
  static tela_fimT + #365, #3967
  static tela_fimT + #366, #3967
  static tela_fimT + #367, #3453
  static tela_fimT + #368, #3453
  static tela_fimT + #369, #125
  static tela_fimT + #370, #3967
  static tela_fimT + #371, #3453
  static tela_fimT + #372, #3967
  static tela_fimT + #373, #125
  static tela_fimT + #374, #3453
  static tela_fimT + #375, #3453
  static tela_fimT + #376, #3967
  static tela_fimT + #377, #3967
  static tela_fimT + #378, #3967
  static tela_fimT + #379, #3967
  static tela_fimT + #380, #3967
  static tela_fimT + #381, #125
  static tela_fimT + #382, #3967
  static tela_fimT + #383, #3967
  static tela_fimT + #384, #3967
  static tela_fimT + #385, #3967
  static tela_fimT + #386, #125
  static tela_fimT + #387, #125
  static tela_fimT + #388, #3967
  static tela_fimT + #389, #3967
  static tela_fimT + #390, #3967
  static tela_fimT + #391, #125
  static tela_fimT + #392, #125
  static tela_fimT + #393, #125
  static tela_fimT + #394, #3967
  static tela_fimT + #395, #3967
  static tela_fimT + #396, #125
  static tela_fimT + #397, #125
  static tela_fimT + #398, #3967
  static tela_fimT + #399, #31

  ;Linha 10
  static tela_fimT + #400, #31
  static tela_fimT + #401, #3967
  static tela_fimT + #402, #2173
  static tela_fimT + #403, #381
  static tela_fimT + #404, #3967
  static tela_fimT + #405, #3967
  static tela_fimT + #406, #3453
  static tela_fimT + #407, #3453
  static tela_fimT + #408, #3453
  static tela_fimT + #409, #125
  static tela_fimT + #410, #3967
  static tela_fimT + #411, #3453
  static tela_fimT + #412, #3967
  static tela_fimT + #413, #125
  static tela_fimT + #414, #3453
  static tela_fimT + #415, #3453
  static tela_fimT + #416, #2173
  static tela_fimT + #417, #2173
  static tela_fimT + #418, #3967
  static tela_fimT + #419, #3967
  static tela_fimT + #420, #3967
  static tela_fimT + #421, #125
  static tela_fimT + #422, #3967
  static tela_fimT + #423, #3967
  static tela_fimT + #424, #3967
  static tela_fimT + #425, #125
  static tela_fimT + #426, #3967
  static tela_fimT + #427, #3967
  static tela_fimT + #428, #125
  static tela_fimT + #429, #3967
  static tela_fimT + #430, #125
  static tela_fimT + #431, #3967
  static tela_fimT + #432, #3967
  static tela_fimT + #433, #3967
  static tela_fimT + #434, #3967
  static tela_fimT + #435, #125
  static tela_fimT + #436, #3967
  static tela_fimT + #437, #3967
  static tela_fimT + #438, #3967
  static tela_fimT + #439, #31

  ;Linha 11
  static tela_fimT + #440, #31
  static tela_fimT + #441, #2173
  static tela_fimT + #442, #3453
  static tela_fimT + #443, #381
  static tela_fimT + #444, #3967
  static tela_fimT + #445, #3967
  static tela_fimT + #446, #3453
  static tela_fimT + #447, #3453
  static tela_fimT + #448, #3967
  static tela_fimT + #449, #3453
  static tela_fimT + #450, #3453
  static tela_fimT + #451, #3453
  static tela_fimT + #452, #3453
  static tela_fimT + #453, #3453
  static tela_fimT + #454, #3453
  static tela_fimT + #455, #3453
  static tela_fimT + #456, #3453
  static tela_fimT + #457, #2173
  static tela_fimT + #458, #3967
  static tela_fimT + #459, #3967
  static tela_fimT + #460, #3967
  static tela_fimT + #461, #125
  static tela_fimT + #462, #3967
  static tela_fimT + #463, #3967
  static tela_fimT + #464, #3967
  static tela_fimT + #465, #125
  static tela_fimT + #466, #3967
  static tela_fimT + #467, #3967
  static tela_fimT + #468, #125
  static tela_fimT + #469, #3967
  static tela_fimT + #470, #3967
  static tela_fimT + #471, #125
  static tela_fimT + #472, #125
  static tela_fimT + #473, #3967
  static tela_fimT + #474, #3967
  static tela_fimT + #475, #125
  static tela_fimT + #476, #125
  static tela_fimT + #477, #3967
  static tela_fimT + #478, #3967
  static tela_fimT + #479, #31

  ;Linha 12
  static tela_fimT + #480, #31
  static tela_fimT + #481, #2173
  static tela_fimT + #482, #3453
  static tela_fimT + #483, #381
  static tela_fimT + #484, #3967
  static tela_fimT + #485, #3453
  static tela_fimT + #486, #3453
  static tela_fimT + #487, #3967
  static tela_fimT + #488, #3967
  static tela_fimT + #489, #3967
  static tela_fimT + #490, #3967
  static tela_fimT + #491, #3967
  static tela_fimT + #492, #3967
  static tela_fimT + #493, #3967
  static tela_fimT + #494, #3967
  static tela_fimT + #495, #3967
  static tela_fimT + #496, #3967
  static tela_fimT + #497, #3967
  static tela_fimT + #498, #2173
  static tela_fimT + #499, #3967
  static tela_fimT + #500, #3967
  static tela_fimT + #501, #125
  static tela_fimT + #502, #3967
  static tela_fimT + #503, #3967
  static tela_fimT + #504, #3967
  static tela_fimT + #505, #125
  static tela_fimT + #506, #3967
  static tela_fimT + #507, #3967
  static tela_fimT + #508, #125
  static tela_fimT + #509, #3967
  static tela_fimT + #510, #3967
  static tela_fimT + #511, #3967
  static tela_fimT + #512, #3967
  static tela_fimT + #513, #125
  static tela_fimT + #514, #3967
  static tela_fimT + #515, #125
  static tela_fimT + #516, #3967
  static tela_fimT + #517, #3967
  static tela_fimT + #518, #3967
  static tela_fimT + #519, #31

  ;Linha 13
  static tela_fimT + #520, #31
  static tela_fimT + #521, #3967
  static tela_fimT + #522, #2173
  static tela_fimT + #523, #3453
  static tela_fimT + #524, #3453
  static tela_fimT + #525, #3453
  static tela_fimT + #526, #3453
  static tela_fimT + #527, #3453
  static tela_fimT + #528, #3453
  static tela_fimT + #529, #3967
  static tela_fimT + #530, #3967
  static tela_fimT + #531, #3967
  static tela_fimT + #532, #3967
  static tela_fimT + #533, #3967
  static tela_fimT + #534, #3967
  static tela_fimT + #535, #3967
  static tela_fimT + #536, #3967
  static tela_fimT + #537, #2173
  static tela_fimT + #538, #3967
  static tela_fimT + #539, #3967
  static tela_fimT + #540, #3967
  static tela_fimT + #541, #3967
  static tela_fimT + #542, #125
  static tela_fimT + #543, #125
  static tela_fimT + #544, #3967
  static tela_fimT + #545, #3967
  static tela_fimT + #546, #125
  static tela_fimT + #547, #125
  static tela_fimT + #548, #3967
  static tela_fimT + #549, #3967
  static tela_fimT + #550, #125
  static tela_fimT + #551, #125
  static tela_fimT + #552, #125
  static tela_fimT + #553, #3967
  static tela_fimT + #554, #3967
  static tela_fimT + #555, #3967
  static tela_fimT + #556, #125
  static tela_fimT + #557, #125
  static tela_fimT + #558, #3967
  static tela_fimT + #559, #31

  ;Linha 14
  static tela_fimT + #560, #31
  static tela_fimT + #561, #3967
  static tela_fimT + #562, #3967
  static tela_fimT + #563, #2173
  static tela_fimT + #564, #3453
  static tela_fimT + #565, #3453
  static tela_fimT + #566, #3453
  static tela_fimT + #567, #3453
  static tela_fimT + #568, #3453
  static tela_fimT + #569, #3453
  static tela_fimT + #570, #3453
  static tela_fimT + #571, #3453
  static tela_fimT + #572, #3453
  static tela_fimT + #573, #3453
  static tela_fimT + #574, #3453
  static tela_fimT + #575, #3453
  static tela_fimT + #576, #2173
  static tela_fimT + #577, #3967
  static tela_fimT + #578, #3967
  static tela_fimT + #579, #3967
  static tela_fimT + #580, #3967
  static tela_fimT + #581, #3967
  static tela_fimT + #582, #3967
  static tela_fimT + #583, #3967
  static tela_fimT + #584, #3967
  static tela_fimT + #585, #3967
  static tela_fimT + #586, #3967
  static tela_fimT + #587, #3967
  static tela_fimT + #588, #3967
  static tela_fimT + #589, #3967
  static tela_fimT + #590, #3967
  static tela_fimT + #591, #3967
  static tela_fimT + #592, #3967
  static tela_fimT + #593, #3967
  static tela_fimT + #594, #3967
  static tela_fimT + #595, #3967
  static tela_fimT + #596, #3967
  static tela_fimT + #597, #3967
  static tela_fimT + #598, #3967
  static tela_fimT + #599, #31

  ;Linha 15
  static tela_fimT + #600, #30
  static tela_fimT + #601, #3967
  static tela_fimT + #602, #3967
  static tela_fimT + #603, #3967
  static tela_fimT + #604, #2173
  static tela_fimT + #605, #3453
  static tela_fimT + #606, #3453
  static tela_fimT + #607, #3453
  static tela_fimT + #608, #3453
  static tela_fimT + #609, #3453
  static tela_fimT + #610, #3453
  static tela_fimT + #611, #3453
  static tela_fimT + #612, #3453
  static tela_fimT + #613, #3453
  static tela_fimT + #614, #3453
  static tela_fimT + #615, #3453
  static tela_fimT + #616, #2173
  static tela_fimT + #617, #3967
  static tela_fimT + #618, #3967
  static tela_fimT + #619, #3967
  static tela_fimT + #620, #3967
  static tela_fimT + #621, #3967
  static tela_fimT + #622, #2173
  static tela_fimT + #623, #3967
  static tela_fimT + #624, #3967
  static tela_fimT + #625, #3967
  static tela_fimT + #626, #3967
  static tela_fimT + #627, #3967
  static tela_fimT + #628, #3967
  static tela_fimT + #629, #3967
  static tela_fimT + #630, #3967
  static tela_fimT + #631, #3967
  static tela_fimT + #632, #3967
  static tela_fimT + #633, #3967
  static tela_fimT + #634, #3967
  static tela_fimT + #635, #3967
  static tela_fimT + #636, #3967
  static tela_fimT + #637, #3967
  static tela_fimT + #638, #3967
  static tela_fimT + #639, #30

  ;Linha 16
  static tela_fimT + #640, #30
  static tela_fimT + #641, #3967
  static tela_fimT + #642, #3967
  static tela_fimT + #643, #2173
  static tela_fimT + #644, #381
  static tela_fimT + #645, #381
  static tela_fimT + #646, #381
  static tela_fimT + #647, #1149
  static tela_fimT + #648, #1149
  static tela_fimT + #649, #381
  static tela_fimT + #650, #381
  static tela_fimT + #651, #381
  static tela_fimT + #652, #381
  static tela_fimT + #653, #1149
  static tela_fimT + #654, #1149
  static tela_fimT + #655, #1149
  static tela_fimT + #656, #381
  static tela_fimT + #657, #2173
  static tela_fimT + #658, #3967
  static tela_fimT + #659, #3967
  static tela_fimT + #660, #3967
  static tela_fimT + #661, #2173
  static tela_fimT + #662, #125
  static tela_fimT + #663, #2173
  static tela_fimT + #664, #3967
  static tela_fimT + #665, #3967
  static tela_fimT + #666, #3967
  static tela_fimT + #667, #3967
  static tela_fimT + #668, #3967
  static tela_fimT + #669, #3967
  static tela_fimT + #670, #3967
  static tela_fimT + #671, #3967
  static tela_fimT + #672, #3967
  static tela_fimT + #673, #3967
  static tela_fimT + #674, #3967
  static tela_fimT + #675, #3967
  static tela_fimT + #676, #3967
  static tela_fimT + #677, #3967
  static tela_fimT + #678, #3967
  static tela_fimT + #679, #30

  ;Linha 17
  static tela_fimT + #680, #30
  static tela_fimT + #681, #3967
  static tela_fimT + #682, #2173
  static tela_fimT + #683, #381
  static tela_fimT + #684, #381
  static tela_fimT + #685, #381
  static tela_fimT + #686, #381
  static tela_fimT + #687, #1149
  static tela_fimT + #688, #1149
  static tela_fimT + #689, #1149
  static tela_fimT + #690, #2941
  static tela_fimT + #691, #2941
  static tela_fimT + #692, #2941
  static tela_fimT + #693, #1149
  static tela_fimT + #694, #1149
  static tela_fimT + #695, #1149
  static tela_fimT + #696, #1149
  static tela_fimT + #697, #381
  static tela_fimT + #698, #2173
  static tela_fimT + #699, #3967
  static tela_fimT + #700, #3967
  static tela_fimT + #701, #2173
  static tela_fimT + #702, #125
  static tela_fimT + #703, #2173
  static tela_fimT + #704, #3967
  static tela_fimT + #705, #3967
  static tela_fimT + #706, #3967
  static tela_fimT + #707, #3967
  static tela_fimT + #708, #3967
  static tela_fimT + #709, #3967
  static tela_fimT + #710, #3967
  static tela_fimT + #711, #3967
  static tela_fimT + #712, #3967
  static tela_fimT + #713, #3967
  static tela_fimT + #714, #3967
  static tela_fimT + #715, #3967
  static tela_fimT + #716, #3967
  static tela_fimT + #717, #3967
  static tela_fimT + #718, #3967
  static tela_fimT + #719, #30

  ;Linha 18
  static tela_fimT + #720, #30
  static tela_fimT + #721, #2173
  static tela_fimT + #722, #381
  static tela_fimT + #723, #381
  static tela_fimT + #724, #381
  static tela_fimT + #725, #381
  static tela_fimT + #726, #1149
  static tela_fimT + #727, #1149
  static tela_fimT + #728, #1149
  static tela_fimT + #729, #1149
  static tela_fimT + #730, #1149
  static tela_fimT + #731, #1149
  static tela_fimT + #732, #1149
  static tela_fimT + #733, #1149
  static tela_fimT + #734, #1149
  static tela_fimT + #735, #1149
  static tela_fimT + #736, #1149
  static tela_fimT + #737, #381
  static tela_fimT + #738, #381
  static tela_fimT + #739, #3967
  static tela_fimT + #740, #2173
  static tela_fimT + #741, #125
  static tela_fimT + #742, #125
  static tela_fimT + #743, #125
  static tela_fimT + #744, #2173
  static tela_fimT + #745, #3967
  static tela_fimT + #746, #3967
  static tela_fimT + #747, #3967
  static tela_fimT + #748, #3967
  static tela_fimT + #749, #3967
  static tela_fimT + #750, #3967
  static tela_fimT + #751, #3967
  static tela_fimT + #752, #3967
  static tela_fimT + #753, #3967
  static tela_fimT + #754, #3967
  static tela_fimT + #755, #3967
  static tela_fimT + #756, #3967
  static tela_fimT + #757, #3967
  static tela_fimT + #758, #3967
  static tela_fimT + #759, #30

  ;Linha 19
  static tela_fimT + #760, #30
  static tela_fimT + #761, #2173
  static tela_fimT + #762, #381
  static tela_fimT + #763, #381
  static tela_fimT + #764, #2173
  static tela_fimT + #765, #2173
  static tela_fimT + #766, #1149
  static tela_fimT + #767, #1149
  static tela_fimT + #768, #1149
  static tela_fimT + #769, #125
  static tela_fimT + #770, #125
  static tela_fimT + #771, #1149
  static tela_fimT + #772, #1149
  static tela_fimT + #773, #125
  static tela_fimT + #774, #125
  static tela_fimT + #775, #1149
  static tela_fimT + #776, #1149
  static tela_fimT + #777, #381
  static tela_fimT + #778, #381
  static tela_fimT + #779, #2173
  static tela_fimT + #780, #125
  static tela_fimT + #781, #125
  static tela_fimT + #782, #125
  static tela_fimT + #783, #125
  static tela_fimT + #784, #2173
  static tela_fimT + #785, #3967
  static tela_fimT + #786, #3967
  static tela_fimT + #787, #3967
  static tela_fimT + #788, #3967
  static tela_fimT + #789, #3967
  static tela_fimT + #790, #3967
  static tela_fimT + #791, #3967
  static tela_fimT + #792, #3967
  static tela_fimT + #793, #3967
  static tela_fimT + #794, #3967
  static tela_fimT + #795, #3967
  static tela_fimT + #796, #3967
  static tela_fimT + #797, #3967
  static tela_fimT + #798, #3967
  static tela_fimT + #799, #30

  ;Linha 20
  static tela_fimT + #800, #30
  static tela_fimT + #801, #2173
  static tela_fimT + #802, #2173
  static tela_fimT + #803, #2173
  static tela_fimT + #804, #125
  static tela_fimT + #805, #125
  static tela_fimT + #806, #2173
  static tela_fimT + #807, #1149
  static tela_fimT + #808, #1149
  static tela_fimT + #809, #125
  static tela_fimT + #810, #125
  static tela_fimT + #811, #1149
  static tela_fimT + #812, #1149
  static tela_fimT + #813, #125
  static tela_fimT + #814, #125
  static tela_fimT + #815, #1149
  static tela_fimT + #816, #1149
  static tela_fimT + #817, #1149
  static tela_fimT + #818, #381
  static tela_fimT + #819, #2173
  static tela_fimT + #820, #125
  static tela_fimT + #821, #125
  static tela_fimT + #822, #125
  static tela_fimT + #823, #125
  static tela_fimT + #824, #2173
  static tela_fimT + #825, #3967
  static tela_fimT + #826, #3967
  static tela_fimT + #827, #3967
  static tela_fimT + #828, #3967
  static tela_fimT + #829, #3967
  static tela_fimT + #830, #3967
  static tela_fimT + #831, #3967
  static tela_fimT + #832, #3967
  static tela_fimT + #833, #3967
  static tela_fimT + #834, #3967
  static tela_fimT + #835, #3967
  static tela_fimT + #836, #3967
  static tela_fimT + #837, #3967
  static tela_fimT + #838, #3967
  static tela_fimT + #839, #30

  ;Linha 21
  static tela_fimT + #840, #30
  static tela_fimT + #841, #3967
  static tela_fimT + #842, #2173
  static tela_fimT + #843, #125
  static tela_fimT + #844, #125
  static tela_fimT + #845, #125
  static tela_fimT + #846, #125
  static tela_fimT + #847, #2173
  static tela_fimT + #848, #1149
  static tela_fimT + #849, #1149
  static tela_fimT + #850, #1149
  static tela_fimT + #851, #1149
  static tela_fimT + #852, #1149
  static tela_fimT + #853, #1149
  static tela_fimT + #854, #1149
  static tela_fimT + #855, #1149
  static tela_fimT + #856, #1149
  static tela_fimT + #857, #1149
  static tela_fimT + #858, #2173
  static tela_fimT + #859, #2173
  static tela_fimT + #860, #2173
  static tela_fimT + #861, #2173
  static tela_fimT + #862, #2173
  static tela_fimT + #863, #2173
  static tela_fimT + #864, #3967
  static tela_fimT + #865, #59
  static tela_fimT + #866, #59
  static tela_fimT + #867, #59
  static tela_fimT + #868, #59
  static tela_fimT + #869, #59
  static tela_fimT + #870, #59
  static tela_fimT + #871, #59
  static tela_fimT + #872, #59
  static tela_fimT + #873, #59
  static tela_fimT + #874, #59
  static tela_fimT + #875, #59
  static tela_fimT + #876, #59
  static tela_fimT + #877, #59
  static tela_fimT + #878, #3967
  static tela_fimT + #879, #30

  ;Linha 22
  static tela_fimT + #880, #30
  static tela_fimT + #881, #3967
  static tela_fimT + #882, #2173
  static tela_fimT + #883, #125
  static tela_fimT + #884, #125
  static tela_fimT + #885, #125
  static tela_fimT + #886, #125
  static tela_fimT + #887, #2173
  static tela_fimT + #888, #1149
  static tela_fimT + #889, #1149
  static tela_fimT + #890, #1149
  static tela_fimT + #891, #1149
  static tela_fimT + #892, #1149
  static tela_fimT + #893, #1149
  static tela_fimT + #894, #1149
  static tela_fimT + #895, #1149
  static tela_fimT + #896, #1149
  static tela_fimT + #897, #2173
  static tela_fimT + #898, #2173
  static tela_fimT + #899, #2173
  static tela_fimT + #900, #3967
  static tela_fimT + #901, #3967
  static tela_fimT + #902, #3967
  static tela_fimT + #903, #3967
  static tela_fimT + #904, #3967
  static tela_fimT + #905, #3967
  static tela_fimT + #906, #3967
  static tela_fimT + #907, #3967
  static tela_fimT + #908, #3967
  static tela_fimT + #909, #3967
  static tela_fimT + #910, #3967
  static tela_fimT + #911, #3967
  static tela_fimT + #912, #3967
  static tela_fimT + #913, #3967
  static tela_fimT + #914, #3967
  static tela_fimT + #915, #3967
  static tela_fimT + #916, #3967
  static tela_fimT + #917, #3967
  static tela_fimT + #918, #3967
  static tela_fimT + #919, #30

  ;Linha 23
  static tela_fimT + #920, #30
  static tela_fimT + #921, #3967
  static tela_fimT + #922, #3967
  static tela_fimT + #923, #2173
  static tela_fimT + #924, #2173
  static tela_fimT + #925, #2173
  static tela_fimT + #926, #2173
  static tela_fimT + #927, #1149
  static tela_fimT + #928, #1149
  static tela_fimT + #929, #1149
  static tela_fimT + #930, #1149
  static tela_fimT + #931, #1149
  static tela_fimT + #932, #1149
  static tela_fimT + #933, #1149
  static tela_fimT + #934, #1149
  static tela_fimT + #935, #1149
  static tela_fimT + #936, #1149
  static tela_fimT + #937, #2173
  static tela_fimT + #938, #3967
  static tela_fimT + #939, #3967
  static tela_fimT + #940, #3967
  static tela_fimT + #941, #3967
  static tela_fimT + #942, #3967
  static tela_fimT + #943, #3967
  static tela_fimT + #944, #3967
  static tela_fimT + #945, #3967
  static tela_fimT + #946, #112
  static tela_fimT + #947, #108
  static tela_fimT + #948, #97
  static tela_fimT + #949, #121
  static tela_fimT + #950, #3967
  static tela_fimT + #951, #97
  static tela_fimT + #952, #103
  static tela_fimT + #953, #97
  static tela_fimT + #954, #105
  static tela_fimT + #955, #110
  static tela_fimT + #956, #37
  static tela_fimT + #957, #3967
  static tela_fimT + #958, #3967
  static tela_fimT + #959, #30

  ;Linha 24
  static tela_fimT + #960, #30
  static tela_fimT + #961, #3967
  static tela_fimT + #962, #3967
  static tela_fimT + #963, #2173
  static tela_fimT + #964, #1149
  static tela_fimT + #965, #1149
  static tela_fimT + #966, #1149
  static tela_fimT + #967, #1149
  static tela_fimT + #968, #1149
  static tela_fimT + #969, #1149
  static tela_fimT + #970, #1149
  static tela_fimT + #971, #1149
  static tela_fimT + #972, #1149
  static tela_fimT + #973, #1149
  static tela_fimT + #974, #1149
  static tela_fimT + #975, #1149
  static tela_fimT + #976, #2173
  static tela_fimT + #977, #3967
  static tela_fimT + #978, #3967
  static tela_fimT + #979, #3967
  static tela_fimT + #980, #3967
  static tela_fimT + #981, #3967
  static tela_fimT + #982, #3967
  static tela_fimT + #983, #3967
  static tela_fimT + #984, #3967
  static tela_fimT + #985, #3967
  static tela_fimT + #986, #3967
  static tela_fimT + #987, #3967
  static tela_fimT + #988, #3967
  static tela_fimT + #989, #3967
  static tela_fimT + #990, #3967
  static tela_fimT + #991, #3967
  static tela_fimT + #992, #3967
  static tela_fimT + #993, #3967
  static tela_fimT + #994, #3967
  static tela_fimT + #995, #3967
  static tela_fimT + #996, #3967
  static tela_fimT + #997, #3967
  static tela_fimT + #998, #3967
  static tela_fimT + #999, #30

  ;Linha 25
  static tela_fimT + #1000, #30
  static tela_fimT + #1001, #3967
  static tela_fimT + #1002, #3967
  static tela_fimT + #1003, #3967
  static tela_fimT + #1004, #2173
  static tela_fimT + #1005, #2173
  static tela_fimT + #1006, #2173
  static tela_fimT + #1007, #2173
  static tela_fimT + #1008, #2173
  static tela_fimT + #1009, #2173
  static tela_fimT + #1010, #1149
  static tela_fimT + #1011, #1149
  static tela_fimT + #1012, #2173
  static tela_fimT + #1013, #2173
  static tela_fimT + #1014, #2173
  static tela_fimT + #1015, #2173
  static tela_fimT + #1016, #2173
  static tela_fimT + #1017, #3967
  static tela_fimT + #1018, #3967
  static tela_fimT + #1019, #3967
  static tela_fimT + #1020, #3967
  static tela_fimT + #1021, #3967
  static tela_fimT + #1022, #3967
  static tela_fimT + #1023, #3967
  static tela_fimT + #1024, #3967
  static tela_fimT + #1025, #3967
  static tela_fimT + #1026, #3967
  static tela_fimT + #1027, #3967
  static tela_fimT + #1028, #3967
  static tela_fimT + #1029, #3967
  static tela_fimT + #1030, #889
  static tela_fimT + #1031, #47
  static tela_fimT + #1032, #47
  static tela_fimT + #1033, #366
  static tela_fimT + #1034, #3967
  static tela_fimT + #1035, #3967
  static tela_fimT + #1036, #3967
  static tela_fimT + #1037, #3967
  static tela_fimT + #1038, #3967
  static tela_fimT + #1039, #30

  ;Linha 26
  static tela_fimT + #1040, #30
  static tela_fimT + #1041, #3967
  static tela_fimT + #1042, #3967
  static tela_fimT + #1043, #3967
  static tela_fimT + #1044, #2173
  static tela_fimT + #1045, #2941
  static tela_fimT + #1046, #2941
  static tela_fimT + #1047, #2941
  static tela_fimT + #1048, #2941
  static tela_fimT + #1049, #2173
  static tela_fimT + #1050, #2173
  static tela_fimT + #1051, #2173
  static tela_fimT + #1052, #2173
  static tela_fimT + #1053, #2941
  static tela_fimT + #1054, #2941
  static tela_fimT + #1055, #2941
  static tela_fimT + #1056, #2941
  static tela_fimT + #1057, #2173
  static tela_fimT + #1058, #3967
  static tela_fimT + #1059, #3967
  static tela_fimT + #1060, #3967
  static tela_fimT + #1061, #3967
  static tela_fimT + #1062, #3967
  static tela_fimT + #1063, #3967
  static tela_fimT + #1064, #3967
  static tela_fimT + #1065, #3967
  static tela_fimT + #1066, #3967
  static tela_fimT + #1067, #3967
  static tela_fimT + #1068, #3967
  static tela_fimT + #1069, #3967
  static tela_fimT + #1070, #3967
  static tela_fimT + #1071, #3967
  static tela_fimT + #1072, #3967
  static tela_fimT + #1073, #3967
  static tela_fimT + #1074, #3967
  static tela_fimT + #1075, #3967
  static tela_fimT + #1076, #3967
  static tela_fimT + #1077, #3967
  static tela_fimT + #1078, #3967
  static tela_fimT + #1079, #30

  ;Linha 27
  static tela_fimT + #1080, #30
  static tela_fimT + #1081, #3967
  static tela_fimT + #1082, #3967
  static tela_fimT + #1083, #3967
  static tela_fimT + #1084, #2173
  static tela_fimT + #1085, #2941
  static tela_fimT + #1086, #2941
  static tela_fimT + #1087, #2941
  static tela_fimT + #1088, #2941
  static tela_fimT + #1089, #2941
  static tela_fimT + #1090, #2173
  static tela_fimT + #1091, #3967
  static tela_fimT + #1092, #2173
  static tela_fimT + #1093, #2941
  static tela_fimT + #1094, #2941
  static tela_fimT + #1095, #2941
  static tela_fimT + #1096, #2941
  static tela_fimT + #1097, #2941
  static tela_fimT + #1098, #2173
  static tela_fimT + #1099, #3967
  static tela_fimT + #1100, #3967
  static tela_fimT + #1101, #3967
  static tela_fimT + #1102, #3967
  static tela_fimT + #1103, #3967
  static tela_fimT + #1104, #3967
  static tela_fimT + #1105, #59
  static tela_fimT + #1106, #59
  static tela_fimT + #1107, #59
  static tela_fimT + #1108, #59
  static tela_fimT + #1109, #59
  static tela_fimT + #1110, #59
  static tela_fimT + #1111, #59
  static tela_fimT + #1112, #59
  static tela_fimT + #1113, #59
  static tela_fimT + #1114, #59
  static tela_fimT + #1115, #59
  static tela_fimT + #1116, #59
  static tela_fimT + #1117, #59
  static tela_fimT + #1118, #3967
  static tela_fimT + #1119, #30

  ;Linha 28
  static tela_fimT + #1120, #30
  static tela_fimT + #1121, #3967
  static tela_fimT + #1122, #3967
  static tela_fimT + #1123, #3967
  static tela_fimT + #1124, #3967
  static tela_fimT + #1125, #2173
  static tela_fimT + #1126, #2173
  static tela_fimT + #1127, #2173
  static tela_fimT + #1128, #2173
  static tela_fimT + #1129, #2173
  static tela_fimT + #1130, #2173
  static tela_fimT + #1131, #3967
  static tela_fimT + #1132, #2173
  static tela_fimT + #1133, #2173
  static tela_fimT + #1134, #2173
  static tela_fimT + #1135, #2173
  static tela_fimT + #1136, #2173
  static tela_fimT + #1137, #2173
  static tela_fimT + #1138, #3967
  static tela_fimT + #1139, #3967
  static tela_fimT + #1140, #3967
  static tela_fimT + #1141, #3967
  static tela_fimT + #1142, #3967
  static tela_fimT + #1143, #3967
  static tela_fimT + #1144, #3967
  static tela_fimT + #1145, #3967
  static tela_fimT + #1146, #3967
  static tela_fimT + #1147, #3967
  static tela_fimT + #1148, #3967
  static tela_fimT + #1149, #3967
  static tela_fimT + #1150, #3967
  static tela_fimT + #1151, #3967
  static tela_fimT + #1152, #3967
  static tela_fimT + #1153, #3967
  static tela_fimT + #1154, #3967
  static tela_fimT + #1155, #3967
  static tela_fimT + #1156, #3967
  static tela_fimT + #1157, #3967
  static tela_fimT + #1158, #3967
  static tela_fimT + #1159, #30

  ;Linha 29
  static tela_fimT + #1160, #64
  static tela_fimT + #1161, #60
  static tela_fimT + #1162, #60
  static tela_fimT + #1163, #60
  static tela_fimT + #1164, #60
  static tela_fimT + #1165, #60
  static tela_fimT + #1166, #60
  static tela_fimT + #1167, #60
  static tela_fimT + #1168, #60
  static tela_fimT + #1169, #60
  static tela_fimT + #1170, #60
  static tela_fimT + #1171, #60
  static tela_fimT + #1172, #60
  static tela_fimT + #1173, #60
  static tela_fimT + #1174, #60
  static tela_fimT + #1175, #60
  static tela_fimT + #1176, #60
  static tela_fimT + #1177, #60
  static tela_fimT + #1178, #60
  static tela_fimT + #1179, #60
  static tela_fimT + #1180, #62
  static tela_fimT + #1181, #62
  static tela_fimT + #1182, #62
  static tela_fimT + #1183, #62
  static tela_fimT + #1184, #62
  static tela_fimT + #1185, #62
  static tela_fimT + #1186, #62
  static tela_fimT + #1187, #62
  static tela_fimT + #1188, #62
  static tela_fimT + #1189, #62
  static tela_fimT + #1190, #62
  static tela_fimT + #1191, #62
  static tela_fimT + #1192, #62
  static tela_fimT + #1193, #62
  static tela_fimT + #1194, #62
  static tela_fimT + #1195, #62
  static tela_fimT + #1196, #62
  static tela_fimT + #1197, #62
  static tela_fimT + #1198, #62
  static tela_fimT + #1199, #64

;function to print the loser screen
printtela_fimTScreen:
	push r0
	push r1
	push r2
	push r3

	loadn r0, #tela_fimT
	loadn r1, #0
	loadn r2, #1200

	printtela_fimTScreenLoop:

    add r3,r0,r1
    loadi r3, r3
    outchar r3, r1
    inc r1
    cmp r1, r2
	jne printtela_fimTScreenLoop

	pop r3
	pop r2
	pop r1
	pop r0
	
	rts