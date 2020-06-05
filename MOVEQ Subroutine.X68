*-----------------------------------------------------------
* Title      :NOT EA Subroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matchs of the dettermined mode and register
* A1 will point to the location of the string constants
*-----------------------------------------------------------
START               ORG         $1000

NOT_sub                          MOVEM.L           D1-D5/D7/A0-A6, -(A7)                     ;preserve the registers 
                                 
;------------------Determine First Operand Data--------------------------------------------------------------------
first_operand                   AND.L             #mask_first_operand,D1                    ;load mask for first operand
                                MOVE.B            A0,D3                                     ;pull the data
                                MOVE.B            #ea_lb,A1                                 ;load the # sign into string register
                                MOVE.B            D3,A1                                     ;move the data into A1
                                JSR               second_operand

second_operand                  AND.L             #mask_second_op_Dn,D1                     ;move the mask to D1
                                 
;-----------------------------------Determine Second Operand Data register--------------------------------
Dn_reg                          CMP.L              #match_NOT_D0,D2                         ;check to see in the register is 0
                                BNE                rD1                                      ;if not go check register 1
                                BEQ                D0_output                                ;if equal go to output subroutine

rD1						        CMP.L              #match_NOT_D1,D2                        ;check to see in the register is 1
                                BNE                rD2                                     ;if not go check register 2
                                BEQ                D1_output                               ;if equal go to output subroutine

rD2						        CMP.L              #match_NOT_D2,D2                        ;check to see in the register is 2
                                BNE                rD3                                     ;if not go check register 3
                                BEQ                D2_output                               ;if equal go to output subroutine

rD3                             CMP.L              #match_NOT_D3,D2                       ;check to see in the register is 3
                                BNE                rD4                                     ;if not go check register 4
                                BEQ                D3_output                              ;if equal go to output subroutine

rD4                             CMP.L              #match_NOT_D4,D2                       ;check to see in the register is 4
                                BNE                rD5                                     ;if not go check register 5
                                BEQ                D4_output                              ;if equal go to output subroutine

rD5                             CMP.L              #match_NOT_D5,D2                       ;check to see in the register is 5
                                BNE                rD6                                     ;if not go check register 6
                                BEQ                D5_output                              ;if equal go to output subroutine

rD6                             CMP.L              #match_NOT_D6,D2                       ;check to see in the register is 6
                                BNE                rD7                                     ;if not go check register 7
                                BEQ                D6_output                              ;if equal go to output subroutine

rD7                             CMP.L              #match_NOT_D7,D2                       ;check to see in the register is 7
                                BEQ                D7_output                              ;if equal go to output subroutine
                                BNE                ERROR                                 ;if not equal to an addresssing mode, pritn error
                                
;--------------------Second Operand Data Register Output-----------------------
D0_output				MOVE.L			#ea_D0,A1						;load string constant into A1
						RTS												;return to subroutine
									
D1_output				MOVE.L			#ea_D1,A1						;load string constant into A1
						RTS												;return to subroutine
									
D2_output				MOVE.L			#ea_D2,A1						;load string constant into A1
					    RTS												;return to subroutine
									
D3_output				MOVE.L			#ea_D3,A1						;load string constant into A1
						RTS												;return to subroutine
									
D4_output				MOVE.L			#ea_D4,A1						;load string constant into A1
						RTS												;return to subroutine
									
D5_output				MOVE.L			#ea_D5,A1						;load string constant into A1
						RTS												;return to subroutine
									
D6_output				MOVE.L			#ea_D6,A1						;load string constant into A1
						RTS												;return to subroutine
									
D7_output				MOVE.L			#ea_D7,A1						;load string constant into A1
						RTS												;return to subroutine
									
;----------------------Error Handling----------------------------------------
ERROR                                           LEA     ERROR_MESSAGE,A1                                          ;load error messge into A3
												RTS
												
												
ERROR_MESSAGE               DC.B            'Incorrect EA Format',0
mask_second_op_Dn           EQU             $0E00              ;mask to determine the data register for second operand
mask_first_operand          EQU             $00FF              ;mask to determine the data to be moved to the data register

match_NOT_D0				EQU				$0000              ;match for data reg dir with data reg 0
match_NOT_D1				EQU				$0200              ;match for data reg dir with data reg 1
match_NOT_D2				EQU				$0400              ;match for data reg dir with data reg 2
match_NOT_D3				EQU				$0600              ;match for data reg dir with data reg 3
match_NOT_D4				EQU				$0800              ;match for data reg dir with data reg 4
match_NOT_D5				EQU				$0A00              ;match for data reg dir with data reg 5
match_NOT_D6				EQU				$0C00              ;match for data reg dir with data reg 6
match_NOT_D7				EQU				$0E00              ;match for data reg dir with data reg 7


ea_D0				    	DC.B	    	'D0',0
ea_D1			    		DC.B	    	'D1',0
ea_D2			    		DC.B	    	'D2',0
ea_D3				    	DC.B	    	'D3',0
ea_D4			    		DC.B	    	'D4',0
ea_D5			    		DC.B	    	'D5',0
ea_D6				    	DC.B	    	'D6',0
ea_D7			   	    	DC.B	    	'D7',0
ea_lb                       DC.B            '#',0     
                            END                     START



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
