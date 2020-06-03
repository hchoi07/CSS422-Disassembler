*-----------------------------------------------------------
* Title      :ADDA Subroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matchs of the dettermined mode and register
* A1 will point to the location of the string constants
* A3 will point to the error message in memory
*-----------------------------------------------------------    ORG    $1000
START:                  ; first instruction of program

   
ADDA_sub                         MOVEM.L           D1-D5/D7/A0-A6, -(SP)                                  ;preserve the registers, 
                                 AND.L             #mask_ADDA_ea_mode,D1                                   ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
data_reg_dir                     CMP.L             #match_ADDA_Dn,D1                             ;check to see if mode is data reg direct
                                 BNE               add_reg_dir                                   ;if not, go check add reg dir
                                 BEQ               Dn_reg                                        ;if equal go figure out the register

add_reg_dir                      CMP.L             #match_ADDA_An,D1                             ;check if mode is add reg direct
                                 BNE               add_reg_indir                                 ;if not, go check add reg indir
                                 BEQ               An_reg                                        ;if equal go figure out the reg
 
add_reg_indir                    CMP.L             #match_ADDA_An_indir,D1                       ;check to see if mode is add reg indir
                                 BNE               add_reg_indir_predec                          ;if not, go check add reg indir predec 
                                 BEQ               An_indir_reg                                  ;if equal go figure out the register           
           
add_reg_indir_predec             CMP.L             #match_ADDA_An_indir_predec,D1                ;check to see if mode is add reg indor w/ postinc
                                 BNE               add_reg_indir_postinc                         ;if not go check add reg indir/predec
                                 BEQ               An_indir_predec                               ;if equal go figure out the register
                      
add_reg_indir_postinc            CMP.L             #match_ADDA_An_indir_postinc,D1               ;check to see if mode is add reg indir w/predec
                                 BNE               abs_add_word                                  ;if not go check abs add word
                                 BEQ               An_indir_postinc_reg                          ;if equal go figure out the register

abs_add_word                     AND.L             #mask_ADDA_abs_add,D2                         ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_ADDA_abs_add_word,D2                   ;check if abs add word
                                 BNE               abs_add_long                                  ;if not go check abs add long
                                 BEQ               abs_add_word_out                              ;if equal go to output
  
abs_add_long                     CMP.L             #match_ADDA_abs_add_long,D2                    ;check to see if abs add long
                                 BEQ               abs_add_long_out                               ;if equal go to output
                                 
immediate_add                    CMP.L             #match_imm_add,D1                                ;check if immediate address
                                 BEQ               immediate_add_out                                    ;if equal go to immediate add sub routine
								 BNE               ERROR                                            ;if not equal go to error mesage sub routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 AND.L              #mask_ADDA_ea_reg_and_mode,D2                       ;load the mask into D2 for the mode and the register
;-----------------------------------Data Register Direct--------------------------------
Dn_reg                           CMP.L              #match_ADDA_D0,D2                       ;check to see in the register is 0
                                 BNE                rD1                                     ;if not go check register 1
                                 BEQ                D0_out                              ;if equal go to output subroutine

rD1                              CMP.L              #match_ADDA_D1,D2                       ;check to see in the register is 1
                                 BNE                rD2                                     ;if not go check register 2
                                 BEQ                D1_out                              ;if equal go to output subroutine

rD2                              CMP.L              #match_ADDA_D2,D2                       ;check to see in the register is 2
                                 BNE                rD3                                     ;if not go check register 3
                                 BEQ                D2_out                              ;if equal go to output subroutine

rD3                              CMP.L              #match_ADDA_D3,D2                       ;check to see in the register is 3
                                 BNE                rD4                                     ;if not go check register 4
                                 BEQ                D3_out                              ;if equal go to output subroutine

rD4                              CMP.L              #match_ADDA_D4,D2                       ;check to see in the register is 4
                                 BNE                rD5                                     ;if not go check register 5
                                 BEQ                D4_out                              ;if equal go to output subroutine

rD5                              CMP.L              #match_ADDA_D5,D2                       ;check to see in the register is 5
                                 BNE                rD6                                     ;if not go check register 6
                                 BEQ                D5_out                              ;if equal go to output subroutine

