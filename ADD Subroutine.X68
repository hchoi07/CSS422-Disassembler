*-----------------------------------------------------------
* Title      :ADD ADDroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matchs of the dettermined mode and register
* A1 will point to the location of the string constants
*-----------------------------------------------------------    


ADD_ADD                                                  ;preserve the registers, 
;-----------------------------ea,Dn-----------------------------------------------------------------------------------------------------

                                       CLR.L              D1
                                       MOVE.W             D0,D1
                                       AND.L              #mask_opmode,D1                              ;load mask to determine the operand order
                                
ADD_ea_Dn_match                        CMP.L              #match_ADD_b_Dn_ea,D1                 ;check to see if it's Dn,ea
                                       BEQ                ADD_ea_Dn                                 ;if equal go figure out data register
                                       BNE                ADD_ea_Dn_match_w                         ;if not check word size for same order

ADD_ea_Dn_match_w                      CMP.L              #match_ADD_w_Dn_ea,D1                 ;check to see if it's Dn,ea
                                       BEQ                ADD_ea_Dn                                 ;if equal go figure out data register
                                       BNE                ADD_ea_Dn_match_l                         ;if not check long size for same order

ADD_ea_Dn_match_l                      CMP.L              #match_ADD_l_Dn_ea,D1                 ;check to see if it's Dn,ea
                                       BEQ                ADD_Dn_ea                                 ;if equal go figure out data register
                                       BNE                ADD_Dn_ea_match                           ;if not check other order

ADD_Dn_ea_match                        CMP.L              #match_ADD_b_ea_Dn,D1                 ;check to see if it's ea,Dn
                                       BEQ                ADD_Dn_ea                                 ;if equal go figure out ea mode
                                       BNE                ADD_Dn_ea_match_w                         ;if not go check word size for same order

ADD_Dn_ea_match_w                      CMP.L              #match_ADD_w_ea_Dn,D1                 ;check to see if it's ea,Dn
                                       BEQ                ADD_Dn_ea                                 ;if equal go figure out ea mode
                                       BNE                ADD_Dn_ea_match_l                         ;if not go check word size for same order

ADD_Dn_ea_match_l                      CMP.L              #match_ADD_l_ea_Dn,D1                 ;check to see if it's ea,Dn
                                       BEQ                ADD_Dn_ea                                 ;if equal go figure out ea mode
                                       BNE                ADD_ERROR                                 ;if not go to error message
;--------------------------------------------------------------------------------------------------------------------------
*                                               EA,Dn Order                                       
;-------------------------------------------------------------------------------------------------------------------------
ADD_ea_Dn                        CLR.L               D1                                            ;clear D1 to load new mask                                
                                 MOVE.W            D0,D1
                                 AND.L             #mask_ADD_ea_mode,D1                          ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
ADD_ea_Dn_data_reg_dir           CMP.L             #match_ADD_Dn,D1                              ;check to see if mode is data reg direct
                                 BNE               ADD_ea_Dn_add_reg_indir                             ;if not, go check add reg dir
                                 BEQ               ADD_ea_Dn_Dn_reg                                  ;if equal go figure out the register

ADD_ea_Dn_add_reg_indir          CMP.L             #match_ADD_An_indir,D1                        ;check to see if mode is add reg indir
                                 BNE               ADD_ea_Dn_add_reg_indir_predec                    ;if not, go check add reg indir predec 
                                 BEQ               ADD_ea_Dn_An_indir_reg                            ;if equal go figure out the register           
           
ADD_ea_Dn_add_reg_indir_predec   CMP.L             #match_ADD_An_indir_predec,D1                  ;check to see if mode is add reg indor w/ postinc
                                 BNE               ADD_ea_Dn_add_reg_indir_postinc                    ;if not go check add reg indir/predec
                                 BEQ               ADD_ea_Dn_An_indir_predec                          ;if equal go figure out the register
                      
ADD_ea_Dn_add_reg_indir_postinc  CMP.L             #match_ADD_An_indir_postinc,D1              ;check to see if mode is add reg indir w/predec
                                 BNE               ADD_ea_Dn_abs_add_word                                  ;if not go check abs add word
                                 BEQ               ADD_ea_Dn_An_indir_postinc_reg                          ;if equal go figure out the register

ADD_ea_Dn_abs_add_word           AND.L             #mask_ADD_abs_add,D2                        ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_ADD_abs_add_word,D2                  ;check if abs add word
                                 MOVE.L            (A0)+,D5                                      ;pull the next word instruction that holds the address
                                 BNE               ADD_ea_Dn_abs_add_long                                  ;if not go check abs add long
                                 BEQ               ADD_ea_Dn_abs_add_word_out                              ;if equal go to output
  
ADD_ea_Dn_abs_add_long           CMP.L             #match_ADD_abs_add_long,D2                  ;check to see if abs add long
                                 BEQ               ADD_ea_Dn_abs_add_long_out                              ;if equal go to output
                                 
ADD_ea_Dn_immediate_add          CMP.L             #match_imm_add,D1                             ;check if immediate address
                                 BEQ               ADD_ea_Dn_immediate_add_out                             ;if equal go to immediate add ADD routine
								 BNE               ADD_ERROR                                         ;if not equal go to error mesage ADD routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 
;-----------------------------------Data Register Direct--------------------------------
ADD_ea_Dn_Dn_reg                 CLR.L                D2
                                 MOVE.W             D0,D2
                                 AND.L              #mask_ADD_ea_reg_and_mode,D2                       ;load the mask into D2 for the mode and the register
                                 CMP.L              #match_ADD_D0,D2                       ;check to see in the register is 0
                                 BNE                ADD_ea_Dn_rD1                                     ;if not go check register 1
                                 BEQ                ADD_ea_Dn_D0_out                              ;if equal go to output ADDroutine

ADD_ea_Dn_rD1                    CMP.L              #match_ADD_D1,D2                       ;check to see in the register is 1
                                 BNE                ADD_ea_Dn_rD2                                     ;if not go check register 2
                                 BEQ                ADD_ea_Dn_D1_out                              ;if equal go to output ADDroutine

