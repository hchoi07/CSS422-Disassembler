


*-----------------------------------------------------------
* Title      :OR Subroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode OR register to be compared with matchs of the dettermined mode OR register
* A1 will point to the location of the string constants
*-----------------------------------------------------------  
   
;--------------------------------------------------------OR ORroutine-----------------------------------------------------------------------
OR_sub                                MOVEM.L           D1-D5/D7/A0-A6, -(SP)                  ;preserve the registers, 
                                 
                                       MOVE.L              #mask_OR_opmode,D1                       ;load mask to determine the operOR order
                                
OR_Dn_ea_match                         CMP.L              #match_OR_b_Dn_ea,D1                 ;check to see if it's Dn,ea
                                       BEQ                OR_Dn_ea                                 ;if equal go figure out data register
                                       BNE                OR_Dn_ea_match_w                         ;if not check word size for same order

OR_Dn_ea_match_w                       CMP.L              #match_OR_w_Dn_ea,D1                 ;check to see if it's Dn,ea
                                       BEQ                OR_Dn_ea                                 ;if equal go figure out data register
                                       BNE                OR_Dn_ea_match_l                         ;if not check long size for same order

OR_Dn_ea_match_l                       CMP.L              #match_OR_l_Dn_ea,D1                 ;check to see if it's Dn,ea
                                       BEQ                OR_Dn_ea                                 ;if equal go figure out data register
                                       BNE                OR_ea_Dn_match                           ;if not check other order

OR_ea_Dn_match                         CMP.L              #match_OR_b_ea_Dn,D1                 ;check to see if it's ea,Dn
                                       BEQ                OR_ea_Dn                                 ;if equal go figure out ea mode
                                       BNE                OR_ea_Dn_match_w                         ;if not go check word size for same order

OR_ea_Dn_match_w                       CMP.L              #match_OR_w_ea_Dn,D1                 ;check to see if it's ea,Dn
                                       BEQ                OR_ea_Dn                                 ;if equal go figure out ea mode
                                       BNE                OR_ea_Dn_match_l                         ;if not go check word size for same order

OR_ea_Dn_match_l                       CMP.L              #match_OR_l_ea_Dn,D1                 ;check to see if it's ea,Dn
                                       BEQ                OR_ea_Dn                                 ;if equal go figure out ea mode
                                       BNE                ERROR                                 ;if not go to error message
;--------------------------------------------------------------------------------------------------------------------------
*                                               EA,Dn Order                                       
;-------------------------------------------------------------------------------------------------------------------------
OR_ea_Dn                             CLR                D1                                        ;clear D1 to load new mask                                
                                     MOVE.L             #mask_OR_ea_mode,D1                       ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
OR_ea_Dn_add_reg_indir               CMP.L             #match_OR_An_indir,D1                      ;check to see if mode is add reg indir
                                     BNE               OR_ea_Dn_add_reg_indir_predec              ;if not, go check add reg indir predec 
                                     BEQ               OR_ea_Dn_An_indir_reg                      ;if equal go figure out the register           
            
OR_ea_Dn_add_reg_indir_predec        CMP.L             #match_OR_An_indir_predec,D1               ;check to see if mode is add reg indor w/ postinc
                                     BNE               OR_ea_Dn_add_reg_indir_postinc             ;if not go check add reg indir/predec
                                     BEQ               OR_ea_Dn_An_indir_predec                   ;if equal go figure out the register
                      
OR_ea_Dn_add_reg_indir_postinc       CMP.L             #match_OR_An_indir_postinc,D1              ;check to see if mode is add reg indir w/predec
                                     BNE               OR_ea_Dn_abs_add_word                      ;if not go check abs add word
                                     BEQ               OR_ea_Dn_An_indir_postinc_reg              ;if equal go figure out the register

OR_ea_Dn_abs_add_word                MOVE.L            #mask_OR_abs_add,D2                        ;load mask to determine if abs add word or long
                                 
                                     CMP.L             #match_OR_abs_add_word,D2                  ;check if abs add word
                                     MOVE.L            (A0)+,D5                                   ;pull the next word instruction that holds the address
                                     BNE               OR_ea_Dn_abs_add_long                      ;if not go check abs add long
                                     BEQ               OR_ea_Dn_abs_add_word_out                  ;if equal go to output
  
OR_ea_Dn_abs_add_long                CMP.L             #match_OR_abs_add_long,D2                  ;check to see if abs add long
                                     BEQ               OR_ea_Dn_abs_add_long_out                  ;if equal go to output
                                     BNE               ERROR                                      ;if not equal go to error mesage OR routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 
;-----------------------------------Data Register Direct--------------------------------
OR_ea_Dn_Dn_reg                  MOVE.L             #mask_OR_ea_reg_OR_mode,D2             ;load the mask into D2 for the mode OR the register
                                 CMP.L              #match_OR_D0,D2                       ;check to see in the register is 0
                                 BNE                OR_ea_Dn_rD1                                     ;if not go check register 1
                                 BEQ                OR_ea_Dn_D0_out                              ;if equal go to output ORroutine

OR_ea_Dn_rD1                     CMP.L              #match_OR_D1,D2                       ;check to see in the register is 1
                                 BNE                OR_ea_Dn_rD2                                     ;if not go check register 2
                                 BEQ                OR_ea_Dn_D1_out                              ;if equal go to output ORroutine

OR_ea_Dn_rD2                     CMP.L              #match_OR_D2,D2                       ;check to see in the register is 2
                                 BNE                OR_ea_Dn_rD3                                     ;if not go check register 3
                                 BEQ                OR_ea_Dn_D2_out                              ;if equal go to output ORroutine

OR_ea_Dn_rD3                     CMP.L              #match_OR_D3,D2                       ;check to see in the register is 3
                                 BNE                OR_ea_Dn_rD4                                     ;if not go check register 4
                                 BEQ                OR_ea_Dn_D3_out                              ;if equal go to output ORroutine

OR_ea_Dn_rD4                     CMP.L              #match_OR_D4,D2                       ;check to see in the register is 4
                                 BNE                OR_ea_Dn_rD5                                     ;if not go check register 5
                                 BEQ                OR_ea_Dn_D4_out                              ;if equal go to output ORroutine

