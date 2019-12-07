     AREA    exponential,CODE,READONLY
     IMPORT printMsg
	 IMPORT print1	 
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
		;MOV R4,#1 ;for logic initial;AND LOGIC VALUE
		MOV R12,#7 ;for logic increase
		
		MOV R5,#6 ;for logic or
		MOV R6,#5 ;for logic not
		MOV R7,#4 ;for logic nand 
		MOV R8,#3;for logic nor 
		MOV R9,#2 ;for logic xor
		MOV R10,#1 ;for logic xnor 

		MOV R11,#7;for dataset selection		
		MOV R3,#7;for dataset selection	
		B logic_and

			 
;LOOP_A  	    CMP R4,R5
;				BEQ logic_or
		


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;logics to select;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

logic_and          ;weights w0 w1 w2
				   VLDR.F32 s3 ,=-0.1 	;w0
		           VLDR.F32 s4 ,=0.2    ;w1   
                   VLDR.F32	s15 ,=0.2 	;w2
				   ;Bias
                   VLDR.F32 s6 ,=-0.2;  bias  
                   B  dataset


logic_or           ;weights w0 w1 w2
				   VLDR.F32 s3 ,=-0.1 	;w0
		           VLDR.F32 s4 ,=0.7    ;w1   
                   VLDR.F32	s15 ,=0.7 	;w2
				   ;Bias
                   VLDR.F32 s6 ,=-0.1;  bias
                  B  dataset
			
logic_not          ;weights w0 w1 w2
				   VLDR.F32 s3 ,=0.5 	;w0
		           VLDR.F32 s4 ,=-0.7   ;w1   
		           VLDR.F32 s15 ,=0   ;w1   
		   		   ;Bias
                  VLDR.F32 s6 ,=0.1;   bias 
                  B  dataset


logic_nand         ;weights w0 w1 w2
				   VLDR.F32 s3 ,=0.6 	;w0
		           VLDR.F32 s4 ,=-0.8   ;w1   
                   VLDR.F32	s15 ,=-0.8 	;w2
				   ;Bias
                   VLDR.F32 s6 ,=0.3;   bias   
                   B  dataset
				   
				   
logic_nor          ;weights w0 w1 w2
				   VLDR.F32 s3 ,=0.5 	;w0
		           VLDR.F32 s4 ,=-0.7   ;w1   
                   VLDR.F32	s15 ,=-0.7 	;w2
				   ;Bias
                   VLDR.F32 s6 ,=0.1;   bias   
                   B  calculation

logic_xor          ;weights w0 w1 w2
				   VLDR.F32 s3 ,=-5 	;w0
		           VLDR.F32 s4 ,=20     ;w1   
                   VLDR.F32	s15 ,=10 	;w2
				   ;Bias
                  VLDR.F32 s6 ,=1;   bias   
                   B  dataset

logic_xnor         ;weights w0 w1 w2
				   VLDR.F32 s3 ,=-5 	;w0
		           VLDR.F32 s4 ,=20     ;w1   
                   VLDR.F32	s15 ,=10 	;w2
				   ;Bias
                   VLDR.F32 s6 ,=1;   bias   
                   B  dataset

;;;;;;;;;;;;;;;;;;;DATA SET SELECTION ;;;;;;;;;;;;;;;;;;;;;;;;

dataset CMP R3,R11
		BEQ set_1 

       ; CMP R11,R5
		;BEQ set_2 
		
        ;CMP R11,R6
		;BEQ set_3 
		
        ;CMP R11,R7
		;BEQ set_4 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;dataset selection;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

set_1   VLDR.F32 s0 , =1 ;data 1 (x1)
        VLDR.F32 s1 , =0 ;data 2 (x2)
        VLDR.F32 s2 , =0 ;data 3 (x3)	
		B calculation
		
set_2	VLDR.F32 s0 , =1 ;data 1 (x1)
        VLDR.F32 s1 , =0 ;data 2 (x2)
        VLDR.F32 s2 , =1 ;data 3 (x3)
		B calculation
	
	
set_3	VLDR.F32 s0 , =1 ;data 1 (x1)
        VLDR.F32 s1 , =1 ;data 2 (x2)
        VLDR.F32 s2 , =0 ;data 3 (x3)
		B calculation