ADD_ea_Dn_rD2                    CMP.L              #match_ADD_D2,D2                       ;check to see in the register is 2
                                 BNE                ADD_ea_Dn_rD3                                     ;if not go check register 3
                                 BEQ                ADD_ea_Dn_D2_out                              ;if equal go to output ADDroutine

ADD_ea_Dn_rD3                    CMP.L              #match_ADD_D3,D2                       ;check to see in the register is 3
                                 BNE                ADD_ea_Dn_rD4                                     ;if not go check register 4
                                 BEQ                ADD_ea_Dn_D3_out                              ;if equal go to output ADDroutine

ADD_ea_Dn_rD4                    CMP.L              #match_ADD_D4,D2                       ;check to see in the register is 4
                                 BNE                ADD_ea_Dn_rD5                                     ;if not go check register 5
                                 BEQ                ADD_ea_Dn_D4_out                              ;if equal go to output ADDroutine

ADD_ea_Dn_rD5                    CMP.L              #match_ADD_D5,D2                       ;check to see in the register is 5
                                 BNE                ADD_ea_Dn_rD6                                     ;if not go check register 6
                                 BEQ                ADD_ea_Dn_D5_out                              ;if equal go to output ADDroutine

ADD_ea_Dn_rD6                    CMP.L              #match_ADD_D6,D2                       ;check to see in the register is 6
                                 BNE                ADD_ea_Dn_rD7                                     ;if not go check register 7
                                 BEQ                ADD_ea_Dn_D6_out                              ;if equal go to output ADDroutine

ADD_ea_Dn_rD7                    CMP.L              #match_ADD_D7,D2                       ;check to see in the register is 7
                                 BEQ                ADD_ea_Dn_D7_out                              ;if equal go to output ADDroutine
                                 BNE                ADD_ERROR                               ;if not equal, got to error message
;--------------------Data Register Direct Output-----------------------
ADD_ea_Dn_D0_out                MOVE.L          #ea_D0,A1							;load string constant into A1
                                JSR             print_first
                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_D1_out                MOVE.L          #ea_D1,A1							;load string constant into A1
                                JSR             print_first
                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand


ADD_ea_Dn_D2_out                MOVE.L          #ea_D2,A1							;load string constant into A1
                                JSR             print_first
                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_D3_out                MOVE.L			#ea_D3,A1							;load string constant into A1
                                JSR             print_first
                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand


ADD_ea_Dn_D4_out                MOVE.L			#ea_D4,A1							;load string constant into A1
                                JSR             print_first
                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand


ADD_ea_Dn_D5_out                MOVE.L			#ea_D5,A1							;load string constant into A1
                                JSR             print_first
                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand


ADD_ea_Dn_D6_out                MOVE.L			#ea_D6,A1							;load string constant into A1
                                JSR             print_first
                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand


ADD_ea_Dn_D7_out                MOVE.L			#ea_D7,A1							;load string constant into A1
                                JSR             print_first
                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

;------------------Address Register Indirect-----------------------
ADD_ea_Dn_An_indir_reg           CLR.L           D2
                                 MOVE.W          D0,D2
                                 AND.L           #mask_ADD_ea_reg_and_mode,D2                       ;load the mask into D2 for the mode and the register
                                 
                                 CMP.L           #match_ADD_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             ADD_ea_Dn_An_indir_reg1                           ;if not try reg 1
                                 BEQ             ADD_ea_Dn_An_indir_reg0_out                       ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_reg1          CMP.L           #match_ADD_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             ADD_ea_Dn_An_indir_reg2                           ;if not try reg 2
                                 BEQ             ADD_ea_Dn_An_indir_reg1_out                       ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_reg2          CMP.L           #match_ADD_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             ADD_ea_Dn_An_indir_reg3                           ;if not try reg 3
                                 BEQ             ADD_ea_Dn_An_indir_reg2_out                       ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_reg3          CMP.L           #match_ADD_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             ADD_ea_Dn_An_indir_reg4                           ;if not try reg 4
                                 BEQ             ADD_ea_Dn_An_indir_reg3_out                       ;if equal go to output ADDroutine
    
ADD_ea_Dn_An_indir_reg4          CMP.L           #match_ADD_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             ADD_ea_Dn_An_indir_reg5                           ;if not try reg 5
                                 BEQ             ADD_ea_Dn_An_indir_reg4_out                       ;if equal go to output ADDroutine
        
ADD_ea_Dn_An_indir_reg5          CMP.L           #match_ADD_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             ADD_ea_Dn_An_indir_reg6                           ;if not try reg 6
                                 BEQ             ADD_ea_Dn_An_indir_reg5_out                       ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_reg6          CMP.L           #match_ADD_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             ADD_ea_Dn_An_indir_reg7                           ;if not try reg 7
                                 BEQ             ADD_ea_Dn_An_indir_reg6_out                       ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_reg7          CMP.L           #match_ADD_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             ADD_ea_Dn_An_indir_reg7_out                       ;if equal go to output ADDroutine
                                 BNE             ADD_ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
ADD_ea_Dn_An_indir_reg0_out			    MOVE.L			#ea_indir_A0,A1		    	        ;load string constant into A1
                                        JSR             print_first                                       
                                         JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_reg1_out			    MOVE.L			#ea_indir_A1,A1		    		  ;load string constant into A1
                                        JSR             print_first        
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_reg2_out			    MOVE.L			#ea_indir_A2,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_reg3_out			    MOVE.L			#ea_indir_A3,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_reg4_out			    MOVE.L			#ea_indir_A4,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_reg5_out			    MOVE.L			#ea_indir_A5,A1		    		  ;load string constant into A1
                                        JSR             print_first    
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_reg6_out			    MOVE.L			#ea_indir_A6,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand
								        
ADD_ea_Dn_An_indir_reg7_out  	        MOVE.L			#ea_indir_A7,A1		    		  ;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

