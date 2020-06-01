*-----------------------------------------------------------
* Title      :NOT EA Subroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matchs of the dettermined mode and register
* A1 will point to the location of the string constants
* A3 will point to where the EA error message is stored in memory
*-----------------------------------------------------------

NOT_sub                          MOVEM.L           D1-D5/D7/A0-A6, -(SP)                                  ;preserve the registers, 
                                 AND.L             #mask_NOT_ea_mode,D1                                   ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
data_reg_dir                     CMP.L             #match_NOT_Dn,D1                               ;check to see if mode is data reg direct
                                 BNE               An_indir                                            ;if not, go check add reg dir
                                 BEQ               Dn_reg                                        ;if equal go figure out the register

An_indir                         CMP.L             #match_NOT_An_indir,D1                        ;check to see if mode is add reg indir
                                 BNE               An_indir_predec                                   ;if not, go check add reg indir predec 
                                 BEQ               An_indir_reg                                 ;if equal go figure out the register           

 
An_indir                         CMP.L             #match_NOT_An_indir,D1                        ;check to see if mode is add reg indir
                                 BNE               An_indir_predec                                   ;if not, go check add reg indir predec 
                                 BEQ               An_indir_reg                                 ;if equal go figure out the register           
           
An_indir_postinc                 CMP.L             #match_NOT_An_indir_postinc,D1            ;check to see if mode is add reg indor w/ postinc
                                 BNE               An_indir_predec                                  ;if not go check add reg indir/predec
                                 BEQ               An_indir_postinc_reg                         ;if equal go figure out the register
                      
An_indir_predec                  CMP.L             #match_NOT_An_indir_predec,D1              ;check to see if mode is add reg indir w/predec
                                 BNE               abs_add_word                                           ;if not go check abs add word
                                 BEQ               An_indir_predec_reg                      ;if equal go figure out the register

abs_add_word                     AND.L             #mask_NOT_ea_mode_abs_add,D2                            ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_NOT_abs_add_word,D2                      ;check if abs add word
                                 BNE               abs_add_long                                            ;if not go check abs add long
                                 BEQ               abs_add_word_out                             ;if equal go to output
  
abs_add_long                     CMP.L             #match_NOT_abs_add_long,D2                      ;check to see if abs add long
                                 BEQ               abs_add_long_out                            ;if equal go to output
								  BNE              ERROR                                        :if not equal to an addresssing mode, pritn error
							 

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 AND.L              #mask_NOT_ea_reg_and_mode,D2                       ;load the mask into D2 for the mode and the register
;-----------------------------------Data Register Direct--------------------------------
Dn_reg                          CMP.L              #match_NOT_D0,D2                       ;check to see in the register is 0
                                BNE                rD1                                     ;if not go check register 1
                                BEQ                D0_output                              ;if equal go to output subroutine

rD1						        CMP.L              #match_NOT_D1,D2                       ;check to see in the register is 1
                                BNE                rD2                                     ;if not go check register 2
                                BEQ                D1_output                              ;if equal go to output subroutine

rD2						        CMP.L              #match_NOT_D2,D2                       ;check to see in the register is 2
                                BNE                rD3                                     ;if not go check register 3
                                BEQ                D2_output                              ;if equal go to output subroutine

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
                                BNE              ERROR                                        :if not equal to an addresssing mode, pritn error
                                
;--------------------Data Register Direct Output-----------------------
D0_output				LEA			ea_D0,A1							;load string constant into A1
						RTS												;return to subroutine
									
D1_output				LEA			ea_D1,A1							;load string constant into A1
						RTS												;return to subroutine
									
D2_output				LEA			ea_D2,A1							;load string constant into A1
					    RTS												;return to subroutine
									
D3_output				LEA			ea_D3,A1							;load string constant into A1
						RTS												;return to subroutine
									
D4_output				LEA			ea_D4,A1							;load string constant into A1
						RTS												;return to subroutine
									
D5_output				LEA			ea_D5,A1							;load string constant into A1
						RTS												;return to subroutine
									