rD6                              CMP.L              #match_ADDA_D6,D2                       ;check to see in the register is 6
                                 BNE                rD7                                     ;if not go check register 7
                                 BEQ                D6_out                              ;if equal go to output subroutine

rD7                              CMP.L              #match_ADDA_D7,D2                       ;check to see in the register is 7
                                 BEQ                D7_out                              ;if equal go to output subroutine
                                 BNE                ERROR                               ;if not equal, got to error message
;--------------------Data Register Direct Output-----------------------
D0_out                          MOVE.L          #ea_D0,A1							;load string constant into A1
                                RTS												;return to subroutine

D1_out                         MOVE.L          #ea_D1,A1							;load string constant into A1
        						RTS												;return to subroutine


D2_out                          MOVE.L          #ea_D2,A1							;load string constant into A1
        						RTS												;return to subroutine

D3_out                         MOVE.L			#ea_D3,A1							;load string constant into A1
                               RTS												;return to subroutine


D4_out                          MOVE.L			#ea_D4,A1							;load string constant into A1
        						RTS												;return to subroutine


D5_out                          MOVE.L			#ea_D5,A1							;load string constant into A1
        						RTS												;return to subroutine


D6_out                         MOVE.L			#ea_D6,A1							;load string constant into A1
        						RTS												;return to subroutine


D7_out                         MOVE.L			#ea_D7,A1							;load string constant into A1
        						RTS												;return to subroutine

;------------------Address Register Direct-----------------------
An_reg                           CMP.L           #match_ADDA_A0,D2                      ;check reg is equal to 0
                                 BNE             rA1                                  ;if not try reg 1
                                 BEQ             An_indir_reg0_out                     ;if equal go to output subroutine

rA1                              CMP.L           #match_ADDA_A1,D2                      ;check reg is equal to 1
                                 BNE             rA2                                  ;if not try reg 2
                                 BEQ             An_indir_reg1_out                     ;if equal go to output subroutine

rA2                              CMP.L           #match_ADDA_A2,D2                     ;check reg is equal to 2
                                 BNE             rA3                                  ;if not try reg 3
                                 BEQ             An_indir_reg2_out                     ;if equal go to output subroutine

rA3                              CMP.L           #match_ADDA_A3,D2                       ;check reg is equal to 3
                                 BNE             rA4                                    ;if not try reg 4
                                 BEQ             An_indir_reg3_out                     ;if equal go to output subroutine

rA4                              CMP.L           #match_ADDA_A4,D2                       ;check reg is equal to 4
                                 BNE             rA5                                    ;if not try reg 5
                                 BEQ             An_indir_reg4_out                     ;if equal go to output subroutine
            
rA5                              CMP.L           #match_ADDA_A5,D2                      ;check reg is equal to 5
                                 BNE             rA6                                  ;if not try reg 6
                                 BEQ             An_indir_reg5_out                     ;if equal go to output subroutine

rA6                              CMP.L           #match_ADDA_A6,D2                                     ;check reg is equal to 6
                                 BNE             rA7                                  ;if not try reg 7
                                 BEQ             An_indir_reg6_out                     ;if equal go to output subroutine

rA7                              CMP.L           #match_ADDA_A7,D2                      ;check reg is equal to 7
                                 BEQ             An_indir_reg7_out                      ;if equal go to output subroutine
                                 BNE             ERROR                                  :if not equal to an addresssing mode, pritn error

;--------------------Address Register Direct Output-----------------------
A0_out                         MOVE.L			#ea_A0,A1							;load string constant into A1
        						RTS											;return to subroutine
        						
A1_out                         MOVE.L			#ea_A1,A1							;load string constant into A1
        						RTS												;return to subroutine
        						
A2_out                         MOVE.L			#ea_A2,A1							;load string constant into A1
        						RTS												;return to subroutine
        						
A3_out                         MOVE.L			#ea_A3,A1							;load string constant into A1
                               RTS												;return to subroutine

A4_out                         MOVE.L			#ea_A4,A1							;load string constant into A1
                               RTS												;return to subroutine