;------------------Address Register Indirect with Post Increment-----------------------
ADD_ea_Dn_An_indir_postinc_reg             CLR.L       D2
                                            MOVE.W     D0,D2
                                            AND.L      #mask_ADD_ea_reg_and_mode,D2                       ;load the mask into D2 for the mode and the register
                                            
                                            CMP.L      #match_ADD_An_indir_postinc_r0,D2        ;check reg is equal to 0
                                            BNE        ADD_ea_Dn_An_indir_postinc_reg1                      ;if not try reg 1
                                            BEQ        ADD_ea_Dn_An_indir_postin_r0_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_postinc_reg1             CMP.L      #match_ADD_An_indir_postinc_r1,D2        ;check reg is equal to 1
                                            BNE        ADD_ea_Dn_An_indir_postinc_reg2                      ;if not try reg 2
                                            BEQ        ADD_ea_Dn_An_indir_postin_r1_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_postinc_reg2             CMP.L      #match_ADD_An_indir_postinc_r2,D2        ;check reg is equal to 2
                                            BNE        ADD_ea_Dn_An_indir_postinc_reg3                      ;if not try reg 3
                                            BEQ        ADD_ea_Dn_An_indir_postin_r2_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_postinc_reg3             CMP.L      #match_ADD_An_indir_postinc_r3,D2        ;check reg is equal to 3
                                            BNE        ADD_ea_Dn_An_indir_postinc_reg4                      ;if not try reg 4
                                            BEQ        ADD_ea_Dn_An_indir_postin_r3_out               ;if equal go to output ADDroutine
 
ADD_ea_Dn_An_indir_postinc_reg4             CMP.L      #match_ADD_An_indir_postinc_r4,D2        ;check reg is equal to 4
                                            BNE        ADD_ea_Dn_An_indir_postinc_reg5                      ;if not try reg 5
                                            BEQ        ADD_ea_Dn_An_indir_postin_r4_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_postinc_reg5             CMP.L      #match_ADD_An_indir_postinc_r5,D2        ;check reg is equal to 5
                                            BNE        ADD_ea_Dn_An_indir_postinc_reg6                      ;if not try reg 6
                                            BEQ        ADD_ea_Dn_An_indir_postin_r5_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_postinc_reg6             CMP.L      #match_ADD_An_indir_postinc_r6,D2         ;check reg is equal to 6
                                            BNE        ADD_ea_Dn_An_indir_postinc_reg7                        ;if not try reg 7
                                            BEQ        ADD_ea_Dn_An_indir_postin_r6_out                    ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_postinc_reg7             CMP.L      #match_ADD_An_indir_postinc_r7,D2         ;check reg is equal to 7
                                            BEQ        ADD_ea_Dn_An_indir_postin_r7_out                    ;if equal go to output ADDroutine
                                            BNE        ADD_ERROR                                        :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
ADD_ea_Dn_An_indir_postin_r0_out			    MOVE.L			#ea_indir_postinc_A0,A1		    			      ;load string constant into A1
                                                JSR             print_first
                                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_postin_r1_out			    MOVE.L			#ea_indir_postinc_A1,A1		    			      ;load string constant into A1
                                                JSR             print_first
                                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_postin_r2_out			    MOVE.L			#ea_indir_postinc_A2,A1		    			      ;load string constant into A1
                                                JSR             print_first
                                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_postin_r3_out			    MOVE.L			#ea_indir_postinc_A3,A1		    			      ;load string constant into A1
                                                JSR             print_first
                                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_postin_r4_out			    MOVE.L			#ea_indir_postinc_A4,A1		    			      ;load string constant into A1
                                                JSR             print_first
                                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_postin_r5_out			    MOVE.L			#ea_indir_postinc_A5,A1		    			      ;load string constant into A1
                                                JSR             print_first
                                                 JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_postin_r6_out			    MOVE.L			#ea_indir_postinc_A6,A1		    			      ;load string constant into A1
                                                JSR             print_first
                                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_postin_r7_out			    MOVE.L			#ea_indir_postinc_A7,A1		    			      ;load string constant into A1
                                                JSR             print_first
                                                JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

;------------------Address Register Indirect with Pre Decrement-----------------------
ADD_ea_Dn_An_indir_predec                   CLR.L      D2
                                            MOVE.W     D0,D2
                                            AND.L      #mask_ADD_ea_reg_and_mode,D2                       ;load the mask into D2 for the mode and the register
                                            CMP.L      #match_ADD_An_indir_predec_reg0,D2       ;check reg is equal to 0
                                            
                                            BNE        ADD_ea_Dn_An_indir_predec_reg1                      ;if not try reg 1
                                            BEQ        ADD_ea_Dn_An_indir_prede_r0_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_predec_reg1              CMP.L      #match_ADD_An_indir_predec_reg1,D2       ;check reg is equal to 1
                                            BNE        ADD_ea_Dn_An_indir_predec_reg2                      ;if not try reg 2
                                            BEQ        ADD_ea_Dn_An_indir_prede_r1_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_predec_reg2              CMP.L      #match_ADD_An_indir_predec_reg2,D2       ;check reg is equal to 2
                                            BNE        ADD_ea_Dn_An_indir_predec_reg3                      ;if not try reg 3
                                            BEQ        ADD_ea_Dn_An_indir_prede_r2_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_predec_reg3              CMP.L      #match_ADD_An_indir_predec_reg3,D2       ;check reg is equal to 3
                                            BNE        ADD_ea_Dn_An_indir_predec_reg4                      ;if not try reg 4
                                            BEQ        ADD_ea_Dn_An_indir_prede_r3_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_predec_reg4              CMP.L      #match_ADD_An_indir_predec_reg4,D2       ;check reg is equal to 4
                                            BNE        ADD_ea_Dn_An_indir_predec_reg5                      ;if not try reg 5
                                            BEQ        ADD_ea_Dn_An_indir_prede_r4_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_predec_reg5              CMP.L      #match_ADD_An_indir_predec_reg5,D2       ;check reg is equal to 5
                                            BNE        ADD_ea_Dn_An_indir_predec_reg6                     ;if not try reg 6
                                            BEQ        ADD_ea_Dn_An_indir_prede_r5_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_predec_reg6              CMP.L      #match_ADD_An_indir_predec_reg6,D2       ;check reg is equal to 6
                                            BNE        ADD_ea_Dn_An_indir_predec_reg7                     ;if not try reg 7
                                            BEQ        ADD_ea_Dn_An_indir_prede_r6_out               ;if equal go to output ADDroutine