D6_output				LEA			ea_D6,A1							;load string constant into A1
						RTS												;return to subroutine
									
D7_output				LEA			ea_D7,A1							;load string constant into A1
						RTS												;return to subroutine
									
;------------------Address Register Indirect-----------------------
An_indir_reg                                CMP.L           #match_NOT_An_indir_r0,D2              ;check reg is equal to 0
                                            BNE             An_indir_reg1                            ;if not try reg 1
                                            BEQ             An_indir_reg0_out                     ;if equal go to output subroutine

An_indir_reg1                               CMP.L           #match_NOT_An_indir_r1,D2              ;check reg is equal to 1
                                            BNE             An_indir_reg2                            ;if not try reg 2
                                            BEQ             An_indir_reg1_out                     ;if equal go to output subroutine

An_indir_reg2                               CMP.L           #match_NOT_An_indir_r2,D2              ;check reg is equal to 2
                                            BNE             An_indir_reg3                            ;if not try reg 3
                                            BEQ             An_indir_reg2_out                     ;if equal go to output subroutine

An_indir_reg3                               CMP.L           #match_NOT_An_indir_r3,D2              ;check reg is equal to 3
                                            BNE             An_indir_reg4                            ;if not try reg 4
                                            BEQ             An_indir_reg3_out                     ;if equal go to output subroutine

An_indir_reg4                               CMP.L           #match_NOT_An_indir_r4,D2              ;check reg is equal to 4
                                            BNE             An_indir_reg5                            ;if not try reg 5
                                            BEQ             An_indir_reg4_out                    ;if equal go to output subroutine

An_indir_reg5                               CMP.L           #match_NOT_An_indir_r5,D2              ;check reg is equal to 5
                                            BNE             An_indir_reg6                            ;if not try reg 6
                                            BEQ             An_indir_reg5_out                     ;if equal go to output subroutine

An_indir_reg6                               CMP.L           #match_NOT_An_indir_r6,D2              ;check reg is equal to 6
                                            BEQ             An_indir_reg6_out                     ;if equal go to output subroutine
                                            BNE              ERROR                                        :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
An_indir_reg0_out			            LEA			ea_indir_A0,A1							;load string constant into A1
								        RTS												            ;return to subroutine
									
An_indir_reg1_out			            LEA			ea_indir_A1,A1							;load string constant into A1
								        RTS												            ;return to subroutine
											
An_indir_reg2_out		             	LEA			ea_indir_A2,A1							;load string constant into A1
							        	RTS							        					;return to subroutine

An_indir_reg3_out		             	LEA			ea_indir_A3,A1							;load string constant into A1
    					            	RTS									        			;return to subroutine
											
An_indir_reg4_out		             	LEA			ea_indir_A4,A1							;load string constant into A1
						        		RTS											            	;return to subroutine
										
An_indir_reg5_out			            LEA			ea_indir_A5,A1							;load string constant into A1
								        RTS			        									;return to subroutine

An_indir_reg6_out			            LEA			ea_indir_A6,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine


;------------------Address Register Indirect with Post Increment-----------------------
An_indir_postinc_reg                        CMP.L      #match_NOT_An_indir_postinc_r0,D2        ;check reg is equal to 0

                                            BNE        An_indir_postinc_reg1                      ;if not try reg 1
                                            BEQ        An_indir_postinc_reg0_out               ;if equal go to output subroutine

An_indir_postinc_reg1                       CMP.L      #match_NOT_An_indir_postinc_r1,D2        ;check reg is equal to 1
                                            BNE        An_indir_postinc_reg2                      ;if not try reg 2
                                            BEQ        An_indir_postinc_reg1_out               ;if equal go to output subroutine

An_indir_postinc_reg2                       CMP.L      #match_NOT_An_indir_postinc_r2,D2        ;check reg is equal to 2
                                            BNE        An_indir_postinc_reg3                      ;if not try reg 3
                                            BEQ        An_indir_postinc_reg2_out               ;if equal go to output subroutine
    