A5_out                         MOVE.L			#ea_A5,A1							;load string constant into A1
                               RTS												;return to subroutine

A6_out                         MOVE.L			#ea_A6,A1							;load string constant into A1
                               RTS												;return to subroutine

A7_out                         MOVE.L			#ea_A7,A1							;load string constant into A1
                               RTS												;return to subroutine

;------------------Address Register Indirect-----------------------
An_indir_reg                      CMP.L          #match_ADDA_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             An_indir_reg1                           ;if not try reg 1
                                 BEQ             An_indir_reg0_out                       ;if equal go to output subroutine

An_indir_reg1                    CMP.L           #match_ADDA_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             An_indir_reg2                           ;if not try reg 2
                                 BEQ             An_indir_reg1_out                       ;if equal go to output subroutine

An_indir_reg2                    CMP.L           #match_ADDA_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             An_indir_reg3                           ;if not try reg 3
                                 BEQ             An_indir_reg2_out                       ;if equal go to output subroutine

An_indir_reg3                    CMP.L           #match_ADDA_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             An_indir_reg4                           ;if not try reg 4
                                 BEQ             An_indir_reg3_out                       ;if equal go to output subroutine
    
An_indir_reg4                    CMP.L           #match_ADDA_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             An_indir_reg5                           ;if not try reg 5
                                 BEQ             An_indir_reg4_out                       ;if equal go to output subroutine
        
An_indir_reg5                    CMP.L           #match_ADDA_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             An_indir_reg6                           ;if not try reg 6
                                 BEQ             An_indir_reg5_out                       ;if equal go to output subroutine

An_indir_reg6                    CMP.L           #match_ADDA_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             An_indir_reg7                           ;if not try reg 7
                                 BEQ             An_indir_reg6_out                       ;if equal go to output subroutine

An_indir_reg7                    CMP.L           #match_ADDA_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             An_indir_reg7_out                       ;if equal go to output subroutine
                                 BNE             ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
An_indir_reg0_out			            MOVE.L			#ea_indir_A0,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine

An_indir_reg1_out			            MOVE.L			#ea_indir_A1,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine

An_indir_reg2_out			            MOVE.L			#ea_indir_A2,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine

An_indir_reg3_out			            MOVE.L			#ea_indir_A3,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine

An_indir_reg4_out			            MOVE.L			#ea_indir_A4,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine

An_indir_reg5_out			            MOVE.L			#ea_indir_A5,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine

An_indir_reg6_out			            MOVE.L			#ea_indir_A6,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine
								        
An_indir_reg7_out			            MOVE.L			#ea_indir_A7,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine

;------------------Address Register Indirect with Post Increment-----------------------
An_indir_postinc_reg                        CMP.L      #match_ADDA_An_indir_postinc_reg0,D2        ;check reg is equal to 0
                                            BNE        An_indir_postinc_reg1                      ;if not try reg 1
                                            BEQ        An_indir_postinc_reg0_out               ;if equal go to output subroutine

An_indir_postinc_reg1                       CMP.L      #match_ADDA_An_indir_postinc_reg1,D2        ;check reg is equal to 1
                                            BNE        An_indir_postinc_reg2                      ;if not try reg 2
                                            BEQ        An_indir_postinc_reg1_out               ;if equal go to output subroutine

An_indir_postinc_reg2                       CMP.L      #match_ADDA_An_indir_postinc_reg2,D2        ;check reg is equal to 2
                                            BNE        An_indir_postinc_reg3                      ;if not try reg 3
                                            BEQ        An_indir_postinc_reg2_out               ;if equal go to output subroutine

An_indir_postinc_reg3                       CMP.L      #match_ADDA_An_indir_postinc_reg3,D2        ;check reg is equal to 3
                                            BNE        An_indir_postinc_reg4                      ;if not try reg 4
                                            BEQ        An_indir_postinc_reg3_out               ;if equal go to output subroutine
 