ADD_ea_Dn_An_indir_predec_reg7              CMP.L      #match_ADD_An_indir_predec_reg7,D2       ;check reg is equal to 7
                                            BEQ        ADD_ea_Dn_An_indir_prede_r7_out               ;if equal go to output ADDroutine
                                            BNE        ADD_ERROR                                    :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
ADD_ea_Dn_An_indir_prede_r0_out			MOVE.L			#ea_indir_predec_A0,A1					      ;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand
											
ADD_ea_Dn_An_indir_prede_r1_out			MOVE.L			#ea_indir_predec_A1,A1						;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_prede_r2_out			MOVE.L			#ea_indir_predec_A2,A1						;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_prede_r3_out			MOVE.L			#ea_indir_predec_A3,A1						;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_prede_r4_out		    MOVE.L			#ea_indir_predec_A4,A1						;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_prede_r5_out		    MOVE.L			#ea_indir_predec_A5,A1						;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_prede_r6_out		    MOVE.L			#ea_indir_predec_A6,A1						;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

ADD_ea_Dn_An_indir_prede_r7_out		    MOVE.L			#ea_indir_predec_A7,A1						;load string constant into A1
                                        JSR             print_first
                                        JSR             ADD_determine_second_op                 ;jump to ADDroutine to determine second operand
        
;------------------Absolute Addressing Output-----------------------
ADD_ea_Dn_abs_add_word_out			  MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      JSR             print_first
                                      RTS                                            :return to ADDroutine
                                           

ADD_ea_Dn_abs_add_long_out    			 MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                      MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      JSR             print_first
                                      RTS                                            :return to ADDroutine                                            
;---------------Immediate Addresing---------------------------
ADD_ea_Dn_immediate_add_out          MOVE.L		(A0)+,D5                             ;capture the immediate address
									 CMP.L       #match_imm_add_word,D6               ;check to see if need to pull word
									 MOVE.L      (A0)+,D5                            ;pull the word
                                     BEQ         ADD_ea_Dn_imm_add_w                           ;if equal go pull word    
									 BNE         ADD_ea_Dn_imm_add_l                           ;if not equal, go check long
										 
ADD_ea_Dn_imm_add_w                   MOVE.L     #ea_$,(A1)+                          ;load the $
                                      MOVE.W     D5,(A1)+                             ;load the word address                           
                                        JSR             print_first
                                      JSR        ADD_determine_second_op                 ;jump to ADDroutine to determine second operand
                                         
ADD_ea_Dn_imm_add_l                   MOVE.L     (A0)+,D5                             ;pull the long and increase the pointer
                                      MOVE.L     #ea_$,(A1)+                          ;load the $
                                      MOVE.L     D5,A1                               ;move to A
                                      JSR             print_first
                                      JSR        ADD_determine_second_op                 ;jump to ADDroutine to determine second operand

;---------------------------------Determine Register----------------------------------------------------------------------------------------
ADD_determine_second_op							CLR.L		D2							;clear D2 
                                                MOVE.W      D0,D2												
                                                AND.L		#mask_ADD_An_reg,D2		;load the mask for the register into D2, masks bit 11-9
												
ea_Dn_ADD_reg0								    CMP.L		#match_ADD_reg0,D2		;check to see if reg equal 0
												BNE			ea_Dn_ADD_reg1					;if not equal got check reg 1
												BEQ			ea_Dn_ADD_reg0_out				;if equal go to output
												
ea_Dn_ADD_reg1									CMP.L		#match_ADD_reg1,D2		;check to see if reg equal 1
												BNE			ea_Dn_ADD_reg2					;if not equal got check reg 2
												BEQ			ea_Dn_ADD_reg1_out				;if equal go to output

ea_Dn_ADD_reg2									CMP.L		#match_ADD_reg2,D2		;check to see if reg equal 2
												BNE			ea_Dn_ADD_reg3					;if not equal got check reg 3
												BEQ			ea_Dn_ADD_reg2_out				;if equal go to output

ea_Dn_ADD_reg3									CMP.L		#match_ADD_reg3,D2		;check to see if reg equal 3
									        	BNE			ea_Dn_ADD_reg4					;if not equal got check reg 4
												BEQ			ea_Dn_ADD_reg3_out				;if equal go to output
												
ea_Dn_ADD_reg4									CMP.L		#match_ADD_reg4,D2		;check to see if reg equal 4
												BNE			ea_Dn_ADD_reg5					;if not equal got check reg 5
												BEQ			ea_Dn_ADD_reg4_out				;if equal go to output

ea_Dn_ADD_reg5				    				CMP.L		#match_ADD_reg5,D2		;check to see if reg equal 5
					        					BNE			ea_Dn_ADD_reg6					;if not equal got check reg 6
												BEQ			ea_Dn_ADD_reg5_out				;if equal go to output

ea_Dn_ADD_reg6									CMP.L		#match_ADD_reg6,D2		;check to see if reg equal 6
												BNE			ea_Dn_ADD_reg7					;if not equal got check reg 7
												BEQ			ea_Dn_ADD_reg6_out				;if equal go to output			

ea_Dn_ADD_reg7	    							CMP.L		#match_ADD_reg7,D2		;check to see if reg equal 7
												BEQ			ea_Dn_ADD_reg7_out				;if equal go to output
												BNE         ADD_ERROR                         ;if not equal to an addresssing mode, pritn error
								

;--------------------Data Output-----------------------
ea_Dn_ADD_reg0_out			               MOVE.L			#ea_D0,A1					                       ;load string constant into A1
                                            RTS
											
ea_Dn_ADD_reg1_out			               MOVE.L			#ea_D1,A1				                		;load string constant into A1
                                            RTS
                                            
ea_Dn_ADD_reg2_out			               MOVE.L			#ea_D2,A1				                		;load string constant into A1
                                            RTS
                                            
ea_Dn_ADD_reg3_out			               MOVE.L			#ea_D3,A1				                        	;load string constant into A1
                                            RTS
                                            