OR_ea_Dn_rD5                     CMP.L              #match_OR_D5,D2                       ;check to see in the register is 5
                                 BNE                OR_ea_Dn_rD6                                     ;if not go check register 6
                                 BEQ                OR_ea_Dn_D5_out                              ;if equal go to output ORroutine

OR_ea_Dn_rD6                     CMP.L              #match_OR_D6,D2                       ;check to see in the register is 6
                                 BNE                OR_ea_Dn_rD7                                     ;if not go check register 7
                                 BEQ                OR_ea_Dn_D6_out                              ;if equal go to output ORroutine

OR_ea_Dn_rD7                     CMP.L              #match_OR_D7,D2                       ;check to see in the register is 7
                                 BEQ                OR_ea_Dn_D7_out                              ;if equal go to output ORroutine
                                 BNE                ERROR                               ;if not equal, got to error message
;--------------------Data Register Direct Output-----------------------
OR_ea_Dn_D0_out                 MOVE.L          #ea_D0,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_D1_out                 MOVE.L          #ea_D1,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR


OR_ea_Dn_D2_out                 MOVE.L          #ea_D2,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_D3_out                 MOVE.L			#ea_D3,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR


OR_ea_Dn_D4_out                 MOVE.L			#ea_D4,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR


OR_ea_Dn_D5_out                 MOVE.L			#ea_D5,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR


OR_ea_Dn_D6_out                 MOVE.L			#ea_D6,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR


OR_ea_Dn_D7_out                 MOVE.L			#ea_D7,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

;------------------Address Register Direct-----------------------
OR_ea_Dn_An_reg                  CMP.L           #match_OR_A0,D2                      ;check reg is equal to 0
                                 BNE             OR_ea_Dn_rA1                         ;if not try reg 1
                                 BEQ             OR_ea_Dn_An_indir_reg0_out           ;if equal go to output ORroutine

OR_ea_Dn_rA1                     CMP.L           #match_OR_A1,D2                      ;check reg is equal to 1
                                 BNE             OR_ea_Dn_rA2                         ;if not try reg 2
                                 BEQ             OR_ea_Dn_An_indir_reg1_out           ;if equal go to output ORroutine

OR_ea_Dn_rA2                     CMP.L           #match_OR_A2,D2                      ;check reg is equal to 2
                                 BNE             OR_ea_Dn_rA3                         ;if not try reg 3
                                 BEQ             OR_ea_Dn_An_indir_reg2_out           ;if equal go to output ORroutine

OR_ea_Dn_rA3                     CMP.L           #match_OR_A3,D2                      ;check reg is equal to 3
                                 BNE             OR_ea_Dn_rA4                         ;if not try reg 4
                                 BEQ             OR_ea_Dn_An_indir_reg3_out           ;if equal go to output ORroutine

OR_ea_Dn_rA4                     CMP.L           #match_OR_A4,D2                      ;check reg is equal to 4
                                 BNE             OR_ea_Dn_rA5                         ;if not try reg 5
                                 BEQ             OR_ea_Dn_An_indir_reg4_out           ;if equal go to output ORroutine
            
OR_ea_Dn_rA5                     CMP.L           #match_OR_A5,D2                      ;check reg is equal to 5
                                 BNE             OR_ea_Dn_rA6                         ;if not try reg 6
                                 BEQ             OR_ea_Dn_An_indir_reg5_out           ;if equal go to output ORroutine

OR_ea_Dn_rA6                     CMP.L           #match_OR_A6,D2                      ;check reg is equal to 6
                                 BNE             OR_ea_Dn_rA7                         ;if not try reg 7
                                 BEQ             OR_ea_Dn_An_indir_reg6_out           ;if equal go to output ORroutine

OR_ea_Dn_rA7                     CMP.L           #match_OR_A7,D2                      ;check reg is equal to 7
                                 BEQ             OR_ea_Dn_An_indir_reg7_out           ;if equal go to output ORroutine
                                 BNE             ERROR                                ;if not equal to an addresssing mode, pritn error

;--------------------Address Register Direct Output-----------------------
OR_ea_Dn_A0_out                 MOVE.L			#ea_A0,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR
        						
OR_ea_Dn_A1_out                 MOVE.L			#ea_A1,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR
        						
OR_ea_Dn_A2_out                 MOVE.L			#ea_A2,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR
        						
OR_ea_Dn_A3_out                 MOVE.L			#ea_A3,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_A4_out                 MOVE.L			#ea_A4,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_A5_out                 MOVE.L			#ea_A5,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_A6_out                 MOVE.L			#ea_A6,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_A7_out                 MOVE.L			#ea_A7,A1							;load string constant into A1
                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

;------------------Address Register Indirect-----------------------
OR_ea_Dn_An_indir_reg            CMP.L          #match_OR_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             OR_ea_Dn_An_indir_reg1                           ;if not try reg 1
                                 BEQ             OR_ea_Dn_An_indir_reg0_out                       ;if equal go to output ORroutine

OR_ea_Dn_An_indir_reg1           CMP.L           #match_OR_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             OR_ea_Dn_An_indir_reg2                           ;if not try reg 2
                                 BEQ             OR_ea_Dn_An_indir_reg1_out                       ;if equal go to output ORroutine

OR_ea_Dn_An_indir_reg2           CMP.L           #match_OR_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             OR_ea_Dn_An_indir_reg3                           ;if not try reg 3
                                 BEQ             OR_ea_Dn_An_indir_reg2_out                       ;if equal go to output ORroutine

OR_ea_Dn_An_indir_reg3           CMP.L           #match_OR_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             OR_ea_Dn_An_indir_reg4                           ;if not try reg 4
                                 BEQ             OR_ea_Dn_An_indir_reg3_out                       ;if equal go to output ORroutine
    
OR_ea_Dn_An_indir_reg4           CMP.L           #match_OR_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             OR_ea_Dn_An_indir_reg5                           ;if not try reg 5
                                 BEQ             OR_ea_Dn_An_indir_reg4_out                       ;if equal go to output ORroutine
        
