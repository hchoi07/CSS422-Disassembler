*-----------------------------------------------------------
* Title      :MOVEQ EA Subroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matchs of the dettermined mode and register
* A1 will point to the location of the string constants
*-----------------------------------------------------------


MOVEQ_sub                                           ;preserve the registers 
                                 
;------------------Determine First Operand Data--------------------------------------------------------------------
MOVEQ_first_operand             AND.L             #mask_MOVEQ_first_operand,D1                    ;load mask for first operand
                                MOVE.L            A0,D3                                     ;pull the data
                                MOVE.L            #ea_lb,A1                                 ;load the # sign into string register
                                MOVE.L            D3,A1                                     ;move the data into A1
                                JSR               MOVEQ_second_operand

MOVEQ_second_operand            CLR.L        D2
                                MOVE.W      D0,D2
                                AND.L             #mask_MOVEQ_second_op_Dn,D2 
                                                   ;move the mask to D1
                                 
;-----------------------------------Determine Second Operand Data register--------------------------------
MOVEQ_Dn_reg                    CMP.L              #match_MOVEQ_D0,D2                         ;check to see in the register is 0
                                BNE                MOVEQ_rD1                                      ;if MOVEQ go check register 1
                                BEQ                MOVEQ_D0_output                                ;if equal go to output subroutine

MOVEQ_rD1						CMP.L              #match_MOVEQ_D1,D2                        ;check to see in the register is 1
                                BNE                MOVEQ_rD2                                     ;if MOVEQ go check register 2
                                BEQ                MOVEQ_D1_output                               ;if equal go to output subroutine

MOVEQ_rD2						CMP.L              #match_MOVEQ_D2,D2                        ;check to see in the register is 2
                                BNE                MOVEQ_rD3                                     ;if MOVEQ go check register 3
                                BEQ                MOVEQ_D2_output                               ;if equal go to output subroutine

MOVEQ_rD3                       CMP.L              #match_MOVEQ_D3,D2                       ;check to see in the register is 3
                                BNE                MOVEQ_rD4                                     ;if MOVEQ go check register 4
                                BEQ                MOVEQ_D3_output                              ;if equal go to output subroutine

MOVEQ_rD4                       CMP.L              #match_MOVEQ_D4,D2                       ;check to see in the register is 4
                                BNE                MOVEQ_rD5                                     ;if MOVEQ go check register 5
                                BEQ                MOVEQ_D4_output                              ;if equal go to output subroutine

MOVEQ_rD5                       CMP.L              #match_MOVEQ_D5,D2                       ;check to see in the register is 5
                                BNE                MOVEQ_rD6                                     ;if MOVEQ go check register 6
                                BEQ                MOVEQ_D5_output                              ;if equal go to output subroutine

MOVEQ_rD6                       CMP.L              #match_MOVEQ_D6,D2                       ;check to see in the register is 6
                                BNE                MOVEQ_rD7                                     ;if MOVEQ go check register 7
                                BEQ                MOVEQ_D6_output                              ;if equal go to output subroutine

MOVEQ_rD7                       CMP.L              #match_MOVEQ_D7,D2                       ;check to see in the register is 7
                                BEQ                MOVEQ_D7_output                              ;if equal go to output subroutine
                                BNE                ERROR                                 ;if MOVEQ equal to an addresssing mode, pritn error
                                
;--------------------Second Operand Data Register Output-----------------------
MOVEQ_D0_output				MOVE.L			#ea_D0,A1						;load string constant into A1
						    RTS												;return to subroutine
									
MOVEQ_D1_output				MOVE.L			#ea_D1,A1						;load string constant into A1
					    	RTS												;return to subroutine
									
MOVEQ_D2_output				MOVE.L			#ea_D2,A1						;load string constant into A1
				    	    RTS												;return to subroutine
									
MOVEQ_D3_output				MOVE.L			#ea_D3,A1						;load string constant into A1
					    	RTS												;return to subroutine
									
MOVEQ_D4_output				MOVE.L			#ea_D4,A1						;load string constant into A1
				    		RTS												;return to subroutine
									
MOVEQ_D5_output				MOVE.L			#ea_D5,A1						;load string constant into A1
						    RTS												;return to subroutine
									
MOVEQ_D6_output				MOVE.L			#ea_D6,A1						;load string constant into A1
					    	RTS												;return to subroutine
									
MOVEQ_D7_output				MOVE.L			#ea_D7,A1						;load string constant into A1
				    		RTS												;return to subroutine


*---------------------------------------------------------------------------------------------------------------------------
*                                   Variables
*---------------------------------------------------------------------------------------------------------------------------
mask_MOVEQ_second_op_Dn           EQU             $0E00              ;mask to determine the data register for second operand
mask_MOVEQ_first_operand          EQU             $00FF              ;mask to determine the data to be moved to the data register

match_MOVEQ_D0				EQU				$0000              ;match for data reg dir with data reg 0
match_MOVEQ_D1				EQU				$0200              ;match for data reg dir with data reg 1
match_MOVEQ_D2				EQU				$0400              ;match for data reg dir with data reg 2
match_MOVEQ_D3				EQU				$0600              ;match for data reg dir with data reg 3
match_MOVEQ_D4				EQU				$0800              ;match for data reg dir with data reg 4
match_MOVEQ_D5				EQU				$0A00              ;match for data reg dir with data reg 5
match_MOVEQ_D6				EQU				$0C00              ;match for data reg dir with data reg 6
match_MOVEQ_D7				EQU				$0E00              ;match for data reg dir with data reg 7






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