An_indir_postinc_reg4                       CMP.L      #match_ADDA_An_indir_postinc_reg4,D2        ;check reg is equal to 4
                                            BNE        An_indir_postinc_reg5                      ;if not try reg 5
                                            BEQ        An_indir_postinc_reg4_out               ;if equal go to output subroutine

An_indir_postinc_reg5                       CMP.L      #match_ADDA_An_indir_postinc_reg5,D2        ;check reg is equal to 5
                                            BNE        An_indir_postinc_reg6                      ;if not try reg 6
                                            BEQ        An_indir_postinc_reg5_out               ;if equal go to output subroutine

An_indir_postinc_reg6                       CMP.L      #match_ADDA_An_indir_postinc_reg6,D2         ;check reg is equal to 6
                                            BNE        An_indir_postinc_reg7                        ;if not try reg 7
                                            BEQ        An_indir_postinc_reg6_out                    ;if equal go to output subroutine

An_indir_postinc_reg7                       CMP.L      #match_ADDA_An_indir_postinc_reg7,D2         ;check reg is equal to 7
                                            BEQ        An_indir_postinc_reg7_out                    ;if equal go to output subroutine
                                            BNE        ERROR                                        :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
An_indir_postinc_reg0_out			            MOVE.L			#ea_indir_postinc_A0,A1		    			      ;load string constant into A1
        								        RTS										            		;return to subroutine

An_indir_postinc_reg1_out			            MOVE.L			#ea_indir_postinc_A1,A1		    			      ;load string constant into A1
								                RTS										            		;return to subroutine

An_indir_postinc_reg2_out			            MOVE.L			#ea_indir_postinc_A2,A1		    			      ;load string constant into A1
								                RTS										            		;return to subroutine

An_indir_postinc_reg3_out			            MOVE.L			#ea_indir_postinc_A3,A1		    			      ;load string constant into A1
								                RTS										            		;return to subroutine

An_indir_postinc_reg4_out			            MOVE.L			#ea_indir_postinc_A4,A1		    			      ;load string constant into A1
								                RTS										            		;return to subroutine

An_indir_postinc_reg5_out			            MOVE.L			#ea_indir_postinc_A5,A1		    			      ;load string constant into A1
								                RTS										            		;return to subroutine

An_indir_postinc_reg6_out			            MOVE.L			#ea_indir_postinc_A6,A1		    			      ;load string constant into A1
								                RTS										            		;return to subroutine

An_indir_postinc_reg7_out			            MOVE.L			#ea_indir_postinc_A7,A1		    			      ;load string constant into A1
								                RTS										            		;return to subroutine

;------------------Address Register Indirect with Pre Decrement-----------------------
An_indir_predec                         	CMP.L      #match_ADDA_An_indir_predec_reg0,D2       ;check reg is equal to 0
                                            BNE        An_indir_predec_reg1                      ;if not try reg 1
                                            BEQ        An_indir_predec_reg0_out               ;if equal go to output subroutine

An_indir_predec_reg1                        CMP.L      #match_ADDA_An_indir_predec_reg1,D2       ;check reg is equal to 1
                                            BNE        An_indir_predec_reg2                      ;if not try reg 2
                                            BEQ        An_indir_predec_reg1_out               ;if equal go to output subroutine

An_indir_predec_reg2                        CMP.L      #match_ADDA_An_indir_predec_reg2,D2       ;check reg is equal to 2
                                            BNE        An_indir_predec_reg3                      ;if not try reg 3
                                            BEQ        An_indir_predec_reg2_out               ;if equal go to output subroutine

An_indir_predec_reg3                        CMP.L      #match_ADDA_An_indir_predec_reg3,D2       ;check reg is equal to 3
                                            BNE        An_indir_predec_reg4                      ;if not try reg 4
                                            BEQ        An_indir_predec_reg3_out               ;if equal go to output subroutine

An_indir_predec_reg4                        CMP.L      #match_ADDA_An_indir_predec_reg4,D2       ;check reg is equal to 4
                                            BNE        An_indir_predec_reg5                      ;if not try reg 5
                                            BEQ        An_indir_predec_reg4_out               ;if equal go to output subroutine