ea_Dn_ADD_reg4_out			               MOVE.L			#ea_D4,A1				                    		;load string constant into A1
                                            RTS
                                            
ea_Dn_ADD_reg5_out			               MOVE.L			#ea_D5,A1					                     	;load string constant into A1
                                            RTS
                                            
ea_Dn_ADD_reg6_out			               MOVE.L			#ea_D6,A1					                    	;load string constant into A1
                                            RTS
                                            
ea_Dn_ADD_reg7_out			               MOVE.L			#ea_D7,A1					                    	;load string constant into A1
                                            RTS				
                                            
                    






























                        
;------------------------------------------------------------------------------------------------------------------------------------------
*                                               Dn,ea
* 
* 
* 
;------------------------------------------------------------------------------------------------------------------------------------------                                              
;---------------------------------Determine Register----------------------------------------------------------------------------------------
ADD_Dn_ea           						    CLR.L		D2							      ;clear D2 
												MOVE.W      D0,D2
                                                AND.L		#mask_ADD_An_reg,D2		      ;load the mask for the register into D2, masks bit 11-9
												
Dn_ea_ADD_reg0   								CMP.L		#match_ADD_reg0,D2		            ;check to see if reg equal 0
												BNE			Dn_ea_ADD_reg1					;if not equal got check reg 1
												BEQ			Dn_ea_ADD_reg0_out				;if equal go to output
												
Dn_ea_ADD_reg1									CMP.L		#match_ADD_reg1,D2		            ;check to see if reg equal 1
												BNE			Dn_ea_ADD_reg2					;if not equal got check reg 2
												BEQ			Dn_ea_ADD_reg1_out				;if equal go to output

Dn_ea_ADD_reg2									CMP.L		#match_ADD_reg2,D2		            ;check to see if reg equal 2
												BNE			Dn_ea_ADD_reg3					;if not equal got check reg 3
												BEQ			Dn_ea_ADD_reg2_out				;if equal go to output

Dn_ea_ADD_reg3									CMP.L		#match_ADD_reg3,D2		            ;check to see if reg equal 3
												BNE			Dn_ea_ADD_reg4					;if not equal got check reg 4
												BEQ			Dn_ea_ADD_reg3_out				;if equal go to output
												
Dn_ea_ADD_reg4									CMP.L		#match_ADD_reg4,D2		            ;check to see if reg equal 4
												BNE			Dn_ea_ADD_reg5					;if not equal got check reg 5
												BEQ			Dn_ea_ADD_reg4_out				;if equal go to output

Dn_ea_ADD_reg5									CMP.L		#match_ADD_reg5,D2		            ;check to see if reg equal 5
												BNE			Dn_ea_ADD_reg6					;if not equal got check reg 6
												BEQ			Dn_ea_ADD_reg5_out				;if equal go to output

Dn_ea_ADD_reg6									CMP.L		#match_ADD_reg6,D2		            ;check to see if reg equal 6
												BNE			Dn_ea_ADD_reg7					;if not equal got check reg 7
												BEQ			Dn_ea_ADD_reg6_out				;if equal go to output			

Dn_ea_ADD_reg7								    CMP.L		#match_ADD_reg7,D2		            ;check to see if reg equal 7
												BEQ			Dn_ea_ADD_reg7_out				;if equal go to output
												BNE         ADD_ERROR                                ;if not equal to an addresssing mode, pritn error
								

;--------------------Data Output-----------------------
Dn_ea_ADD_reg0_out		         MOVE.L			#ea_D0,A1					                       ;load string constant into A1
                                 JSR            print_first
                                 JSR            ADD_determine_second_operand                 ;jump to ADDroutine to determine second operand

											
Dn_ea_ADD_reg1_out		         MOVE.L			#ea_D1,A1				                		;load string constant into A1
                                 JSR            print_first
                                 JSR            ADD_determine_second_operand                 ;jump to ADDroutine to determine second operand
                                            
Dn_ea_ADD_reg2_out		         MOVE.L			#ea_D2,A1				                		;load string constant into A1
                                 JSR            print_first
                                 JSR            ADD_determine_second_operand                 ;jump to ADDroutine to determine second operand
                                            
Dn_ea_ADD_reg3_out		         MOVE.L			#ea_D3,A1				                        	;load string constant into A1
                                 JSR            print_first
                                 JSR            ADD_determine_second_operand                 ;jump to ADDroutine to determine second operand
                                            
Dn_ea_ADD_reg4_out		         MOVE.L			#ea_D4,A1				                    		;load string constant into A1
                                 JSR            print_first
                                 JSR            ADD_determine_second_operand                 ;jump to ADDroutine to determine second operand
                                            
Dn_ea_ADD_reg5_out		         MOVE.L			#ea_D5,A1					                     	;load string constant into A1
                                 JSR            print_first
                                 JSR            ADD_determine_second_operand                 ;jump to ADDroutine to determine second operand
                                            
Dn_ea_ADD_reg6_out		         MOVE.L			#ea_D6,A1					                    	;load string constant into A1
                                 JSR            print_first
                                 JSR            ADD_determine_second_operand                 ;jump to ADDroutine to determine second operand
                                            
Dn_ea_ADD_reg7_out    	         MOVE.L			#ea_D7,A1					                    	;load string constant into A1
                                 JSR            print_first
                                 JSR            ADD_determine_second_operand                 ;jump to ADDroutine to determine second operand
                                            
;------------------------------------------------------Determine Second Operand----------------------------------------------------------------
ADD_determine_second_operand     CLR               D1                                            ;clear D1 to load new mask                                
                                MOVE.W             D0,D1 
                                AND.L             #mask_ADD_ea_mode,D1                        ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
ADD_Dn_ea_add_reg_indir          CMP.L             #match_ADD_An_indir,D1                      ;check to see if mode is add reg indir
                                 BNE               ADD_Dn_ea_add_reg_indir_predec                          ;if not, go check add reg indir predec 
                                 BEQ               ADD_Dn_ea_An_indir_reg                                  ;if equal go figure out the register           
           