OR_ea_Dn_An_indir_reg5           CMP.L           #match_OR_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             OR_ea_Dn_An_indir_reg6                           ;if not try reg 6
                                 BEQ             OR_ea_Dn_An_indir_reg5_out                       ;if equal go to output ORroutine

OR_ea_Dn_An_indir_reg6           CMP.L           #match_OR_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             OR_ea_Dn_An_indir_reg7                           ;if not try reg 7
                                 BEQ             OR_ea_Dn_An_indir_reg6_out                       ;if equal go to output ORroutine

OR_ea_Dn_An_indir_reg7           CMP.L           #match_OR_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             OR_ea_Dn_An_indir_reg7_out                       ;if equal go to output ORroutine
                                 BNE             ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
OR_ea_Dn_An_indir_reg0_out			        MOVE.L			#ea_indir_A0,A1		    	        ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_reg1_out			        MOVE.L			#ea_indir_A1,A1		    		  ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_reg2_out			        MOVE.L			#ea_indir_A2,A1		    		  ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_reg3_out			        MOVE.L			#ea_indir_A3,A1		    		  ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_reg4_out			        MOVE.L			#ea_indir_A4,A1		    		  ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_reg5_out			        MOVE.L			#ea_indir_A5,A1		    		  ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_reg6_out			        MOVE.L			#ea_indir_A6,A1		    		  ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR
								        
OR_ea_Dn_An_indir_reg7_out			        MOVE.L			#ea_indir_A7,A1		    		  ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

;------------------Address Register Indirect with Post Increment-----------------------
OR_ea_Dn_An_indir_postinc_reg               CMP.L      #match_OR_An_indir_postinc_r0,D2        ;check reg is equal to 0
                                            BNE        OR_ea_Dn_An_indir_pinc_r1               ;if not try reg 1
                                            BEQ        OR_ea_Dn_An_indir_pinc_r0_out           ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pinc_r1                   CMP.L      #match_OR_An_indir_postinc_r1,D2        ;check reg is equal to 1
                                            BNE        OR_ea_Dn_An_indir_pinc_r2               ;if not try reg 2
                                            BEQ        OR_ea_Dn_An_indir_pinc_r1_out           ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pinc_r2                   CMP.L      #match_OR_An_indir_postinc_r2,D2        ;check reg is equal to 2
                                            BNE        OR_ea_Dn_An_indir_pinc_r3               ;if not try reg 3
                                            BEQ        OR_ea_Dn_An_indir_pinc_r2_out           ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pinc_r3                   CMP.L      #match_OR_An_indir_postinc_r3,D2        ;check reg is equal to 3
                                            BNE        OR_ea_Dn_An_indir_pinc_r4               ;if not try reg 4
                                            BEQ        OR_ea_Dn_An_indir_pinc_r3_out           ;if equal go to output ORroutine
 
OR_ea_Dn_An_indir_pinc_r4                   CMP.L      #match_OR_An_indir_postinc_r4,D2        ;check reg is equal to 4
                                            BNE        OR_ea_Dn_An_indir_pinc_r5               ;if not try reg 5
                                            BEQ        OR_ea_Dn_An_indir_pinc_r4_out           ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pinc_r5                   CMP.L      #match_OR_An_indir_postinc_r5,D2        ;check reg is equal to 5
                                            BNE        OR_ea_Dn_An_indir_pinc_r6               ;if not try reg 6
                                            BEQ        OR_ea_Dn_An_indir_pinc_r5_out           ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pinc_r6                   CMP.L      #match_OR_An_indir_postinc_r6,D2        ;check reg is equal to 6
                                            BNE        OR_ea_Dn_An_indir_pinc_r7               ;if not try reg 7
                                            BEQ        OR_ea_Dn_An_indir_pinc_r6_out           ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pinc_r7                   CMP.L      #match_OR_An_indir_postinc_r7,D2        ;check reg is equal to 7
                                            BEQ        OR_ea_Dn_An_indir_pinc_r7_out           ;if equal go to output ORroutine
                                            BNE        ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
OR_ea_Dn_An_indir_pinc_r0_out			    MOVE.L			#ea_indir_postinc_A0,A1		    			      ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pinc_r1_out			    MOVE.L			#ea_indir_postinc_A1,A1		    			      ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pinc_r2_out			    MOVE.L			#ea_indir_postinc_A2,A1		    			      ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operORO

OR_ea_Dn_An_indir_pinc_r3_out			    MOVE.L			#ea_indir_postinc_A3,A1		    			      ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pinc_r4_out			    MOVE.L			#ea_indir_postinc_A4,A1		    			      ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pinc_r5_out			    MOVE.L			#ea_indir_postinc_A5,A1		    			      ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pinc_r6_out			    MOVE.L			#ea_indir_postinc_A6,A1		    			      ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pinc_r7_out			    MOVE.L			#ea_indir_postinc_A7,A1		    			      ;load string constant into A1
                                            JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

;------------------Address Register Indirect with Pre Decrement-----------------------
OR_ea_Dn_An_indir_predec                    CMP.L      #match_OR_An_indir_predec_reg0,D2       ;check reg is equal to 0
                                            BNE        OR_ea_Dn_An_indir_pdec_r1                      ;if not try reg 1
                                            BEQ        OR_ea_Dn_An_indir_pdec_r0_out               ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pdec_r1                   CMP.L      #match_OR_An_indir_predec_reg1,D2       ;check reg is equal to 1
                                            BNE        OR_ea_Dn_An_indir_pdec_r2                      ;if not try reg 2
                                            BEQ        OR_ea_Dn_An_indir_pdec_r1_out               ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pdec_r2                   CMP.L      #match_OR_An_indir_predec_reg2,D2       ;check reg is equal to 2
                                            BNE        OR_ea_Dn_An_indir_pdec_r3                      ;if not try reg 3
                                            BEQ        OR_ea_Dn_An_indir_pdec_r2_out               ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pdec_r3                   CMP.L      #match_OR_An_indir_predec_reg3,D2       ;check reg is equal to 3
                                            BNE        OR_ea_Dn_An_indir_pdec_r4                      ;if not try reg 4
                                            BEQ        OR_ea_Dn_An_indir_pdec_r3_out               ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pdec_r4                   CMP.L      #match_OR_An_indir_predec_reg4,D2       ;check reg is equal to 4
                                            BNE        OR_ea_Dn_An_indir_pdec_r5                      ;if not try reg 5
                                            BEQ        OR_ea_Dn_An_indir_pdec_r4_out               ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pdec_r5                   CMP.L      #match_OR_An_indir_predec_reg5,D2       ;check reg is equal to 5
                                            BNE        OR_ea_Dn_An_indir_pdec_r6                     ;if not try reg 6
                                            BEQ        OR_ea_Dn_An_indir_pdec_r5_out               ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pdec_r6                   CMP.L      #match_OR_An_indir_predec_reg6,D2       ;check reg is equal to 6
                                            BNE        OR_ea_Dn_An_indir_pdec_r7                     ;if not try reg 7
                                            BEQ        OR_ea_Dn_An_indir_pdec_r6_out               ;if equal go to output ORroutine