An_indir_predec_reg5                        CMP.L      #match_ADDA_An_indir_predec_reg5,D2       ;check reg is equal to 5
                                            BNE        An_indir_predec_reg6                     ;if not try reg 6
                                            BEQ        An_indir_predec_reg5_out               ;if equal go to output subroutine

An_indir_predec_reg6                        CMP.L      #match_ADDA_An_indir_predec_reg6,D2       ;check reg is equal to 6
                                            BNE        An_indir_predec_reg7                     ;if not try reg 7
                                            BEQ        An_indir_predec_reg6_out               ;if equal go to output subroutine

An_indir_predec_reg7                        CMP.L      #match_ADDA_An_indir_predec_reg7,D2       ;check reg is equal to 7
                                            BEQ        An_indir_predec_reg7_out               ;if equal go to output subroutine
                                            BNE        ERROR                                    :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
An_indir_predec_reg0_out			        MOVE.L			#ea_indir_predec_A0,A1					      ;load string constant into A1
											RTS														;return to subroutine
											
An_indir_predec_reg1_out			        MOVE.L			#ea_indir_predec_A1,A1						;load string constant into A1
											RTS														;return to subroutine

An_indir_predec_reg2_out			        MOVE.L			#ea_indir_predec_A2,A1						;load string constant into A1
											RTS														;return to subroutine

An_indir_predec_reg3_out			        MOVE.L			#ea_indir_predec_A3,A1						;load string constant into A1
											RTS														;return to subroutine

An_indir_predec_reg4_out			        MOVE.L			#ea_indir_predec_A4,A1						;load string constant into A1
											RTS														;return to subroutine

An_indir_predec_reg5_out			        MOVE.L			#ea_indir_predec_A5,A1						;load string constant into A1
											RTS														;return to subroutine

An_indir_predec_reg6_out			        MOVE.L			#ea_indir_predec_A6,A1						;load string constant into A1
											RTS														;return to subroutine

An_indir_predec_reg7_out			        MOVE.L			#ea_indir_predec_A7,A1						;load string constant into A1
											RTS														;return to subroutine

;------------------Absolute Addressing Output-----------------------
abs_add_word_out						  MOVE.W      (A0)+,D5                           ;pull the next word instruction that holds the address
                                         MOVE.W      #16,D6                             ;load number of bits to deal with
                                         MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         RTS                                            :return to subroutine
                                           

abs_add_long_out    					  MOVE.W      (A0)+,D5                           ;pull the next word instruction that holds the address
                                         MOVE.W      #32,D6                             ;load number of bits to deal with
                                         MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         RTS                                            :return to subroutine                                            
;---------------Immediate Addersing---------------------------
immediate_add_out                        MOVE.L		(A0),D5                                 ;capture the immediate address
										  MOVE.L      D5,A3                                   ;move to A3
                                         RTS                                                 ;return to subroutine
                                             
;---------------------------------Determine Register----------------------------------------------------------------------------------------
												CLR.L		D2												;clear D2 
												AND.L		#mask_ADDA_An_reg,D2								;load the mask for the register into D2, masks bit 11-9
												
ADDA_reg0										CMP.L		#match_ADDA_reg0,D2								;check to see if reg equal 0
												BNE			ADDA_reg1										;if not equal got check reg 1
												BEQ			ADDA_reg0_out									;if equal go to output
												
ADDA_reg1										CMP.L		#match_ADDA_reg1,D2								;check to see if reg equal 1
												BNE			ADDA_reg2										;if not equal got check reg 2
												BEQ			ADDA_reg1_out									;if equal go to output

ADDA_reg2										CMP.L		#match_ADDA_reg2,D2								;check to see if reg equal 2
												BNE			ADDA_reg3										;if not equal got check reg 3
												BEQ			ADDA_reg2_out									;if equal go to output

ADDA_reg3										CMP.L		#match_ADDA_reg3,D2								;check to see if reg equal 3
												BNE			ADDA_reg4										;if not equal got check reg 4
												BEQ			ADDA_reg3_out									;if equal go to output
												
