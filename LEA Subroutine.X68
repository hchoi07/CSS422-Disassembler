*-----------------------------------------------------------
* Title      :LEA Subroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matchs of the dettermined mode and register
* A1 will point to the location of the string constants
*-----------------------------------------------------------    

   
LEA_sub                                             ;preserve the registers, 
                                 AND.L             #mask_LEA_ea_mode,D1                         ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
LEA_add_reg_indir                CMP.L             #match_LEA_An_indir,D1                       ;check to see if mode is add reg indir
                                 BNE               LEA_abs_add_word                             ;if not, go check add reg indir predec 
                                 BEQ               LEA_An_indir_reg                             ;if equal go figure out the register           
           
LEA_abs_add_word                 CLR.L          D2
                                 MOVE.W         D0,D2
                                 AND.L             #mask_LEA_abs_add,D2                         ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_LEA_abs_add_word,D2                   ;check if abs add word
                                 MOVE.L            (A0)+,D5                                     ;pull the next word instruction that holds the address
                                 BNE               LEA_abs_add_long                             ;if not go check abs add long
                                 BEQ               LEA_abs_add_word_out                         ;if equal go to output
  
LEA_abs_add_long                 CMP.L             #match_LEA_abs_add_long,D2                   ;check to see if abs add long
                                 BEQ               LEA_abs_add_long_out                         ;if equal go to output
                                 BNE               ERROR                                        ;if not equal go to error mesage sub routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                
                               
;------------------Address Register Indirect-----------------------
LEA_An_indir_reg                 CLR.L          D2
                                 MOVE.W         D0,D2
                                 AND.L           #mask_LEA_ea_reg_and_mode,D2                       ;load the mask into D2 for the mode and the register 
                                 CMP.L           #match_LEA_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             LEA_An_indir_reg1                           ;if not try reg 1
                                 BEQ             LEA_An_indir_reg0_out                       ;if equal go to output subroutine

LEA_An_indir_reg1                CMP.L           #match_LEA_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             LEA_An_indir_reg2                           ;if not try reg 2
                                 BEQ             LEA_An_indir_reg1_out                       ;if equal go to output subroutine

LEA_An_indir_reg2                CMP.L           #match_LEA_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             LEA_An_indir_reg3                           ;if not try reg 3
                                 BEQ             LEA_An_indir_reg2_out                       ;if equal go to output subroutine

LEA_An_indir_reg3                CMP.L           #match_LEA_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             LEA_An_indir_reg4                           ;if not try reg 4
                                 BEQ             LEA_An_indir_reg3_out                       ;if equal go to output subroutine
    
LEA_An_indir_reg4                CMP.L           #match_LEA_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             LEA_An_indir_reg5                           ;if not try reg 5
                                 BEQ             LEA_An_indir_reg4_out                       ;if equal go to output subroutine
        
LEA_An_indir_reg5                CMP.L           #match_LEA_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             LEA_An_indir_reg6                           ;if not try reg 6
                                 BEQ             LEA_An_indir_reg5_out                       ;if equal go to output subroutine

LEA_An_indir_reg6                CMP.L           #match_LEA_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             LEA_An_indir_reg7                           ;if not try reg 7
                                 BEQ             LEA_An_indir_reg6_out                       ;if equal go to output subroutine

LEA_An_indir_reg7                CMP.L           #match_LEA_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             LEA_An_indir_reg7_out                       ;if equal go to output subroutine
                                 BNE             ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
LEA_An_indir_reg0_out			        MOVE.L			#ea_indir_A0,A1		    	        ;load string constant into A1
                                        JSR             print_first
                                        JSR             LEA_determine_second_op                 ;jump to subroutine to determine second operand
                                        RTS

LEA_An_indir_reg1_out			        MOVE.L			#ea_indir_A1,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             LEA_determine_second_op                 ;jump to subroutine to determine second operand
                                        RTS

LEA_An_indir_reg2_out			        MOVE.L			#ea_indir_A2,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             LEA_determine_second_op                 ;jump to subroutine to determine second operand
                                        RTS

LEA_An_indir_reg3_out			        MOVE.L			#ea_indir_A3,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             LEA_determine_second_op                 ;jump to subroutine to determine second operand
                                        RTS

LEA_An_indir_reg4_out			        MOVE.L			#ea_indir_A4,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             LEA_determine_second_op                 ;jump to subroutine to determine second operand
                                        RTS

LEA_An_indir_reg5_out			        MOVE.L			#ea_indir_A5,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             LEA_determine_second_op                 ;jump to subroutine to determine second operand
                                        RTS

LEA_An_indir_reg6_out			        MOVE.L			#ea_indir_A6,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             LEA_determine_second_op                 ;jump to subroutine to determine second operand
                                        RTS
								        
LEA_An_indir_reg7_out			        MOVE.L			#ea_indir_A7,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             LEA_determine_second_op                 ;jump to subroutine to determine second operand
                                        RTS