OR_ea_Dn_An_indir_pdec_r7                   CMP.L      #match_OR_An_indir_predec_reg7,D2       ;check reg is equal to 7
                                            BEQ        OR_ea_Dn_An_indir_pdec_r7_out               ;if equal go to output ORroutine
                                            BNE        ERROR                                    :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
OR_ea_Dn_An_indir_pdec_r0_out			        MOVE.L			#ea_indir_predec_A0,A1					      ;load string constant into A1
                                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR
											
OR_ea_Dn_An_indir_pdec_r1_out			        MOVE.L			#ea_indir_predec_A1,A1						;load string constant into A1
                                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pdec_r2_out		    	    MOVE.L			#ea_indir_predec_A2,A1						;load string constant into A1
                                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pdec_r3_out	    		    MOVE.L			#ea_indir_predec_A3,A1						;load string constant into A1
                                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pdec_r4_out   			    MOVE.L			#ea_indir_predec_A4,A1						;load string constant into A1
                                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pdec_r5_out		    	    MOVE.L			#ea_indir_predec_A5,A1						;load string constant into A1
                                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pdec_r6_out	    		    MOVE.L			#ea_indir_predec_A6,A1						;load string constant into A1
                                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR

OR_ea_Dn_An_indir_pdec_r7_out   			    MOVE.L			#ea_indir_predec_A7,A1						;load string constant into A1
                                                JSR             OR_determine_second_op                 ;jump to ORroutine to determine second operOR
        
;------------------Absolute Addressing Output-----------------------
OR_ea_Dn_abs_add_word_out				  MOVE.L      #ea_$,(A1)+                         ;load $ for hex OR increment A1
                                          MOVE.L      D5,(A1)+                           ;load address                  
                                          JSR         OR_determine_second_op                 ;jump to ORroutine to determine second operOR
                                           

OR_ea_Dn_abs_add_long_out    			 MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                         MOVE.L      #ea_$,(A1)+                         ;load $ for hex OR increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         JSR         OR_determine_second_op                 ;jump to ORroutine to determine second operOR

;---------------Immediate Addresing---------------------------
OR_ea_Dn_immediate_add_out          MOVE.L		(A0)+,D5                             ;capture the immediate address
									CMP.L       #match_OR_imm_add_word,D6               ;check to see if need to pull word
									MOVE.L      (A0)+,D5                            ;pull the word
                                    BEQ         OR_ea_Dn_imm_add_w                           ;if equal go pull word    
									BNE         OR_ea_Dn_imm_add_l                           ;if not equal, go check long
										 
OR_ea_Dn_imm_add_w                  MOVE.L     #ea_$,(A1)+                          ;load the $
                                    MOVE.W     D5,(A1)+                             ;load the word address                           
                                    JSR        OR_determine_second_op                 ;jump to ORroutine to determine second operOR
                                         
OR_ea_Dn_imm_add_l                  MOVE.L     (A0)+,D5                             ;pull the long OR increase the pointer
                                    MOVE.L     #ea_$,(A1)+                          ;load the $
                                    MOVE.L     D5,A1                               ;move to A1
                                    JSR        OR_determine_second_op                 ;jump to ORroutine to determine second operOR

;---------------------------------Determine Register----------------------------------------------------------------------------------------
OR_determine_second_op							CLR.L		D2							;clear D2 
												OR.L		#mask_OR_An_reg,D2		;load the mask for the register into D2, masks bit 11-9
												
ea_Dn_OR_reg0									CMP.L		#match_OR_reg0,D2		;check to see if reg equal 0
												BNE			ea_Dn_OR_reg1					;if not equal got check reg 1
												BEQ			ea_Dn_OR_reg0_out				;if equal go to output
												
ea_Dn_OR_reg1									CMP.L		#match_OR_reg1,D2		;check to see if reg equal 1
												BNE			ea_Dn_OR_reg2					;if not equal got check reg 2
												BEQ			ea_Dn_OR_reg1_out				;if equal go to output

ea_Dn_OR_reg2	    							CMP.L		#match_OR_reg2,D2		;check to see if reg equal 2
												BNE			ea_Dn_OR_reg3					;if not equal got check reg 3
												BEQ			ea_Dn_OR_reg2_out				;if equal go to output

ea_Dn_OR_reg3									CMP.L		#match_OR_reg3,D2		;check to see if reg equal 3
												BNE			ea_Dn_OR_reg4					;if not equal got check reg 4
												BEQ			ea_Dn_OR_reg3_out				;if equal go to output
												
ea_Dn_OR_reg4									CMP.L		#match_OR_reg4,D2		;check to see if reg equal 4
												BNE			ea_Dn_OR_reg5					;if not equal got check reg 5
												BEQ			ea_Dn_OR_reg4_out				;if equal go to output

ea_Dn_OR_reg5									CMP.L		#match_OR_reg5,D2		;check to see if reg equal 5
												BNE			ea_Dn_OR_reg6					;if not equal got check reg 6
												BEQ			ea_Dn_OR_reg5_out				;if equal go to output

ea_Dn_OR_reg6									CMP.L		#match_OR_reg6,D2		;check to see if reg equal 6
												BNE			ea_Dn_OR_reg7					;if not equal got check reg 7
												BEQ			ea_Dn_OR_reg6_out				;if equal go to output			