An_indir_postinc_reg3                       CMP.L      #match_NOT_An_indir_postinc_r3,D2        ;check reg is equal to 3
                                            BNE        An_indir_postinc_reg4                      ;if not try reg 4
                                            BEQ        An_indir_postinc_reg3_out               ;if equal go to output subroutine
 
An_indir_postinc_reg4                       CMP.L      #match_NOT_An_indir_postinc_r4,D2        ;check reg is equal to 4
                                            BNE        An_indir_postinc_reg5                      ;if not try reg 5
                                            BEQ        An_indir_postinc_reg4_out               ;if equal go to output subroutine

An_indir_postinc_reg5                       CMP.L      #match_NOT_An_indir_postinc_r5,D2        ;check reg is equal to 5
                                            BNE        An_indir_postinc_reg6                      ;if not try reg 6
                                            BEQ        An_indir_postinc_reg5_out               ;if equal go to output subroutine

An_indir_postinc_reg6                       CMP.L      #match_NOT_An_indir_postinc_r6,D2        ;check reg is equal to 6
                                            BEQ        An_indir_postinc_reg6_out              ;if equal go to output subroutine
                                            BNE              ERROR                                        :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
An_indir_postinc_reg0_out		        	LEA		    	ea_indir_postinc_A1,A1							;load string constant into A1
											RTS												;return to subroutine

An_indir_postinc_reg1_out		        	LEA		    	ea_indir_postinc_A1,A1							;load string constant into A1
											RTS												;return to subroutine

An_indir_postinc_reg2_out		        	LEA			    ea_indir_postinc_A2,A1							;load string constant into A1
											RTS												;return to subroutine

An_indir_postinc_reg3_out		        	LEA			    ea_indir_postinc_A3,A1							;load string constant into A1
											RTS												;return to subroutine

An_indir_postinc_reg4_out		          	LEA		    	ea_indir_postinc_A4,A1							;load string constant into A1
								  			RTS												;return to subroutine

An_indir_postinc_reg5_out			        LEA			    ea_indir_postinc_A5,A1							;load string constant into A1
											RTS												;return to subroutine
 
An_indir_postinc_reg6_out			        LEA		    	ea_indir_postinc_A6,A1							;load string constant into A1
											RTS												;return to subroutine
													
;------------------Address Register Indirect with Pre Decrement-----------------------
An_indir_predec_reg                  	    CMP.L      #match_NOT_An_indir_predec_r0,D2         ;check reg is equal to 0
                                            BNE        An_indir_predec_reg1                      ;if not try reg 1
                                            BEQ        An_indir_predec_reg0_out               ;if equal go to output subroutine

An_indir_predec_reg1                        CMP.L      #match_NOT_An_indir_predec_r1,D2         ;check reg is equal to 1
                                            BNE        An_indir_predec_reg2                      ;if not try reg 2
                                            BEQ        An_indir_predec_reg1_out               ;if equal go to output subroutine

An_indir_predec_reg2                        CMP.L      #match_NOT_An_indir_predec_r2,D2         ;check reg is equal to 2
                                            BNE        An_indir_predec_reg3                      ;if not try reg 3
                                            BEQ        An_indir_predec_reg2_out               ;if equal go to output subroutine

An_indir_predec_reg3                        CMP.L      #match_NOT_An_indir_predec_r3,D2         ;check reg is equal to 3
                                            BNE        An_indir_predec_reg4                      ;if not try reg 4
                                            BEQ        An_indir_predec_reg3_out               ;if equal go to output subroutine

An_indir_predec_reg4                        CMP.L      #match_NOT_An_indir_predec_r4,D2         ;check reg is equal to 4
                                            BNE        An_indir_predec_reg5                      ;if not try reg 5
                                            BEQ        An_indir_predec_reg4_out               ;if equal go to output subroutine

An_indir_predec_reg5                        CMP.L      #match_NOT_An_indir_predec_r5,D2         ;check reg is equal to 5
                                            BNE        An_indir_predec_reg6                      ;if not try reg 6
                                            BEQ        An_indir_predec_reg5_out               ;if equal go to output subroutine

