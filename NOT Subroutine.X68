*-----------------------------------------------------------
* Title      :NOT EA Subroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matchs of the dettermined mode and register
* A1 will point to the location of the string constants
*-----------------------------------------------------------


NOT_sub                                            ;preserve the registers,\ 
                                 AND.L             #mask_NOT_ea_mode,D1                      ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
NOT_data_reg_dir                 CMP.L             #match_NOT_Dn,D1                          ;check to see if mode is data reg direct
                                 BNE               NOT_An_indir                                  ;if not, go check add reg dir
                                 BEQ               NOT_Dn_reg                                    ;if equal go figure out the register

NOT_An_indir                     CMP.L             #match_NOT_An_indir,D1                    ;check to see if mode is add reg indir
                                 BNE               NOT_An_indir_predec                           ;if not, go check add reg indir predec 
                                 BEQ               NOT_An_indir_reg                              ;if equal go figure out the register           
          
NOT_An_indir_postinc             CMP.L             #match_NOT_An_indir_postinc,D1            ;check to see if mode is add reg indor w/ postinc
                                 BNE               NOT_An_indir_predec                           ;if not go check add reg indir/predec
                                 BEQ               NOT_An_indir_postinc_reg                      ;if equal go figure out the register
                      
NOT_An_indir_predec              CMP.L             #match_NOT_An_indir_predec,D1             ;check to see if mode is add reg indir w/predec
                                 BNE               NOT_abs_add_word                              ;if not go check abs add word
                                 BEQ               NOT_An_indir_predec_reg                       ;if equal go figure out the register

NOT_abs_add_word                 AND.L             #mask_NOT_ea_mode_abs_add,D2              ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_NOT_abs_add_word,D2                ;check if abs add word
                                 MOVE.L            (A0)+,D5                                  ;pull the next word instruction that holds the address 
                                 BNE               NOT_abs_add_long                              ;if not go check abs add long
                                 BEQ               NOT_abs_add_word_out                          ;if equal go to output
  
NOT_abs_add_long                 CMP.L             #match_NOT_abs_add_long,D2                ;check to see if abs add long
                                 BEQ               NOT_abs_add_long_out                          ;if equal go to output
								 BNE               ERROR                                     ;if not equal to an addresssing mode, pritn error
							 

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
;-----------------------------------Data Register Direct--------------------------------
NOT_Dn_reg                      CLR                D2                                      ;make sure D2 is empty
                                MOVE.W              D0,D2
                                AND.L              #mask_NOT_ea_reg_and_mode,D2            ;load the mask into D2 for the mode and the register
                                CMP.L              #match_NOT_D0,D2                         ;check to see in the register is 0
                                BNE                NOT_rD1                                      ;if not go check register 1
                                BEQ                NOT_D0_output                                ;if equal go to output subroutine

NOT_rD1						    CMP.L              #match_NOT_D1,D2                        ;check to see in the register is 1
                                BNE                NOT_rD2                                     ;if not go check register 2
                                BEQ                NOT_D1_output                               ;if equal go to output subroutine

NOT_rD2						    CMP.L              #match_NOT_D2,D2                        ;check to see in the register is 2
                                BNE                NOT_rD3                                     ;if not go check register 3
                                BEQ                NOT_D2_output                               ;if equal go to output subroutine

NOT_rD3                         CMP.L              #match_NOT_D3,D2                       ;check to see in the register is 3
                                BNE                NOT_rD4                                     ;if not go check register 4
                                BEQ                NOT_D3_output                              ;if equal go to output subroutine

NOT_rD4                         CMP.L              #match_NOT_D4,D2                       ;check to see in the register is 4
                                BNE                NOT_rD5                                     ;if not go check register 5
                                BEQ                NOT_D4_output                              ;if equal go to output subroutine

NOT_rD5                         CMP.L              #match_NOT_D5,D2                       ;check to see in the register is 5
                                BNE                NOT_rD6                                     ;if not go check register 6
                                BEQ                NOT_D5_output                              ;if equal go to output subroutine

NOT_rD6                         CMP.L              #match_NOT_D6,D2                       ;check to see in the register is 6
                                BNE                NOT_rD7                                     ;if not go check register 7
                                BEQ                NOT_D6_output                              ;if equal go to output subroutine

NOT_rD7                         CMP.L              #match_NOT_D7,D2                       ;check to see in the register is 7
                                BEQ                NOT_D7_output                              ;if equal go to output subroutine
                                BNE                ERROR                                        :if not equal to an addresssing mode, pritn error
                                