ea_Dn_OR_reg7    								CMP.L		#match_OR_reg7,D2		;check to see if reg equal 7
												BEQ			ea_Dn_OR_reg7_out				;if equal go to output
												BNE         ERROR                         ;if not equal to an addresssing mode, pritn error
								

;--------------------Data Output-----------------------
ea_Dn_OR_reg0_out			                    MOVE.L			#ea_D0,A1	                     ;load string constant into A1
                                                RTS
											
ea_Dn_OR_reg1_out			                    MOVE.L			#ea_D1,A1	             		;load string constant into A1
                                                RTS
                                            
ea_Dn_OR_reg2_out			                    MOVE.L			#ea_D2,A1	             		;load string constant into A1
                                                RTS
                                            
ea_Dn_OR_reg3_out			                    MOVE.L			#ea_D3,A1	                   	;load string constant into A1
                                                RTS
                                            
ea_Dn_OR_reg4_out			                    MOVE.L			#ea_D4,A1	             		;load string constant into A1
                                                RTS
                                            
ea_Dn_OR_reg5_out			                    MOVE.L			#ea_D5,A1	                   	;load string constant into A1
                                                RTS
                                            
ea_Dn_OR_reg6_out			                    MOVE.L			#ea_D6,A1		               	;load string constant into A1
                                                RTS
                                            
ea_Dn_OR_reg7_out			                    MOVE.L			#ea_D7,A1		               	;load string constant into A1
                                                RTS				
                                            
                    






























                        
;------------------------------------------------------------------------------------------------------------------------------------------
*                                               Dn,ea
* 
* 
* 
;------------------------------------------------------------------------------------------------------------------------------------------                                              
;---------------------------------Determine Register----------------------------------------------------------------------------------------
OR_Dn_ea       								    CLR.L		D2							      ;clear D2 
												MOVE.L		#mask_OR_An_reg,D2		      ;load the mask for the register into D2, masks bit 11-9
												
Dn_ea_OR_reg0   								CMP.L		#match_OR_reg0,D2		            ;check to see if reg equal 0
												BNE			Dn_ea_OR_reg1					;if not equal got check reg 1
												BEQ			Dn_ea_OR_reg0_out				;if equal go to output
												
Dn_ea_OR_reg1									CMP.L		#match_OR_reg1,D2		            ;check to see if reg equal 1
												BNE			Dn_ea_OR_reg2					;if not equal got check reg 2
												BEQ			Dn_ea_OR_reg1_out				;if equal go to output

Dn_ea_OR_reg2									CMP.L		#match_OR_reg2,D2		            ;check to see if reg equal 2
												BNE			Dn_ea_OR_reg3					;if not equal got check reg 3
												BEQ			Dn_ea_OR_reg2_out				;if equal go to output

Dn_ea_OR_reg3									CMP.L		#match_OR_reg3,D2		            ;check to see if reg equal 3
												BNE			Dn_ea_OR_reg4					;if not equal got check reg 4
												BEQ			Dn_ea_OR_reg3_out				;if equal go to output
												
Dn_ea_OR_reg4									CMP.L		#match_OR_reg4,D2		            ;check to see if reg equal 4
												BNE			Dn_ea_OR_reg5					;if not equal got check reg 5
												BEQ			Dn_ea_OR_reg4_out				;if equal go to output

Dn_ea_OR_reg5									CMP.L		#match_OR_reg5,D2		            ;check to see if reg equal 5
												BNE			Dn_ea_OR_reg6					;if not equal got check reg 6
												BEQ			Dn_ea_OR_reg5_out				;if equal go to output

Dn_ea_OR_reg6									CMP.L		#match_OR_reg6,D2		            ;check to see if reg equal 6
												BNE			Dn_ea_OR_reg7					;if not equal got check reg 7
												BEQ			Dn_ea_OR_reg6_out				;if equal go to output			

Dn_ea_OR_reg7								    CMP.L		#match_OR_reg7,D2		            ;check to see if reg equal 7
												BEQ			Dn_ea_OR_reg7_out				;if equal go to output
												BNE         ERROR                                ;if not equal to an addresssing mode, pritn error
								

;--------------------Data Output-----------------------
Dn_ea_OR_reg0_out		      MOVE.L			#ea_D0,A1					                       ;load string constant into A1
                              JSR               OR_determine_second_operand                 ;jump to ORroutine to determine second operOR
											
Dn_ea_OR_reg1_out		      MOVE.L			#ea_D1,A1				                		;load string constant into A1
                              JSR               OR_determine_second_operand                 ;jump to ORroutine to determine second operOR
                                            
Dn_ea_OR_reg2_out		      MOVE.L			#ea_D2,A1				                		;load string constant into A1
                              JSR               OR_determine_second_operand                 ;jump to ORroutine to determine second operOR
                                            
Dn_ea_OR_reg3_out		      MOVE.L			#ea_D3,A1				                        	;load string constant into A1
                              JSR               OR_determine_second_operand                 ;jump to ORroutine to determine second operOR
                                            
Dn_ea_OR_reg4_out		      MOVE.L			#ea_D4,A1				                    		;load string constant into A1
                              JSR               OR_determine_second_operand                 ;jump to ORroutine to determine second operOR
                                                
Dn_ea_OR_reg5_out		      MOVE.L			#ea_D5,A1					                     	;load string constant into A1
                              JSR               OR_determine_second_operand                 ;jump to ORroutine to determine second operOR
                                            
Dn_ea_OR_reg6_out		      MOVE.L			#ea_D6,A1					                    	;load string constant into A1
                              JSR               OR_determine_second_operand                 ;jump to ORroutine to determine second operOR
                                            
Dn_ea_OR_reg7_out    	      MOVE.L			#ea_D7,A1					                    	;load string constant into A1
                              JSR               OR_determine_second_operand                 ;jump to ORroutine to determine second operOR
                                            
;------------------------------------------------------Determine Second OperOR----------------------------------------------------------------
OR_determine_second_operand      CLR               D1                                            ;clear D1 to load new mask                                
                                 MOVE.L             #mask_OR_ea_mode,D1                        ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
OR_Dn_ea_add_reg_indir           CMP.L             #match_OR_An_indir,D1                      ;check to see if mode is add reg indir
                                 BNE               OR_Dn_ea_add_reg_indir_pdec                          ;if not, go check add reg indir predec 
                                 BEQ               OR_Dn_ea_An_indir_reg                                  ;if equal go figure out the register           
           