An_indir_predec_reg6                        CMP.L      #match_NOT_An_indir_predec_r6,D2         ;check reg is equal to 6
                                            BEQ        An_indir_predec_reg6_out               ;if equal go to output subroutine
                                            BNE              ERROR                                        :if not equal to an addresssing mode, pritn error
;--------------------Address Register Indirect with Pre Decrement Output-----------------------
An_indir_predec_reg0_out			        LEA			ea_indir_predec_A0,A1							;load string constant into A1
											RTS														;return to subroutine

An_indir_predec_reg1_out			        LEA			ea_indir_predec_A1,A1							;load string constant into A1
											RTS														;return to subroutine
													
An_indir_predec_reg2_out			        LEA			ea_indir_predec_A2,A1							;load string constant into A1
											RTS														;return to subroutine

An_indir_predec_reg3_out			        LEA			ea_indir_predec_A3,A1							;load string constant into A1
											RTS														;return to subroutine

An_indir_predec_reg4_out			        LEA			ea_indir_predec_A4,A1							;load string constant into A1
											RTS														;return to subroutine
	
An_indir_predec_reg5_out		        	LEA			ea_indir_predec_A5,A1							;load string constant into A1
											RTS														;return to subroutine
	
An_indir_predec_reg6_out		        	LEA			ea_indir_predec_A6,A1							;load string constant into A1
											RTS														;return to subroutine
													
;------------------Absolute Addressing Output-----------------------
abs_add_word_out							LEA			ea_paren_open,A1							;load the open parenthesis
											LEA			ea_$,A1									;load $ for hex
											MOVEM.W		(PC),A2										;pull the next 16 bits for the absolute address
											MOVE.L		A2,A1									;load address
											LEA			ea_paren_closed,A1						;load close parenthesis 
											RTS

abs_add_long_out							LEA			ea_paren_open,A1							;load the open parenthesis
											LEA			ea_$,A1									;load $ for hex
											MOVEM.L		(PC),A2										;pull the next 32 bits for the absolute address
											MOVE.L		A2,A1									;load address
											LEA			ea_paren_closed,A1						;load close parenthesis 
                                           RTS

    SIMHALT             ; halt simulator


mask_NOT_ea_mode							EQU				$0038              ;masks bits 5-3 to determine ea mode
mask_NOT_ea_reg_and_mode					EQU				$003F              ;masks bits 5-0 to determine the register with the given mode
mask_NOT_ea_mode_abs_add					EQU				$003F

match_NOT_Dn								EQU				$0000              ;match for data reg dir
match_NOT_An_indir							EQU				$0010              ;match for add reg indir
match_NOT_An_indir_postinc			      	EQU				$0020              ;match for add reg indir with postinc
match_NOT_An_indir_predec				    EQU				$0018              ;match for add reg indir with predec
match_NOT_abs_add_word						EQU				$0039      		   ;match for word abs add 
match_NOT_abs_add_long						EQU				$003C              ;match for long abs add

match_NOT_D0								EQU				$0000              ;match for data reg dir with data reg 0
match_NOT_D1								EQU				$0001              ;match for data reg dir with data reg 1
match_NOT_D2								EQU				$0002              ;match for data reg dir with data reg 2
match_NOT_D3								EQU				$0003              ;match for data reg dir with data reg 3
match_NOT_D4								EQU				$0004              ;match for data reg dir with data reg 4
match_NOT_D5								EQU				$0005              ;match for data reg dir with data reg 5
match_NOT_D6								EQU				$0006              ;match for data reg dir with data reg 6
match_NOT_D7								EQU				$0007              ;match for data reg dir with data reg 7

match_NOT_An_indir_r0				        EQU				$0010              ;match for add reg indir with add reg 0
match_NOT_An_indir_r1			        	EQU				$0011              ;match for add reg indir with add reg 1
match_NOT_An_indir_r2			        	EQU				$0012              ;match for add reg indir with add reg 2
match_NOT_An_indir_r3			        	EQU				$0013              ;match for add reg indir with add reg 3
match_NOT_An_indir_r4		        		EQU				$0014              ;match for add reg indir with add reg 4
match_NOT_An_indir_r5		        		EQU				$0015              ;match for add reg indir with add reg 5
match_NOT_An_indir_r6			        	EQU				$0016              ;match for add reg indir with add reg 6