;--------------------Data Register Direct Output-----------------------
NOT_D0_output				MOVE.L			#ea_D0,A1							;load string constant into A1
	    					RTS												;return to subroutine
									
NOT_D1_output				MOVE.L			#ea_D1,A1							;load string constant into A1
    						RTS												;return to subroutine
									
NOT_D2_output				MOVE.L			#ea_D2,A1							;load string constant into A1
					        RTS												;return to subroutine
									
NOT_D3_output				MOVE.L			#ea_D3,A1							;load string constant into A1
					    	RTS												;return to subroutine
									
NOT_D4_output				MOVE.L			#ea_D4,A1							;load string constant into A1
				    		RTS												;return to subroutine
									
NOT_D5_output				MOVE.L			#ea_D5,A1							;load string constant into A1
			    			RTS												;return to subroutine
									
NOT_D6_output				MOVE.L			#ea_D6,A1							;load string constant into A1
		    				RTS												;return to subroutine
									
NOT_D7_output				MOVE.L			#ea_D7,A1							;load string constant into A1
						    RTS												;return to subroutine
									
;------------------Address Register Indirect-----------------------
NOT_An_indir_reg                            CLR                D2                                      ;make sure D2 is empty
                                            MOVE.W              D0,D2
                                            AND.L              #mask_NOT_ea_reg_and_mode,D2 
                                            CMP.L           #match_NOT_An_indir_r0,D2              ;check reg is equal to 0
                                            BNE             NOT_An_indir_reg1                            ;if not try reg 1
                                            BEQ             NOT_An_indir_reg0_out                     ;if equal go to output subroutine

NOT_An_indir_reg1                           CMP.L           #match_NOT_An_indir_r1,D2              ;check reg is equal to 1
                                            BNE             NOT_An_indir_reg2                            ;if not try reg 2
                                            BEQ             NOT_An_indir_reg1_out                     ;if equal go to output subroutine

NOT_An_indir_reg2                           CMP.L           #match_NOT_An_indir_r2,D2              ;check reg is equal to 2
                                            BNE             NOT_An_indir_reg3                            ;if not try reg 3
                                            BEQ             NOT_An_indir_reg2_out                     ;if equal go to output subroutine

NOT_An_indir_reg3                           CMP.L           #match_NOT_An_indir_r3,D2              ;check reg is equal to 3
                                            BNE             NOT_An_indir_reg4                            ;if not try reg 4
                                            BEQ             NOT_An_indir_reg3_out                     ;if equal go to output subroutine

NOT_An_indir_reg4                           CMP.L           #match_NOT_An_indir_r4,D2              ;check reg is equal to 4
                                            BNE             NOT_An_indir_reg5                            ;if not try reg 5
                                            BEQ             NOT_An_indir_reg4_out                    ;if equal go to output subroutine

NOT_An_indir_reg5                           CMP.L           #match_NOT_An_indir_r5,D2              ;check reg is equal to 5
                                            BNE             NOT_An_indir_reg6                            ;if not try reg 6
                                            BEQ             NOT_An_indir_reg5_out                     ;if equal go to output subroutine

NOT_An_indir_reg6                           CMP.L           #match_NOT_An_indir_r6,D2              ;check reg is equal to 6
                                            BEQ             NOT_An_indir_reg6_out                     ;if equal go to output subroutine
                                            BNE             NOT_An_indir_reg7

NOT_An_indir_reg7                           CMP.L           #match_NOT_An_indir_r7,D2              ;check reg is equal to 6
                                            BEQ             NOT_An_indir_reg7_out                     ;if equal go to output subroutine
                                            BNE              ERROR                                        :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
NOT_An_indir_reg0_out			        MOVE.L			#ea_indir_A0,A1							;load string constant into A1
								        RTS												            ;return to subroutine
									
NOT_An_indir_reg1_out			        MOVE.L			#ea_indir_A1,A1							;load string constant into A1
								        RTS												            ;return to subroutine
											
NOT_An_indir_reg2_out		            MOVE.L			#ea_indir_A2,A1							;load string constant into A1
							        	RTS							        					;return to subroutine

NOT_An_indir_reg3_out		            MOVE.L			#ea_indir_A3,A1							;load string constant into A1
    					            	RTS									        			;return to subroutine
											
NOT_An_indir_reg4_out		            MOVE.L			#ea_indir_A4,A1							;load string constant into A1
						        		RTS											            	;return to subroutine
										