OR_Dn_ea_add_reg_indir_pdec      CMP.L             #match_OR_An_indir_predec,D1               ;check to see if mode is add reg indor w/ postinc
                                 BNE               OR_Dn_ea_add_reg_indir_pinc                         ;if not go check add reg indir/predec
                                 BEQ               OR_Dn_ea_An_indir_predec                               ;if equal go figure out the register
                      
OR_Dn_ea_add_reg_indir_pinc      CMP.L             #match_OR_An_indir_postinc,D1              ;check to see if mode is add reg indir w/predec
                                 BNE               OR_Dn_ea_abs_add_word                                  ;if not go check abs add word
                                 BEQ               OR_Dn_ea_An_indir_postinc_reg                          ;if equal go figure out the register

OR_Dn_ea_abs_add_word            MOVE.L             #mask_OR_abs_add,D2                        ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_OR_abs_add_word,D2                  ;check if abs add word
                                 MOVE.L            (A0)+,D5                                      ;pull the next word instruction that holds the address
                                 BNE               OR_Dn_ea_abs_add_long                                  ;if not go check abs add long
                                 BEQ               OR_Dn_ea_abs_add_word_out                              ;if equal go to output
  
OR_Dn_ea_abs_add_long            CMP.L             #match_OR_abs_add_long,D2                  ;check to see if abs add long
                                 BEQ               OR_Dn_ea_abs_add_long_out                              ;if equal go to output
                                 BNE               ERROR                                         ;if not equal go to error mesage OR routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 
;------------------Address Register Indirect-----------------------
OR_Dn_ea_An_indir_reg            MOVE.L          #mask_OR_ea_reg_OR_mode,D2         ;load the mask into D2 for the mode OR the register
                                 CMP.L           #match_OR_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             OR_Dn_ea_An_indir_reg1                           ;if not try reg 1
                                 BEQ             OR_Dn_ea_An_indir_reg0_out                       ;if equal go to output ORroutine

OR_Dn_ea_An_indir_reg1           CMP.L           #match_OR_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             OR_Dn_ea_An_indir_reg2                           ;if not try reg 2
                                 BEQ             OR_Dn_ea_An_indir_reg1_out                       ;if equal go to output ORroutine

OR_Dn_ea_An_indir_reg2           CMP.L           #match_OR_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             OR_Dn_ea_An_indir_reg3                           ;if not try reg 3
                                 BEQ             OR_Dn_ea_An_indir_reg2_out                       ;if equal go to output ORroutine

OR_Dn_ea_An_indir_reg3           CMP.L           #match_OR_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             OR_Dn_ea_An_indir_reg4                           ;if not try reg 4
                                 BEQ             OR_Dn_ea_An_indir_reg3_out                       ;if equal go to output ORroutine
    
OR_Dn_ea_An_indir_reg4           CMP.L           #match_OR_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             OR_Dn_ea_An_indir_reg5                           ;if not try reg 5
                                 BEQ             OR_Dn_ea_An_indir_reg4_out                       ;if equal go to output ORroutine
        
OR_Dn_ea_An_indir_reg5           CMP.L           #match_OR_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             OR_Dn_ea_An_indir_reg6                           ;if not try reg 6
                                 BEQ             OR_Dn_ea_An_indir_reg5_out                       ;if equal go to output ORroutine

OR_Dn_ea_An_indir_reg6           CMP.L           #match_OR_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             OR_Dn_ea_An_indir_reg7                           ;if not try reg 7
                                 BEQ             OR_Dn_ea_An_indir_reg6_out                       ;if equal go to output ORroutine

OR_Dn_ea_An_indir_reg7           CMP.L           #match_OR_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             OR_Dn_ea_An_indir_reg7_out                       ;if equal go to output ORroutine
                                 BNE             ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
OR_Dn_ea_An_indir_reg0_out			MOVE.L			#ea_indir_A0,A1		    	        ;load string constant into A1
                                     RTS

OR_Dn_ea_An_indir_reg1_out			MOVE.L			#ea_indir_A1,A1		    		  ;load string constant into A1
                                     RTS

OR_Dn_ea_An_indir_reg2_out			MOVE.L			#ea_indir_A2,A1		    		  ;load string constant into A1
                                     RTS

OR_Dn_ea_An_indir_reg3_out			MOVE.L			#ea_indir_A3,A1		    		  ;load string constant into A1
                                     RTS

OR_Dn_ea_An_indir_reg4_out			MOVE.L			#ea_indir_A4,A1		    		  ;load string constant into A1
                                     RTS

OR_Dn_ea_An_indir_reg5_out			MOVE.L			#ea_indir_A5,A1		    		  ;load string constant into A1
                                     RTS

OR_Dn_ea_An_indir_reg6_out			MOVE.L			#ea_indir_A6,A1		    		  ;load string constant into A1
                                     RTS
								        
OR_Dn_ea_An_indir_reg7_out			MOVE.L			#ea_indir_A7,A1		    		  ;load string constant into A1
                                    RTS

;------------------Address Register Indirect with Post Increment-----------------------
OR_Dn_ea_An_indir_postinc_reg               CMP.L      #match_OR_An_indir_postinc_r0,D2                 ;check reg is equal to 0
                                            BNE        OR_Dn_ea_An_indir_pinc_r1                      ;if not try reg 1
                                            BEQ        OR_Dn_ea_An_indir_pinc_r0_out                  ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pinc_r1                   CMP.L      #match_OR_An_indir_postinc_r1,D2                 ;check reg is equal to 1
                                            BNE        OR_Dn_ea_An_indir_pinc_r2                      ;if not try reg 2
                                            BEQ        OR_Dn_ea_An_indir_pinc_r1_out                  ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pinc_r2                   CMP.L      #match_OR_An_indir_postinc_r2,D2                ;check reg is equal to 2
                                            BNE        OR_Dn_ea_An_indir_pinc_r3                      ;if not try reg 3
                                            BEQ        OR_Dn_ea_An_indir_pinc_r2_out                  ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pinc_r3                   CMP.L      #match_OR_An_indir_postinc_r3,D2               ;check reg is equal to 3
                                            BNE        OR_Dn_ea_An_indir_pinc_r4                      ;if not try reg 4
                                            BEQ        OR_Dn_ea_An_indir_pinc_r3_out                  ;if equal go to output ORroutine
 