;------------------Absolute Addressing Output-----------------------
LEA_abs_add_word_out					 MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                        JSR             print_first
                                         JSR         LEA_determine_second_op                 ;jump to subroutine to determine second operand
                                        RTS                                           

LEA_abs_add_long_out    	    		 MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                         MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                        JSR             print_first
                                         JSR         LEA_determine_second_op                 ;jump to subroutine to determine second operand
                                        RTS                                              
;---------------------------------Determine Register----------------------------------------------------------------------------------------
LEA_determine_second_op  						CLR.L		D2												;clear D2 
                                                MOVE.W      D0,D2
												AND.L		#mask_LEA_An_reg,D2								;load the mask for the register into D2, masks bit 11-9
												
LEA_reg0										CMP.L		#match_LEA_reg0,D2								;check to see if reg equal 0
												BNE			LEA_reg1										;if not equal got check reg 1
												BEQ			LEA_reg0_out									;if equal go to output
												
LEA_reg1										CMP.L		#match_LEA_reg1,D2								;check to see if reg equal 1
												BNE			LEA_reg2										;if not equal got check reg 2
												BEQ			LEA_reg1_out									;if equal go to output

LEA_reg2										CMP.L		#match_LEA_reg2,D2								;check to see if reg equal 2
												BNE			LEA_reg3										;if not equal got check reg 3
												BEQ			LEA_reg2_out									;if equal go to output

LEA_reg3										CMP.L		#match_LEA_reg3,D2								;check to see if reg equal 3
												BNE			LEA_reg4										;if not equal got check reg 4
												BEQ			LEA_reg3_out									;if equal go to output
												
LEA_reg4										CMP.L		#match_LEA_reg4,D2								;check to see if reg equal 4
												BNE			LEA_reg5										;if not equal got check reg 5
												BEQ			LEA_reg4_out									;if equal go to output

LEA_reg5										CMP.L		#match_LEA_reg5,D2								;check to see if reg equal 5
												BNE			LEA_reg6										;if not equal got check reg 6
												BEQ			LEA_reg5_out									;if equal go to output

LEA_reg6										CMP.L		#match_LEA_reg6,D2								;check to see if reg equal 6
												BNE			LEA_reg7										;if not equal got check reg 7
												BEQ			LEA_reg6_out									;if equal go to output			

LEA_reg7										CMP.L		#match_LEA_reg7,D2								;check to see if reg equal 7
												BEQ			LEA_reg7_out									;if equal go to output
												BNE         ERROR                                                       ;if not equal to an addresssing mode, pritn error
								

;--------------------Data Output-----------------------
LEA_reg0_out			                    MOVE.L			#ea_A0,A1					                       ;load string constant into A1
                                
                                            RTS
											
LEA_reg1_out			                    MOVE.L			#ea_A1,A1				                		;load string constant into A1
                                
                                            RTS
                                            
LEA_reg2_out			                    MOVE.L			#ea_A2,A1				                		;load string constant into A1
                                
                                            RTS
                                            
LEA_reg3_out			                    MOVE.L			#ea_A3,A1				                        	;load string constant into A1
                                
                                            RTS
                                            
LEA_reg4_out			                    MOVE.L			#ea_A4,A1				                    		;load string constant into A1
                                
                                            RTS
                                            
LEA_reg5_out			                    MOVE.L			#ea_A5,A1					                     	;load string constant into A1
                                
                                            RTS
                                            
LEA_reg6_out			                    MOVE.L			#ea_A6,A1					                    	;load string constant into A1
                                
                                            RTS
                                            
LEA_reg7_out			                    MOVE.L			#ea_A7,A1					                    	;load string constant into A1
                                
                                            RTS				

mask_LEA_ea_mode						EQU			$0038
mask_LEA_abs_add						EQU			$003F
mask_LEA_ea_reg_and_mode				EQU			$003F
mask_LEA_An_reg					    EQU			$0E00

match_LEA_An_indir						EQU			$0010
match_LEA_abs_add_word					EQU			$0038
match_LEA_abs_add_long					EQU			$0039

match_LEA_An_indir_r0					EQU			$0010
match_LEA_An_indir_r1					EQU			$0011
match_LEA_An_indir_r2					EQU			$0012
match_LEA_An_indir_r3					EQU			$0013
match_LEA_An_indir_r4					EQU			$0014
match_LEA_An_indir_r5					EQU			$0015
match_LEA_An_indir_r6					EQU			$0016
match_LEA_An_indir_r7					EQU			$0017

match_imm_add                           EQU         $003C
match_imm_add_word                      EQU         $00FC
match_imm_add_long                      EQU         $01FC

match_LEA_reg0							EQU			$0000
match_LEA_reg1							EQU			$0200
match_LEA_reg2							EQU			$0400
match_LEA_reg3							EQU			$0600
match_LEA_reg4							EQU			$0800
match_LEA_reg5							EQU			$0A00
match_LEA_reg6							EQU			$0C00
match_LEA_reg7							EQU			$0E00











*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