set_4	VLDR.F32 s0 , =1 ;data 1 (x1)
        VLDR.F32 s1 , =1 ;data 2 (x2)
        VLDR.F32 s2 , =1 ;data 3 (x3)
		B calculation
		
		
calculation       ;z=wo.x0 + w1.x1 + w2.x2
				  VMUL.F32 s7,s0,s3   ;w0.x0
				  VMUL.F32 s8,s1,s4   ;w1.x1
				  VMUL.F32 s19,s2,s15   ;w2.x2
				  VADD.F32 s18,s7,s8   ;w0.x0 + w1.x1
				  VADD.F32 s20,s18,s19   ;z = w0.x0 + w1.x1 + w2.x2 ;Z is stored in s9
				  VADD.F32 s22,s6,s20   ;z = w0.x0 + w1.x1 + w2.x2 + bias;Z is stored in s9
   			     ;VADD.F32 s22,s22,s21   ;z = w0.x0 + w1.x1 + w2.x2 + bias;Z is stored in s9
  				  B exp11

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

exp11           MOV R2,#10 ;   number of times the loop runs ,the value 'n'
	            MOV R1,#1;initial value from which the loop starts 'i'
				VLDR.F32 S10,=1;Holding the sum of series elements 's'
				VLDR.F32 S11,=1;Temp Variable to hold the intermediate series elements 't'
				;VLDR.F32 s22,=0   ;
				B exp1


exp1    		;VMOV.F32 S9,R9;Moving the bit stream in R1('i') to S5(floating point register)
				CMP R1,R2;Compare 'i' and 'n' 
				BLE exp;if i < n goto LOOP
				B Sigmoid

exp				VMUL.F32 S11,S11,S22;t = t*x
				VMOV.F32 S5,R2;Moving the bit stream in R1('i') to S5(floating point register)
				VCVT.F32.U32 S5, S5;Converting the bitstream into unsigned fp Number 32 bit
 				VDIV.F32 S11,S11,S5;Divide t by 'i' and store it back in 't'
				VADD.F32 S11,S10,S11;Finally add 's' to 't' and store it in 's'
				SUB R2,R2,#1;Increment the counter variable 'i'
				B exp1;Again goto comparision	

Sigmoid  		VLDR.F32 S12,=1
				VDIV.F32 S11,S12,S11
				VADD.F32 S13,S11,S12
				VDIV.F32 S14,S12,S13
				
				;;;;;;;;;;;;;;;;;;;;;;;;;;;
				MOV R0,R12	
				VCVT.S32.F32 s0,s0
				VCVT.S32.F32 s1,s1	
				VCVT.S32.F32 s2,s2				
				VMOV.F32 R1,s0
				VMOV.F32 R2,s1
				VMOV.F32 R3,s2
				BL printMsg
				;;;;;;;;;;;;;;;;;;;;;;
				;VCVT.S32.F32 S14,S14				
				VMOV.F32 R5,S14
				VLDR.F32 S31,=0.5
				
				;VCVT.S32.F32 S31,S31
				VMOV.F32 R6,S31;
				CMP R5,R6
				ITE LT
				MOVLT R0,#0
				MOVGE R0,#1
				;MOV R0,R8
				BL print1
				;;;;;;;;;;;;;;;;;;;;;;;;;

				
				MOV R5,#6 ;
				MOV R6,#5 ;
				MOV R7,#4 ;				
				MOV R8,#3;
				MOV R9,#2 ;
				MOV R10,#1 ; 
				
				
				SUB R11,R11,#1
				
				CMP R11,R5
				BEQ set_2 
		
				CMP R11,R6
				BEQ set_3 
		
				CMP R11,R7
				BEQ set_4 
				
				B loop_logic
				
loop_logic		SUB R12,R12,#1
				
				MOV R11,#7 ; 				
				CMP R12,R5
				BEQ logic_or
				
				CMP R12,R6
				BEQ logic_not
		
				CMP R12,R7
				BEQ logic_nand
		
				CMP R12,R8
				BEQ logic_nor
		
				CMP R12,R9
				BEQ logic_xor
		
				CMP R12,R10
				BEQ logic_xnor	
				
stop       B   stop		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        endfunc
      end				  
				  