NOT_An_indir_reg5_out			        MOVE.L			#ea_indir_A5,A1							;load string constant into A1
								        RTS			        									;return to subroutine

NOT_An_indir_reg6_out			        MOVE.L			#ea_indir_A6,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine

NOT_An_indir_reg7_out			        MOVE.L			#ea_indir_A7,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine


;------------------Address Register Indirect with Post Increment-----------------------
NOT_An_indir_postinc_reg                    CLR                D2                                      ;make sure D2 is empty
                                            MOVE.W              D0,D2
                                            AND.L              #mask_NOT_ea_reg_and_mode,D2 
                                            CMP.L      #match_NOT_An_indir_postinc_r0,D2        ;check reg is equal to 0
                                            BNE        NOT_An_indir_pinc_r1                      ;if not try reg 1
                                            BEQ        NOT_An_indir_pinc_r0_out               ;if equal go to output subroutine

NOT_An_indir_pinc_r1                        CMP.L      #match_NOT_An_indir_postinc_r1,D2        ;check reg is equal to 1
                                            BNE        NOT_An_indir_pinc_r2                      ;if not try reg 2
                                            BEQ        NOT_An_indir_pinc_r1_out               ;if equal go to output subroutine

NOT_An_indir_pinc_r2                        CMP.L      #match_NOT_An_indir_postinc_r2,D2        ;check reg is equal to 2
                                            BNE        NOT_An_indir_pinc_r3                      ;if not try reg 3
                                            BEQ        NOT_An_indir_pinc_r2_out               ;if equal go to output subroutine
     
NOT_An_indir_pinc_r3                        CMP.L      #match_NOT_An_indir_postinc_r3,D2        ;check reg is equal to 3
                                            BNE        NOT_An_indir_pinc_r4                      ;if not try reg 4
                                            BEQ        NOT_An_indir_pinc_r3_out               ;if equal go to output subroutine
 
NOT_An_indir_pinc_r4                        CMP.L      #match_NOT_An_indir_postinc_r4,D2        ;check reg is equal to 4
                                            BNE        NOT_An_indir_pinc_r5                      ;if not try reg 5
                                            BEQ        NOT_An_indir_pinc_r4_out               ;if equal go to output subroutine

NOT_An_indir_pinc_r5                        CMP.L      #match_NOT_An_indir_postinc_r5,D2        ;check reg is equal to 5
                                            BNE        NOT_An_indir_pinc_r6                      ;if not try reg 6
                                            BEQ        NOT_An_indir_pinc_r5_out               ;if equal go to output subroutine

NOT_An_indir_pinc_r6                        CMP.L      #match_NOT_An_indir_postinc_r6,D2        ;check reg is equal to 6
                                            BEQ        NOT_An_indir_pinc_r6_out              ;if equal go to output subroutine
                                            BNE        NOT_An_indir_pinc_r6
                                            
NOT_An_indir_pinc_r7                        CMP.L      #match_NOT_An_indir_postinc_r7,D2        ;check reg is equal to 7
                                            BEQ        NOT_An_indir_pinc_r7_out              ;if equal go to output subroutine
                                            BNE        ERROR                                        :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
NOT_An_indir_pinc_r0_out		        	MOVE.L			#ea_indir_postinc_A1,A1			;load string constant into A1
											RTS												;return to subroutine

NOT_An_indir_pinc_r1_out		        	MOVE.L			#ea_indir_postinc_A1,A1			;load string constant into A1
											RTS												;return to subroutine

NOT_An_indir_pinc_r2_out		        	MOVE.L			#ea_indir_postinc_A2,A1			;load string constant into A1
											RTS												;return to subroutine

NOT_An_indir_pinc_r3_out		        	MOVE.L			#ea_indir_postinc_A3,A1			;load string constant into A1
											RTS												;return to subroutine

NOT_An_indir_pinc_r4_out		          	MOVE.L			#ea_indir_postinc_A4,A1			;load string constant into A1
								  			RTS												;return to subroutine

NOT_An_indir_pinc_r5_out			        MOVE.L			#ea_indir_postinc_A5,A1			;load string constant into A1
											RTS												;return to subroutine
 
NOT_An_indir_pinc_r6_out			        MOVE.L			#ea_indir_postinc_A6,A1			;load string constant into A1
											RTS												;return to subroutine