OR_Dn_ea_An_indir_pinc_r4                   CMP.L      #match_OR_An_indir_postinc_r4,D2               ;check reg is equal to 4
                                            BNE        OR_Dn_ea_An_indir_pinc_r5                      ;if not try reg 5
                                            BEQ        OR_Dn_ea_An_indir_pinc_r4_out                  ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pinc_r5                   CMP.L      #match_OR_An_indir_postinc_r5,D2                 ;check reg is equal to 5
                                            BNE        OR_Dn_ea_An_indir_pinc_r6                      ;if not try reg 6
                                            BEQ        OR_Dn_ea_An_indir_pinc_r5_out                  ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pinc_r6                   CMP.L      #match_OR_An_indir_postinc_r6,D2                 ;check reg is equal to 6
                                            BNE        OR_Dn_ea_An_indir_pinc_r7                        ;if not try reg 7
                                            BEQ        OR_Dn_ea_An_indir_pinc_r6_out                    ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pinc_r7                   CMP.L      #match_OR_An_indir_postinc_r7,D2                 ;check reg is equal to 7
                                            BEQ        OR_Dn_ea_An_indir_pinc_r7_out                    ;if equal go to output ORroutine
                                            BNE        ERROR                                            ;if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
OR_Dn_ea_An_indir_pinc_r0_out		    MOVE.L			#ea_indir_postinc_A0,A1		    			      ;load string constant into A1
                                        RTS

OR_Dn_ea_An_indir_pinc_r1_out		    MOVE.L			#ea_indir_postinc_A1,A1		    			      ;load string constant into A1
                                        RTS

OR_Dn_ea_An_indir_pinc_r2_out		    MOVE.L			#ea_indir_postinc_A2,A1		    			      ;load string constant into A1
                                        RTS

OR_Dn_ea_An_indir_pinc_r3_out		    MOVE.L			#ea_indir_postinc_A3,A1		    			      ;load string constant into A1
                                        RTS

OR_Dn_ea_An_indir_pinc_r4_out		    MOVE.L			#ea_indir_postinc_A4,A1		    			      ;load string constant into A1
                                        RTS

OR_Dn_ea_An_indir_pinc_r5_out		    MOVE.L			#ea_indir_postinc_A5,A1		    			      ;load string constant into A1
                                        RTS

OR_Dn_ea_An_indir_pinc_r6_out		    MOVE.L			#ea_indir_postinc_A6,A1		    			      ;load string constant into A1
                                        RTS

OR_Dn_ea_An_indir_pinc_r7_out	        MOVE.L			#ea_indir_postinc_A7,A1		    			      ;load string constant into A1
                                        RTS

;------------------Address Register Indirect with Pre Decrement-----------------------
OR_Dn_ea_An_indir_predec                    CMP.L      #match_OR_An_indir_predec_reg0,D2       ;check reg is equal to 0
                                            BNE        OR_Dn_ea_An_indir_pdec_r1                      ;if not try reg 1
                                            BEQ        OR_Dn_ea_An_indir_pdec_r0_out               ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pdec_r1                   CMP.L      #match_OR_An_indir_predec_reg1,D2       ;check reg is equal to 1
                                            BNE        OR_Dn_ea_An_indir_pdec_r2                      ;if not try reg 2
                                            BEQ        OR_Dn_ea_An_indir_pdec_r1_out               ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pdec_r2                   CMP.L      #match_OR_An_indir_predec_reg2,D2       ;check reg is equal to 2
                                            BNE        OR_Dn_ea_An_indir_pdec_r3                      ;if not try reg 3
                                            BEQ        OR_Dn_ea_An_indir_pdec_r2_out               ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pdec_r3                   CMP.L      #match_OR_An_indir_predec_reg3,D2       ;check reg is equal to 3
                                            BNE        OR_Dn_ea_An_indir_pdec_r4                      ;if not try reg 4
                                            BEQ        OR_Dn_ea_An_indir_pdec_r3_out               ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pdec_r4                   CMP.L      #match_OR_An_indir_predec_reg4,D2       ;check reg is equal to 4
                                            BNE        OR_Dn_ea_An_indir_pdec_r5                      ;if not try reg 5
                                            BEQ        OR_Dn_ea_An_indir_pdec_r4_out               ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pdec_r5                   CMP.L      #match_OR_An_indir_predec_reg5,D2       ;check reg is equal to 5
                                            BNE        OR_Dn_ea_An_indir_pdec_r6                     ;if not try reg 6
                                            BEQ        OR_Dn_ea_An_indir_pdec_r5_out               ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pdec_r6                   CMP.L      #match_OR_An_indir_predec_reg6,D2       ;check reg is equal to 6
                                            BNE        OR_Dn_ea_An_indir_pdec_r7                     ;if not try reg 7
                                            BEQ        OR_Dn_ea_An_indir_pdec_r6_out               ;if equal go to output ORroutine

OR_Dn_ea_An_indir_pdec_r7                   CMP.L      #match_OR_An_indir_predec_reg7,D2       ;check reg is equal to 7
                                            BEQ        OR_Dn_ea_An_indir_pdec_r7_out               ;if equal go to output ORroutine
                                            BNE        ERROR                                    :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
OR_Dn_ea_An_indir_pdec_r0_out   			   MOVE.L			#ea_indir_predec_A0,A1					      ;load string constant into A1
                                               RTS
											
OR_Dn_ea_An_indir_pdec_r1_out	    		   MOVE.L			#ea_indir_predec_A1,A1						;load string constant into A1
                                               RTS

OR_Dn_ea_An_indir_pdec_r2_out		    	   MOVE.L			#ea_indir_predec_A2,A1						;load string constant into A1
                                               RTS

OR_Dn_ea_An_indir_pdec_r3_out			       MOVE.L			#ea_indir_predec_A3,A1						;load string constant into A1
                                               RTS

OR_Dn_ea_An_indir_pdec_r4_out		      	   MOVE.L			#ea_indir_predec_A4,A1						;load string constant into A1
                                               RTS