ADDA_reg4										CMP.L		#match_ADDA_reg4,D2								;check to see if reg equal 4
												BNE			ADDA_reg5										;if not equal got check reg 5
												BEQ			ADDA_reg4_out									;if equal go to output

ADDA_reg5										CMP.L		#match_ADDA_reg5,D2								;check to see if reg equal 5
												BNE			ADDA_reg6										;if not equal got check reg 6
												BEQ			ADDA_reg5_out									;if equal go to output

ADDA_reg6										CMP.L		#match_ADDA_reg6,D2								;check to see if reg equal 6
												BNE			ADDA_reg7										;if not equal got check reg 7
												BEQ			ADDA_reg6_out									;if equal go to output			

ADDA_reg7										CMP.L		#match_ADDA_reg7,D2								;check to see if reg equal 7
												BEQ			ADDA_reg7_out									;if equal go to output
												BNE         ERROR                                                       ;if not equal to an addresssing mode, pritn error
								

;--------------------Data Output-----------------------
ADDA_reg0_out			                    MOVE.L			#ea_A0,A1					                       ;load string constant into A1
											RTS														;return to subroutine
											
ADDA_reg1_out			                    MOVE.L			#ea_A1,A1				                		;load string constant into A1
											RTS														;return to subroutine

ADDA_reg2_out			                    MOVE.L			#ea_A2,A1				                		;load string constant into A1
											RTS														;return to subroutine

ADDA_reg3_out			                    MOVE.L			#ea_A3,A1				                        	;load string constant into A1
											RTS									        				;return to subroutine

ADDA_reg4_out			                    MOVE.L			#ea_A4,A1				                    		;load string constant into A1
											RTS														;return to subroutine

ADDA_reg5_out			                    MOVE.L			#ea_A5,A1					                     	;load string constant into A1
											RTS														;return to subroutine

ADDA_reg6_out			                    MOVE.L			#ea_A6,A1					                    	;load string constant into A1
											RTS														;return to subroutine

ADDA_reg7_out			                    MOVE.L			#ea_A7,A1					                    	;load string constant into A1
											RTS														;return to subroutine
				
;----------------------Error Handling----------------------------------------
ERROR                                           LEA     ERROR_MESSAGE,A3                                          ;load error messge into A3
					                            RTS
					                            
					                            
ERROR_MESSAGE                   DC.B            'Incorrect EA Format',0
ea_D0				    	DC.B		'D0',0
ea_D1			    		DC.B		'D1',0
ea_D2			    		DC.B		'D2',0
ea_D3				    	DC.B		'D3',0
ea_D4			    		DC.B		'D4',0
ea_D5			    		DC.B		'D5',0
ea_D6				    	DC.B		'D6',0
ea_D7			   	    	DC.B		'D7',0

ea_A0                 		            DC.B        'A0',0
ea_A1                       			DC.B        'A1',0
ea_A2                       			DC.B        'A2',0
ea_A3                       			DC.B        'A3',0
ea_A4                       			DC.B        'A4',0
ea_A5                       			DC.B        'A5',0
ea_A6			                        DC.B        'A6',0
ea_A7                      			DC.B        'A7',0

ea_indir_A0		    		DC.B		'(A0)',0
ea_indir_A1		    		DC.B		'(A1)',0
ea_indir_A2		    		DC.B		'(A2)',0
ea_indir_A3		    		DC.B		'(A3)',0
ea_indir_A4			    	DC.B		'(A4)',0
ea_indir_A5			    	DC.B		'(A5)',0
ea_indir_A6			    	DC.B		'(A6)',0
ea_indir_A7               			 DC.B              '(A7)',0

ea_indir_postinc_A0			DC.B		'(A0)+',0
ea_indir_postinc_A1			DC.B		'(A1)+',0
ea_indir_postinc_A2			DC.B		'(A2)+',0
ea_indir_postinc_A3			DC.B		'(A3)+',0
ea_indir_postinc_A4			DC.B		'(A4)+',0
ea_indir_postinc_A5			DC.B		'(A5)+',0
ea_indir_postinc_A6			DC.B		'(A6)+',0
ea_indir_postinc_A7			DC.B		'(A7)+',0