ADD_Dn_ea_add_reg_indir_predec   CMP.L             #match_ADD_An_indir_predec,D1               ;check to see if mode is add reg indor w/ postinc
                                 BNE               ADD_Dn_ea_add_reg_indir_postinc                         ;if not go check add reg indir/predec
                                 BEQ               ADD_Dn_ea_An_indir_predec                               ;if equal go figure out the register
                      
ADD_Dn_ea_add_reg_indir_postinc  CMP.L             #match_ADD_An_indir_postinc,D1              ;check to see if mode is add reg indir w/predec
                                 BNE               ADD_Dn_ea_abs_add_word                                  ;if not go check abs add word
                                 BEQ               ADD_Dn_ea_An_indir_postinc_reg                          ;if equal go figure out the register

ADD_Dn_ea_abs_add_word           CLR.L             D2
                                 MOVE.W            D0,D2
                                 AND.L             #mask_ADD_abs_add,D2                        ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_ADD_abs_add_word,D2                  ;check if abs add word
                                 MOVE.L            (A0)+,D5                                      ;pull the next word instruction that holds the address
                                 BNE               ADD_Dn_ea_abs_add_long                                  ;if not go check abs add long
                                 BEQ               ADD_Dn_ea_abs_add_word_out                              ;if equal go to output
  
ADD_Dn_ea_abs_add_long           CMP.L             #match_ADD_abs_add_long,D2                  ;check to see if abs add long
                                 BEQ               ADD_Dn_ea_abs_add_long_out                              ;if equal go to output
                                 BNE               ADD_ERROR                                         ;if not equal go to error mesage ADD routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 
;------------------Address Register Indirect-----------------------
ADD_Dn_ea_An_indir_reg          CLR.L           D2
                                MOVE.W          D0,D2 
                                AND.L           #mask_ADD_ea_reg_and_mode,D2         ;load the mask into D2 for the mode and the register
                                 CMP.L          #match_ADD_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             ADD_Dn_ea_An_indir_reg1                           ;if not try reg 1
                                 BEQ             ADD_Dn_ea_An_indir_reg0_out                       ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_reg1          CMP.L           #match_ADD_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             ADD_Dn_ea_An_indir_reg2                           ;if not try reg 2
                                 BEQ             ADD_Dn_ea_An_indir_reg1_out                       ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_reg2          CMP.L           #match_ADD_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             ADD_Dn_ea_An_indir_reg3                           ;if not try reg 3
                                 BEQ             ADD_Dn_ea_An_indir_reg2_out                       ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_reg3          CMP.L           #match_ADD_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             ADD_Dn_ea_An_indir_reg4                           ;if not try reg 4
                                 BEQ             ADD_Dn_ea_An_indir_reg3_out                       ;if equal go to output ADDroutine
    
ADD_Dn_ea_An_indir_reg4          CMP.L           #match_ADD_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             ADD_Dn_ea_An_indir_reg5                           ;if not try reg 5
                                 BEQ             ADD_Dn_ea_An_indir_reg4_out                       ;if equal go to output ADDroutine
        
ADD_Dn_ea_An_indir_reg5          CMP.L           #match_ADD_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             ADD_Dn_ea_An_indir_reg6                           ;if not try reg 6
                                 BEQ             ADD_Dn_ea_An_indir_reg5_out                       ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_reg6          CMP.L           #match_ADD_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             ADD_Dn_ea_An_indir_reg7                           ;if not try reg 7
                                 BEQ             ADD_Dn_ea_An_indir_reg6_out                       ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_reg7          CMP.L           #match_ADD_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             ADD_Dn_ea_An_indir_reg7_out                       ;if equal go to output ADDroutine
                                 BNE             ADD_ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
ADD_Dn_ea_An_indir_reg0_out			MOVE.L			#ea_indir_A0,A1		    	        ;load string constant into A1
                                     RTS

ADD_Dn_ea_An_indir_reg1_out			MOVE.L			#ea_indir_A1,A1		    		  ;load string constant into A1
                                     RTS

ADD_Dn_ea_An_indir_reg2_out			MOVE.L			#ea_indir_A2,A1		    		  ;load string constant into A1
                                     RTS

ADD_Dn_ea_An_indir_reg3_out			MOVE.L			#ea_indir_A3,A1		    		  ;load string constant into A1
                                     RTS

ADD_Dn_ea_An_indir_reg4_out			MOVE.L			#ea_indir_A4,A1		    		  ;load string constant into A1
                                     RTS

ADD_Dn_ea_An_indir_reg5_out			MOVE.L			#ea_indir_A5,A1		    		  ;load string constant into A1
                                     RTS

ADD_Dn_ea_An_indir_reg6_out			MOVE.L			#ea_indir_A6,A1		    		  ;load string constant into A1
                                     RTS
								        
ADD_Dn_ea_An_indir_reg7_out			MOVE.L			#ea_indir_A7,A1		    		  ;load string constant into A1
                                     RTS

;------------------Address Register Indirect with Post Increment-----------------------
ADD_Dn_ea_An_indir_postinc_reg              CLR.L           D2
                                            MOVE.W          D0,D2 
                                            CMP.L      #match_ADD_An_indir_postinc_r0,D2        ;check reg is equal to 0
                                            BNE        ADD_Dn_ea_An_indir_postinc_reg1                      ;if not try reg 1
                                            BEQ        ADD_Dn_ea_An_indir_postin_r0_out                  ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_postinc_reg1             CMP.L      #match_ADD_An_indir_postinc_r1,D2        ;check reg is equal to 1
                                            BNE        ADD_Dn_ea_An_indir_postinc_reg2                      ;if not try reg 2
                                            BEQ        ADD_Dn_ea_An_indir_postin_r1_out                  ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_postinc_reg2             CMP.L      #match_ADD_An_indir_postinc_r2,D2        ;check reg is equal to 2
                                            BNE        ADD_Dn_ea_An_indir_postinc_reg3                      ;if not try reg 3
                                            BEQ        ADD_Dn_ea_An_indir_postin_r2_out                  ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_postinc_reg3             CMP.L      #match_ADD_An_indir_postinc_r3,D2        ;check reg is equal to 3
                                            BNE        ADD_Dn_ea_An_indir_postinc_reg4                      ;if not try reg 4
                                            BEQ        ADD_Dn_ea_An_indir_postin_r3_out                  ;if equal go to output ADDroutine
 