NOT_An_indir_pinc_r7_out			        MOVE.L			#ea_indir_postinc_A7,A1			;load string constant into A1
											RTS												;return to subroutine
													
;------------------Address Register Indirect with Pre Decrement-----------------------
NOT_An_indir_predec_reg                  	CLR                D2                                      ;make sure D2 is empty
                                            MOVE.W              D0,D2
                                            AND.L              #mask_NOT_ea_reg_and_mode,D2 
                                            CMP.L      #match_NOT_An_indir_predec_r0,D2         ;check reg is equal to 0
                                            BNE        NOT_An_indir_pdec_r1                      ;if not try reg 1
                                            BEQ        NOT_An_indir_pdec_r0_out               ;if equal go to output subroutine

NOT_An_indir_pdec_r1                        CMP.L      #match_NOT_An_indir_predec_r1,D2         ;check reg is equal to 1
                                            BNE        NOT_An_indir_pdec_r2                      ;if not try reg 2
                                            BEQ        NOT_An_indir_pdec_r1_out               ;if equal go to output subroutine

NOT_An_indir_pdec_r2                        CMP.L      #match_NOT_An_indir_predec_r2,D2         ;check reg is equal to 2
                                            BNE        NOT_An_indir_pdec_r3                      ;if not try reg 3
                                            BEQ        NOT_An_indir_pdec_r2_out               ;if equal go to output subroutine

NOT_An_indir_pdec_r3                        CMP.L      #match_NOT_An_indir_predec_r3,D2         ;check reg is equal to 3
                                            BNE        NOT_An_indir_pdec_r4                      ;if not try reg 4
                                            BEQ        NOT_An_indir_pdec_r3_out               ;if equal go to output subroutine

NOT_An_indir_pdec_r4                        CMP.L      #match_NOT_An_indir_predec_r4,D2         ;check reg is equal to 4
                                            BNE        NOT_An_indir_pdec_r5                      ;if not try reg 5
                                            BEQ        NOT_An_indir_pdec_r4_out               ;if equal go to output subroutine

NOT_An_indir_pdec_r5                        CMP.L      #match_NOT_An_indir_predec_r5,D2         ;check reg is equal to 5
                                            BNE        NOT_An_indir_pdec_r6                      ;if not try reg 6
                                            BEQ        NOT_An_indir_pdec_r5_out               ;if equal go to output subroutine

NOT_An_indir_pdec_r6                        CMP.L      #match_NOT_An_indir_predec_r6,D2         ;check reg is equal to 6
                                            BEQ        NOT_An_indir_pdec_r6_out               ;if equal go to output subroutine
                                            BNE        NOT_An_indir_pdec_r7

NOT_An_indir_pdec_r7                        CMP.L      #match_NOT_An_indir_predec_r6,D2         ;check reg is equal to 6
                                            BEQ        NOT_An_indir_pdec_r7_out               ;if equal go to output subroutine
                                            BNE        ERROR                                        :if not equal to an addresssing mode, pritn error
;--------------------Address Register Indirect with Pre Decrement Output-----------------------
NOT_An_indir_pdec_r0_out			        MOVE.L			#ea_indir_predec_A0,A1							;load string constant into A1
											RTS														;return to subroutine

NOT_An_indir_pdec_r1_out			        MOVE.L			#ea_indir_predec_A1,A1							;load string constant into A1
											RTS														;return to subroutine
													
NOT_An_indir_pdec_r2_out			        MOVE.L			#ea_indir_predec_A2,A1							;load string constant into A1
											RTS														;return to subroutine

NOT_An_indir_pdec_r3_out			        MOVE.L			#ea_indir_predec_A3,A1							;load string constant into A1
											RTS														;return to subroutine

NOT_An_indir_pdec_r4_out			        MOVE.L			#ea_indir_predec_A4,A1							;load string constant into A1
											RTS														;return to subroutine
	
NOT_An_indir_pdec_r5_out		        	MOVE.L			#ea_indir_predec_A5,A1							;load string constant into A1
											RTS														;return to subroutine
	
NOT_An_indir_pdec_r6_out		        	MOVE.L			#ea_indir_predec_A6,A1							;load string constant into A1
											RTS														;return to subroutine

NOT_An_indir_pdec_r7_out		        	MOVE.L			#ea_indir_predec_A7,A1							;load string constant into A1
											RTS														;return to subroutine
													
;------------------Absolute Addressing Output-----------------------
NOT_abs_add_word_out					 MOVE.L      #ea_$,(A1)+                        ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         RTS                                            :return to subroutine
                                           