ea_indir_predec_A0			DC.B		'-(A0)',0
ea_indir_predec_A1			DC.B		'-(A1)',0
ea_indir_predec_A2			DC.B		'-(A2)',0
ea_indir_predec_A3			DC.B		'-(A3)',0
ea_indir_predec_A4			DC.B		'-(A4)',0
ea_indir_predec_A5			DC.B		'-(A5)',0
ea_indir_predec_A6			DC.B		'-(A6)',0
ea_indir_predec_A7			DC.B		'-(A7)',0

ea_paren_open			    DC.B		'(',0
ea_paren_closed		    	DC.B		')',0
ea_abs_word_string	    	DC.B		'.W',0
ea_abs_long_string	    	DC.B		'.L',0
ea_$				    	DC.B		'$',0

mask_ADDA_ea_mode						EQU			$0038
mask_ADDA_abs_add						EQU			$003F
mask_ADDA_ea_reg_and_mode				EQU			$003F
mask_ADDA_An_reg					    EQU			$0E00

match_ADDA_Dn							EQU			$0000
match_ADDA_An							EQU			$0008
match_ADDA_An_indir						EQU			$0010
match_ADDA_An_indir_predec				EQU			$0020
match_ADDA_An_indir_postinc				EQU			$0018
match_ADDA_abs_add_word					EQU			$0038
match_ADDA_abs_add_long					EQU			$0039

match_ADDA_D0							EQU			$0000
match_ADDA_D1							EQU			$0001
match_ADDA_D2							EQU			$0002
match_ADDA_D3							EQU			$0003
match_ADDA_D4							EQU			$0004
match_ADDA_D5							EQU			$0005
match_ADDA_D6							EQU			$0006
match_ADDA_D7							EQU			$0007

match_ADDA_A0							EQU			$0008
match_ADDA_A1							EQU			$0009
match_ADDA_A2							EQU			$000A
match_ADDA_A3							EQU			$000B
match_ADDA_A4							EQU			$000C
match_ADDA_A5							EQU			$000D
match_ADDA_A6							EQU			$000E
match_ADDA_A7							EQU			$000F

match_ADDA_An_indir_r0					EQU			$0010
match_ADDA_An_indir_r1					EQU			$0011
match_ADDA_An_indir_r2					EQU			$0012
match_ADDA_An_indir_r3					EQU			$0013
match_ADDA_An_indir_r4					EQU			$0014
match_ADDA_An_indir_r5					EQU			$0015
match_ADDA_An_indir_r6					EQU			$0016
match_ADDA_An_indir_r7					EQU			$0017

match_ADDA_An_indir_postinc_reg0		EQU			$0018
match_ADDA_An_indir_postinc_reg1		EQU			$0019
match_ADDA_An_indir_postinc_reg2		EQU			$001A
match_ADDA_An_indir_postinc_reg3		EQU			$001B
match_ADDA_An_indir_postinc_reg4		EQU			$001C
match_ADDA_An_indir_postinc_reg5		EQU			$001D
match_ADDA_An_indir_postinc_reg6		EQU			$001E
match_ADDA_An_indir_postinc_reg7		EQU			$001F

match_ADDA_An_indir_predec_reg0			EQU			$0020
match_ADDA_An_indir_predec_reg1			EQU			$0021
match_ADDA_An_indir_predec_reg2			EQU			$0022
match_ADDA_An_indir_predec_reg3			EQU			$0023
match_ADDA_An_indir_predec_reg4			EQU			$0024
match_ADDA_An_indir_predec_reg5			EQU			$0025
match_ADDA_An_indir_predec_reg6			EQU			$0026
match_ADDA_An_indir_predec_reg7			EQU			$0027

match_imm_add                           EQU         $003C

match_ADDA_reg0							EQU			$0000
match_ADDA_reg1							EQU			$0200
match_ADDA_reg2							EQU			$0400
match_ADDA_reg3							EQU			$0600
match_ADDA_reg4							EQU			$0800
match_ADDA_reg5							EQU			$0A00
match_ADDA_reg6							EQU			$0C00
match_ADDA_reg7							EQU			$0E00

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