ADD_Dn_ea_An_indir_postinc_reg4             CMP.L      #match_ADD_An_indir_postinc_r4,D2        ;check reg is equal to 4
                                            BNE        ADD_Dn_ea_An_indir_postinc_reg5                      ;if not try reg 5
                                            BEQ        ADD_Dn_ea_An_indir_postin_r4_out                  ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_postinc_reg5             CMP.L      #match_ADD_An_indir_postinc_r5,D2        ;check reg is equal to 5
                                            BNE        ADD_Dn_ea_An_indir_postinc_reg6                      ;if not try reg 6
                                            BEQ        ADD_Dn_ea_An_indir_postin_r5_out                  ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_postinc_reg6             CMP.L      #match_ADD_An_indir_postinc_r6,D2         ;check reg is equal to 6
                                            BNE        ADD_Dn_ea_An_indir_postinc_reg7                        ;if not try reg 7
                                            BEQ        ADD_Dn_ea_An_indir_postin_r6_out                    ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_postinc_reg7             CMP.L      #match_ADD_An_indir_postinc_r7,D2         ;check reg is equal to 7
                                            BEQ        ADD_Dn_ea_An_indir_postin_r7_out                    ;if equal go to output ADDroutine
                                            BNE        ADD_ERROR                                        :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
ADD_Dn_ea_An_indir_postin_r0_out			    MOVE.L			#ea_indir_postinc_A0,A1		    			      ;load string constant into A1
                                                RTS

ADD_Dn_ea_An_indir_postin_r1_out			    MOVE.L			#ea_indir_postinc_A1,A1		    			      ;load string constant into A1
                                                RTS

ADD_Dn_ea_An_indir_postin_r2_out			    MOVE.L			#ea_indir_postinc_A2,A1		    			      ;load string constant into A1
                                                RTS

ADD_Dn_ea_An_indir_postin_r3_out			    MOVE.L			#ea_indir_postinc_A3,A1		    			      ;load string constant into A1
                                                RTS

ADD_Dn_ea_An_indir_postin_r4_out			    MOVE.L			#ea_indir_postinc_A4,A1		    			      ;load string constant into A1
                                                RTS

ADD_Dn_ea_An_indir_postin_r5_out			    MOVE.L			#ea_indir_postinc_A5,A1		    			      ;load string constant into A1
                                                RTS

ADD_Dn_ea_An_indir_postin_r6_out			    MOVE.L			#ea_indir_postinc_A6,A1		    			      ;load string constant into A1
                                                RTS

ADD_Dn_ea_An_indir_postin_r7_out			    MOVE.L			#ea_indir_postinc_A7,A1		    			      ;load string constant into A1
                                                RTS

;------------------Address Register Indirect with Pre Decrement-----------------------
ADD_Dn_ea_An_indir_predec                   CLR.L           D2
                                            MOVE.W          D0,D2 
                                            CMP.L      #match_ADD_An_indir_predec_reg0,D2       ;check reg is equal to 0
                                            BNE        ADD_Dn_ea_An_indir_predec_reg1                      ;if not try reg 1
                                            BEQ        ADD_Dn_ea_An_indir_prede_r0_out               ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_predec_reg1              CMP.L      #match_ADD_An_indir_predec_reg1,D2       ;check reg is equal to 1
                                            BNE        ADD_Dn_ea_An_indir_predec_reg2                      ;if not try reg 2
                                            BEQ        ADD_Dn_ea_An_indir_prede_r1_out               ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_predec_reg2              CMP.L      #match_ADD_An_indir_predec_reg2,D2       ;check reg is equal to 2
                                            BNE        ADD_Dn_ea_An_indir_predec_reg3                      ;if not try reg 3
                                            BEQ        ADD_Dn_ea_An_indir_prede_r2_out               ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_predec_reg3              CMP.L      #match_ADD_An_indir_predec_reg3,D2       ;check reg is equal to 3
                                            BNE        ADD_Dn_ea_An_indir_predec_reg4                      ;if not try reg 4
                                            BEQ        ADD_Dn_ea_An_indir_prede_r3_out               ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_predec_reg4              CMP.L      #match_ADD_An_indir_predec_reg4,D2       ;check reg is equal to 4
                                            BNE        ADD_Dn_ea_An_indir_predec_reg5                      ;if not try reg 5
                                            BEQ        ADD_Dn_ea_An_indir_prede_r4_out               ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_predec_reg5              CMP.L      #match_ADD_An_indir_predec_reg5,D2       ;check reg is equal to 5
                                            BNE        ADD_Dn_ea_An_indir_predec_reg6                     ;if not try reg 6
                                            BEQ        ADD_Dn_ea_An_indir_prede_r5_out               ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_predec_reg6              CMP.L      #match_ADD_An_indir_predec_reg6,D2       ;check reg is equal to 6
                                            BNE        ADD_Dn_ea_An_indir_predec_reg7                     ;if not try reg 7
                                            BEQ        ADD_Dn_ea_An_indir_prede_r6_out               ;if equal go to output ADDroutine

ADD_Dn_ea_An_indir_predec_reg7              CMP.L      #match_ADD_An_indir_predec_reg7,D2       ;check reg is equal to 7
                                            BEQ        ADD_Dn_ea_An_indir_prede_r7_out               ;if equal go to output ADDroutine
                                            BNE        ADD_ERROR                                    :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
ADD_Dn_ea_An_indir_prede_r0_out			   MOVE.L			#ea_indir_predec_A0,A1					      ;load string constant into A1
                                               RTS
											
ADD_Dn_ea_An_indir_prede_r1_out			   MOVE.L			#ea_indir_predec_A1,A1						;load string constant into A1
                                               RTS

ADD_Dn_ea_An_indir_prede_r2_out			   MOVE.L			#ea_indir_predec_A2,A1						;load string constant into A1
                                               RTS