NOT_abs_add_long_out    				 MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                         MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         RTS      

                                     
ERROR                                   LEA             ERROR_MESSAGE,A1                 ;load error messge into A3
				        RTS
					                            
					                                                                       

												
mask_NOT_ea_mode			EQU				$0038              ;masks bits 5-3 to determine ea mode
mask_NOT_ea_reg_and_mode		EQU				$003F              ;masks bits 5-0 to determine the register with the given mode
mask_NOT_ea_mode_abs_add		EQU				$003F

match_NOT_Dn				EQU				$0000              ;match for data reg dir
match_NOT_An_indir			EQU				$0010              ;match for add reg indir
match_NOT_An_indir_postinc		EQU				$0020              ;match for add reg indir with postinc
match_NOT_An_indir_predec		EQU				$0018              ;match for add reg indir with predec
match_NOT_abs_add_word			EQU				$0039      		   ;match for word abs add 
match_NOT_abs_add_long			EQU				$003C              ;match for long abs add

match_NOT_D0				EQU				$0000              ;match for data reg dir with data reg 0
match_NOT_D1				EQU				$0001              ;match for data reg dir with data reg 1
match_NOT_D2				EQU				$0002              ;match for data reg dir with data reg 2
match_NOT_D3				EQU				$0003              ;match for data reg dir with data reg 3
match_NOT_D4				EQU				$0004              ;match for data reg dir with data reg 4
match_NOT_D5				EQU				$0005              ;match for data reg dir with data reg 5
match_NOT_D6				EQU				$0006              ;match for data reg dir with data reg 6
match_NOT_D7				EQU				$0007              ;match for data reg dir with data reg 7

match_NOT_An_indir_r0				        EQU				$0010              ;match for add reg indir with add reg 0
match_NOT_An_indir_r1			        	EQU				$0011              ;match for add reg indir with add reg 1
match_NOT_An_indir_r2			        	EQU				$0012              ;match for add reg indir with add reg 2
match_NOT_An_indir_r3			        	EQU				$0013              ;match for add reg indir with add reg 3
match_NOT_An_indir_r4		        		EQU				$0014              ;match for add reg indir with add reg 4
match_NOT_An_indir_r5		        		EQU				$0015              ;match for add reg indir with add reg 5
match_NOT_An_indir_r6			        	EQU				$0016              ;match for add reg indir with add reg 6
match_NOT_An_indir_r7			        	EQU				$0017              ;match for add reg indir with add reg 7


match_NOT_An_indir_postinc_r0	        	EQU				$0020              ;match for add reg indir with postinc with add reg 0
match_NOT_An_indir_postinc_r1	        	EQU				$0021              ;match for add reg indir with postinc with add reg 1
match_NOT_An_indir_postinc_r2	        	EQU				$0022              ;match for add reg indir with postinc with add reg 2
match_NOT_An_indir_postinc_r3	        	EQU				$0023              ;match for add reg indir with postinc with add reg 3
match_NOT_An_indir_postinc_r4	        	EQU				$0024              ;match for add reg indir with postinc with add reg 4
match_NOT_An_indir_postinc_r5	        	EQU				$0025              ;match for add reg indir with postinc with add reg 5
match_NOT_An_indir_postinc_r6	        	EQU				$0026              ;match for add reg indir with postinc with add reg 6
match_NOT_An_indir_postinc_r7	        	EQU				$0027              ;match for add reg indir with postinc with add reg 7

match_NOT_An_indir_predec_r0		       	EQU				$0018              ;match for add reg indir with predec with add reg 0
match_NOT_An_indir_predec_r1		       	EQU				$0019              ;match for add reg indir with predec with add reg 1
match_NOT_An_indir_predec_r2		    	EQU				$001A              ;match for add reg indir with predec with add reg 2
match_NOT_An_indir_predec_r3		    	EQU				$001B              ;match for add reg indir with predec with add reg 3
match_NOT_An_indir_predec_r4		    	EQU				$001C              ;match for add reg indir with predec with add reg 4
match_NOT_An_indir_predec_r5	    		EQU				$001D              ;match for add reg indir with predec with add reg 5
match_NOT_An_indir_predec_r6		    	EQU				$001E              ;match for add reg indir with predec with add reg 6
match_NOT_An_indir_predec_r7		    	EQU				$001F              ;match for add reg indir with predec with add reg 7









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