match_NOT_An_indir_postinc_r0	        	EQU				$0020              ;match for add reg indir with postinc with add reg 0
match_NOT_An_indir_postinc_r1	        	EQU				$0021              ;match for add reg indir with postinc with add reg 1
match_NOT_An_indir_postinc_r2	        	EQU				$0022              ;match for add reg indir with postinc with add reg 2
match_NOT_An_indir_postinc_r3	        	EQU				$0023              ;match for add reg indir with postinc with add reg 3
match_NOT_An_indir_postinc_r4	        	EQU				$0024              ;match for add reg indir with postinc with add reg 4
match_NOT_An_indir_postinc_r5	        	EQU				$0025              ;match for add reg indir with postinc with add reg 5
match_NOT_An_indir_postinc_r6	        	EQU				$0026              ;match for add reg indir with postinc with add reg 6

match_NOT_An_indir_predec_r0		       	EQU				$0018              ;match for add reg indir with predec with add reg 0
match_NOT_An_indir_predec_r1		       	EQU				$0019              ;match for add reg indir with predec with add reg 1
match_NOT_An_indir_predec_r2		    	EQU				$001A              ;match for add reg indir with predec with add reg 2
match_NOT_An_indir_predec_r3		    	EQU				$001B              ;match for add reg indir with predec with add reg 3
match_NOT_An_indir_predec_r4		    	EQU				$001C              ;match for add reg indir with predec with add reg 4
match_NOT_An_indir_predec_r5	    		EQU				$001D              ;match for add reg indir with predec with add reg 5
match_NOT_An_indir_predec_r6		    	EQU				$001F              ;match for add reg indir with predec with add reg 6

ea_D0				    	DC.B		'D0',0
ea_D1			    		DC.B		'D1',0
ea_D2			    		DC.B		'D2',0
ea_D3				    	DC.B		'D3',0
ea_D4			    		DC.B		'D4',0
ea_D5			    		DC.B		'D5',0
ea_D6				    	DC.B		'D6',0
ea_D7			   	    	DC.B		'D7',0

ea_indir_A0		    		DC.B		'(A0)',0
ea_indir_A1		    		DC.B		'(A1)',0
ea_indir_A2		    		DC.B		'(A2)',0
ea_indir_A3		    		DC.B		'(A3)',0
ea_indir_A4			    	DC.B		'(A4)',0
ea_indir_A5			    	DC.B		'(A5)',0
ea_indir_A6			    	DC.B		'(A6)',0


ea_indir_postinc_A0			DC.B		'(A0)+',0
ea_indir_postinc_A1			DC.B		'(A1)+',0
ea_indir_postinc_A2			DC.B		'(A2)+',0
ea_indir_postinc_A3			DC.B		'(A3)+',0
ea_indir_postinc_A4			DC.B		'(A4)+',0
ea_indir_postinc_A5			DC.B		'(A5)+',0
ea_indir_postinc_A6			DC.B		'(A6)+',0


ea_indir_predec_A0			DC.B		'-(A0)',0
ea_indir_predec_A1			DC.B		'-(A1)',0
ea_indir_predec_A2			DC.B		'-(A2)',0
ea_indir_predec_A3			DC.B		'-(A3)',0
ea_indir_predec_A4			DC.B		'-(A4)',0
ea_indir_predec_A5			DC.B		'-(A5)',0
ea_indir_predec_A6			DC.B		'-(A6)',0


ea_paren_open			    DC.B		'(',0
ea_paren_closed		    	DC.B		')',0
ea_abs_word_string	    	DC.B		'.W',0
ea_abs_long_string	    	DC.B		'.L',0
ea_$				    	DC.B		'$',0

ERROR_MESSAGE               DC.B        'Incorrect EA format',0

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