ADD_Dn_ea_An_indir_prede_r3_out			   MOVE.L			#ea_indir_predec_A3,A1						;load string constant into A1
                                               RTS

ADD_Dn_ea_An_indir_prede_r4_out			   MOVE.L			#ea_indir_predec_A4,A1						;load string constant into A1
                                               RTS

ADD_Dn_ea_An_indir_prede_r5_out			   MOVE.L			#ea_indir_predec_A5,A1						;load string constant into A1
                                               RTS

ADD_Dn_ea_An_indir_prede_r6_out			   MOVE.L			#ea_indir_predec_A6,A1						;load string constant into A1
                                               RTS

ADD_Dn_ea_An_indir_prede_r7_out			   MOVE.L			#ea_indir_predec_A7,A1						;load string constant into A1
                                               RTS
                                            
;------------------Absolute Addressing Output-----------------------
ADD_Dn_ea_abs_add_word_out			  MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      RTS                                            :return to ADDroutine
                                           


ADD_Dn_ea_abs_add_long_out    		  MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                      MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      RTS                                            :return to ADDroutine                                            
;---------------Immediate Addresing--------------------------
ADD_Dn_ea_immediate_add_out           MOVE.L		(A0)+,D5                             ;capture the immediate address
							          CMP.L       #match_imm_add_word,D6               ;check to see if need to pull word
								      MOVE.L      (A0)+,D5                            ;pull the word
                                      BEQ         ADD_Dn_ea_imm_add_w                           ;if equal go pull word    
								      BNE         ADD_Dn_ea_imm_add_l                           ;if not equal, go check long
										 
ADD_Dn_ea_imm_add_w                   MOVE.L     #ea_$,(A1)+                          ;load the $
                                      MOVE.W     D5,(A1)+                             ;load the word address                           
                                      RTS
                                         
ADD_Dn_ea_imm_add_l                   MOVE.L     (A0)+,D5                             ;pull the long and increase the pointer
                                      MOVE.L     #ea_$,(A1)+                          ;load the $
                                      MOVE.L     D5,A1                               ;move to A1
                                      RTS











                                 
;----------------------Error Handling----------------------------------------
ADD_ERROR                                           LEA     ERROR_MESSAGE,A1                                         ;load error messge into A3
					                            RTS
					                            
					                            
mask_opmode                         EQU         $01C0                   ;mask for the opmode to determine operand order

mask_ADD_ea_mode					EQU			$0038
mask_ADD_abs_add					EQU			$003F
mask_ADD_ea_reg_and_mode			EQU			$003F
mask_ADD_An_reg				    	EQU			$0E00


match_ADD_b_ea_Dn                    EQU         $0100                ;match for ea,Dn byte size
match_ADD_w_ea_Dn                    EQU         $0140                ;match for ea,Dn word size
match_ADD_l_ea_Dn                    EQU         $0180                ;match for ea,Dn long size

match_ADD_b_Dn_ea                    EQU         $0000                ;match for Dn,ea byte size
match_ADD_w_Dn_ea                    EQU         $0040                ;match for Dn,ea word size
match_ADD_l_Dn_ea                    EQU         $0080                ;match for Dn,ea long size



match_ADD_Dn						EQU			$0000
match_ADD_An						EQU			$0008
match_ADD_An_indir				    EQU			$0010
match_ADD_An_indir_predec			EQU			$0020
match_ADD_An_indir_postinc			EQU			$0018
match_ADD_abs_add_word				EQU			$0038
match_ADD_abs_add_long				EQU			$0039

match_ADD_D0							EQU			$0000
match_ADD_D1							EQU			$0001
match_ADD_D2							EQU			$0002
match_ADD_D3							EQU			$0003
match_ADD_D4							EQU			$0004
match_ADD_D5							EQU			$0005
match_ADD_D6							EQU			$0006
match_ADD_D7							EQU			$0007

match_ADD_A0							EQU			$0008
match_ADD_A1							EQU			$0009
match_ADD_A2							EQU			$000A
match_ADD_A3							EQU			$000B
match_ADD_A4							EQU			$000C
match_ADD_A5							EQU			$000D
match_ADD_A6							EQU			$000E
match_ADD_A7							EQU			$000F

match_ADD_An_indir_r0					EQU			$0010
match_ADD_An_indir_r1					EQU			$0011
match_ADD_An_indir_r2					EQU			$0012
match_ADD_An_indir_r3					EQU			$0013
match_ADD_An_indir_r4					EQU			$0014
match_ADD_An_indir_r5					EQU			$0015
match_ADD_An_indir_r6					EQU			$0016
match_ADD_An_indir_r7					EQU			$0017

match_ADD_An_indir_postinc_r0		EQU			$0018
match_ADD_An_indir_postinc_r1		EQU			$0019
match_ADD_An_indir_postinc_r2		EQU			$001A
match_ADD_An_indir_postinc_r3		EQU			$001B
match_ADD_An_indir_postinc_r4		EQU			$001C
match_ADD_An_indir_postinc_r5		EQU			$001D
match_ADD_An_indir_postinc_r6		EQU			$001E
match_ADD_An_indir_postinc_r7		EQU			$001F

match_ADD_An_indir_predec_reg0			EQU			$0020
match_ADD_An_indir_predec_reg1			EQU			$0021
match_ADD_An_indir_predec_reg2			EQU			$0022
match_ADD_An_indir_predec_reg3			EQU			$0023
match_ADD_An_indir_predec_reg4			EQU			$0024
match_ADD_An_indir_predec_reg5			EQU			$0025
match_ADD_An_indir_predec_reg6			EQU			$0026
match_ADD_An_indir_predec_reg7			EQU			$0027

match_imm_add                           EQU         $003C
match_imm_add_word                      EQU         $00FC
match_imm_add_long                      EQU         $01FC

match_ADD_reg0							EQU			$0000
match_ADD_reg1							EQU			$0200
match_ADD_reg2							EQU			$0400
match_ADD_reg3							EQU			$0600
match_ADD_reg4							EQU			$0800
match_ADD_reg5							EQU			$0A00
match_ADD_reg6							EQU			$0C00
match_ADD_reg7							EQU			$0E00











*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