OR_Dn_ea_An_indir_pdec_r5_out   			   MOVE.L			#ea_indir_predec_A5,A1						;load string constant into A1
                                               RTS

OR_Dn_ea_An_indir_pdec_r6_out	    		   MOVE.L			#ea_indir_predec_A6,A1						;load string constant into A1
                                               RTS

OR_Dn_ea_An_indir_pdec_r7_out		    	   MOVE.L			#ea_indir_predec_A7,A1						;load string constant into A1
                                               RTS
                                            
;------------------Absolute Addressing Output-----------------------
OR_Dn_ea_abs_add_word_out			  MOVE.L      #ea_$,(A1)+                         ;load $ for hex OR increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      RTS                                            :return to ORroutine
                                           

OR_Dn_ea_abs_add_long_out    	   	  MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                      MOVE.L      #ea_$,(A1)+                         ;load $ for hex OR increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      RTS                                            :return to ORroutine                                                                             



ea_D0				    	DC.B		'D0',0
ea_D1			    		DC.B		'D1',0
ea_D2			    		DC.B		'D2',0
ea_D3				    	DC.B		'D3',0
ea_D4			    		DC.B		'D4',0
ea_D5			    		DC.B		'D5',0
ea_D6				    	DC.B		'D6',0
ea_D7			   	    	DC.B		'D7',0

ea_A0                 		DC.B        'A0',0
ea_A1                       DC.B        'A1',0
ea_A2                       DC.B        'A2',0
ea_A3                       DC.B        'A3',0
ea_A4                       DC.B        'A4',0
ea_A5                       DC.B        'A5',0
ea_A6			            DC.B        'A6',0
ea_A7                       DC.B        'A7',0

ea_indir_A0		    		DC.B		'(A0)',0
ea_indir_A1		    		DC.B		'(A1)',0
ea_indir_A2		    		DC.B		'(A2)',0
ea_indir_A3		    		DC.B		'(A3)',0
ea_indir_A4			    	DC.B		'(A4)',0
ea_indir_A5			    	DC.B		'(A5)',0
ea_indir_A6			    	DC.B		'(A6)',0
ea_indir_A7                 DC.B              '(A7)',0

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
ea_paren_closed		    	    DC.B		')',0
ea_abs_word_string	    	    DC.B		'.W',0
ea_abs_long_string	    	    DC.B		'.L',0
ea_$				    	    DC.B		'$',0

mask_OR_opmode                          EQU         $01C0                   ;mask for the opmode to determine operOR order

mask_OR_ea_mode					EQU			$0038
mask_OR_abs_add					EQU			$003F
mask_OR_ea_reg_OR_mode			EQU			$003F
mask_OR_An_reg					EQU			$0E00


match_OR_b_ea_Dn                    EQU         $0100                ;match for ea,Dn byte size
match_OR_w_ea_Dn                    EQU         $0140                ;match for ea,Dn word size
match_OR_l_ea_Dn                    EQU         $0180                ;match for ea,Dn long size

match_OR_b_Dn_ea                    EQU         $0000                ;match for Dn,ea byte size
match_OR_w_Dn_ea                    EQU         $0040                ;match for Dn,ea word size
match_OR_l_Dn_ea                    EQU         $0080                ;match for Dn,ea long size



match_OR_Dn						EQU			$0000
match_OR_An_indir				    EQU			$0010
match_OR_An_indir_predec			EQU			$0020
match_OR_An_indir_postinc			EQU			$0018
match_OR_abs_add_word				EQU			$0038
match_OR_abs_add_long				EQU			$0039

match_OR_D0							EQU			$0000
match_OR_D1							EQU			$0001
match_OR_D2							EQU			$0002
match_OR_D3							EQU			$0003
match_OR_D4							EQU			$0004
match_OR_D5							EQU			$0005
match_OR_D6							EQU			$0006
match_OR_D7							EQU			$0007

match_OR_A0							EQU			$0008
match_OR_A1							EQU			$0009
match_OR_A2							EQU			$000A
match_OR_A3							EQU			$000B
match_OR_A4							EQU			$000C
match_OR_A5							EQU			$000D
match_OR_A6							EQU			$000E
match_OR_A7							EQU			$000F

match_OR_An_indir_r0					EQU			$0010
match_OR_An_indir_r1					EQU			$0011
match_OR_An_indir_r2					EQU			$0012
match_OR_An_indir_r3					EQU			$0013
match_OR_An_indir_r4					EQU			$0014
match_OR_An_indir_r5					EQU			$0015
match_OR_An_indir_r6					EQU			$0016
match_OR_An_indir_r7					EQU			$0017

match_OR_An_indir_postinc_r0		EQU			$0018
match_OR_An_indir_postinc_r1		EQU			$0019
match_OR_An_indir_postinc_r2		EQU			$001A
match_OR_An_indir_postinc_r3		EQU			$001B
match_OR_An_indir_postinc_r4		EQU			$001C
match_OR_An_indir_postinc_r5		EQU			$001D
match_OR_An_indir_postinc_r6		EQU			$001E
match_OR_An_indir_postinc_r7		EQU			$001F

match_OR_An_indir_predec_reg0			EQU			$0020
match_OR_An_indir_predec_reg1			EQU			$0021
match_OR_An_indir_predec_reg2			EQU			$0022
match_OR_An_indir_predec_reg3			EQU			$0023
match_OR_An_indir_predec_reg4			EQU			$0024
match_OR_An_indir_predec_reg5			EQU			$0025
match_OR_An_indir_predec_reg6			EQU			$0026
match_OR_An_indir_predec_reg7			EQU			$0027

match_OR_imm_add                           EQU         $003C
match_OR_imm_add_word                      EQU         $00FC
match_OR_imm_add_long                      EQU         $01FC

match_OR_reg0							EQU			$0000
match_OR_reg1							EQU			$0200
match_OR_reg2							EQU			$0400
match_OR_reg3							EQU			$0600
match_OR_reg4							EQU			$0800
match_OR_reg5							EQU			$0A00
match_OR_reg6							EQU			$0C00
match_OR_reg7							EQU			$0E00



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
