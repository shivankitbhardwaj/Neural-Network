; Neural network
     AREA    neural,CODE,READONLY
     EXPORT __main
	 IMPORT PrintMsg	 
     ENTRY
__main  FUNCTION
; IGNORE THIS PART
; select dataset logic
	      MOV R8, #2 ; dataset selection
		  MOV R1, #1 ; dataset 1
		  MOV R2, #2 ; dataset 2
		  MOV R3, #3 ; dataset 3
		  MOV R4, #4 ; dataset 4
		  
		 CMP R8,R1 ; for dataset 1 
		 BEQ dset1
		 
		 CMP R8,R2 ; for dataset 2
		 BEQ dset2
		 
		 CMP R8,R3 ; for dataset 3
		 BEQ dset3
		 
		 CMP R8,R4 ; for dataset 4
		 BEQ dset4
		 

; dataset 1
dset1	  VLDR.F32 s0 , =1 ;X0 DATA
          VLDR.F32 s1 , =0 ;X1 DATA
          VLDR.F32 s2 , =0 ;X2 DATA	
		  VLDR.F32 s15 , =0 ;initialising sum of weights	
		  b lsel

; dataset 2
dset2     VLDR.F32 s0 , =1 ;X0 DATA
          VLDR.F32 s1 , =0 ;X1 DATA
          VLDR.F32 s2 , =1 ;X2 DATA	
		  VLDR.F32 s15 , =0 ;initialising sum of weights	
		  b lsel
		  
; dataset 3
dset3	  VLDR.F32 s0 , =1 ;X0 DATA
          VLDR.F32 s1 , =1 ;X1 DATA
          VLDR.F32 s2 , =0 ;X2 DATA	
		  VLDR.F32 s15 , =0 ;initialising sum of weights	
		  b lsel		  

; dataset 4
dset4	  VLDR.F32 s0 , =1 ;X0 DATA
          VLDR.F32 s1 , =1 ;X1 DATA
          VLDR.F32 s2 , =1 ;X2 DATA	
		  VLDR.F32 s15 , =0 ;initialising sum of weights	
		  b lsel
		  
;switch case logic

lsel	  MOV R9, #4 ; logic selection
		  MOV R1, #1 ; NAND_LOGIC
		  MOV R2, #2 ; NOR_LOGIC
		  MOV R3, #3 ; AND_LOGIC
		  MOV R4, #4 ; OR_LOGIC
		  MOV R5, #5 ; XOR_LOGIC
		  MOV R6, #6 ; XNOR_LOGIC
		  MOV R7, #7 ; NOT_LOGIC
		  
		 CMP R9,R1 ; NAND 
		 BEQ NAND_LOGIC
		 
		 CMP R9,R2 ; NOR
		 BEQ NOR_LOGIC
		 
		 CMP R9,R3 ; AND
		 BEQ AND_LOGIC
		 
		 CMP R9,R4 ; OR
		 BEQ OR_LOGIC
		 
		 CMP R9,R5 ; XOR
		 BEQ XOR_LOGIC
		 
		 CMP R9,R6 ; XNOR 
		 BEQ XNOR_LOGIC
		 
		 CMP R9,R7 ; NOT
		 BEQ NOT_LOGIC
		 
		 
NAND_LOGIC         VLDR.F32 s28 ,=0.6 	;WEIGHT W1   
		           VLDR.F32 s29 ,=-0.8  ;WEIGHT W2   
                   VLDR.F32	s30 ,=-0.8 	;WEIGHT W3
                   VLDR.F32 s31 ,=0.3   ;BIAS   
                   B  X_CALCULATION


NOR_LOGIC          VLDR.F32 s28 ,=0.5 	;WEIGHT W1   
		           VLDR.F32 s29 ,=-0.7  ;WEIGHT W2   
                   VLDR.F32	s30 ,=-0.7 	;WEIGHT W3
                   VLDR.F32 s31 ,=0.1   ;BIAS   
                   B  X_CALCULATION

AND_LOGIC         VLDR.F32 s28 ,=-0.1 	;WEIGHT W1   
		          VLDR.F32 s29 ,=0.2  ;WEIGHT W2   
                  VLDR.F32	s30 ,=0.2 	;WEIGHT W3
                  VLDR.F32 s31 ,=-0.2   ;BIAS   
                   B  X_CALCULATION

OR_LOGIC          VLDR.F32 s28 ,=-0.1	;WEIGHT W1   
		          VLDR.F32 s29 ,=0.7  ;WEIGHT W2   
                  VLDR.F32	s30 ,=0.7 	;WEIGHT W3
                  VLDR.F32 s31 ,=-0.1  ;BIAS				  
                   B  X_CALCULATION

XOR_LOGIC         VLDR.F32 s28 ,=-5 	;WEIGHT W1   
		          VLDR.F32 s29 ,=20  ;WEIGHT W2   
                  VLDR.F32	s30 ,=10 	;WEIGHT W3
                  VLDR.F32 s31 ,=1   ;BIAS   
                   B  X_CALCULATION

XNOR_LOGIC        VLDR.F32 s28 ,=-5 	;WEIGHT W1   
		          VLDR.F32 s29 ,=20  ;WEIGHT W2   
                  VLDR.F32	s30 ,=10 	;WEIGHT W3
                  VLDR.F32 s31 ,=1   ;BIAS   
                   B  X_CALCULATION

NOT_LOGIC         VLDR.F32 s2 , =0
                  VLDR.F32 s28 ,=0.5 	;WEIGHT W1   
		          VLDR.F32 s29 ,=-0.7  ;WEIGHT W2   
                  VLDR.F32	s30 ,=0 	;WEIGHT W3
                  VLDR.F32 s31 ,=0.1   ;BIAS   
                   B  X_CALCULATION
		  
X_CALCULATION		  VMUL.F32  s14 , s0 ,s28  ;S15 WILL HAVE SUM OF WEIGHTS
                      VADD.F32  s15  , s15 ,s14
		              VMUL.F32  s14 , s1 ,s29  
					  VADD.F32  s15  , s15 ,s14
					  VMUL.F32  s14 , s2 ,s30
					  VADD.F32  s15  , s15 ,s14
                      VADD.F32  s15 , s15,s31
                      B SIGMOID					  
					  
SIGMOID	 VLDR.F32 S10,=1; x increment
		 VMOV.F32 S2,S15 ; updating the x value
		 BL SR
		 VADD.F32 S11,S0,S10 ;  1+e^x
		 VDIV.F32 S12,S0,S11 ;  e^x/(1+e^x)
		 VMOV.F32 R2,S12 ; for display purpose
		 VLDR.F32 S10,=0.5 ; sigmoid reference
		 VMOV.F32 R4,S10
		 MOV R0,R8 ; dataset selection display
		 MOV R1,R9 ; logic selection display
		 CMP R2,R4
         MOVGE R3, #1
		 MOVLT R3, #0
		 BL PrintMsg
stop     B stop;else goto stop		
		
		
SR      MOV R0,0xA ; iteration value for expression expansion
        MOV R1,#1; counting Variable 'i'
        VLDR.F32 S0,=1;Holding the final value of sum of series elements 's' (e^x)
        VLDR.F32 S1,=1;Temp Variable to hold the intermediate series elements 't'
		
LOOP1   CMP R1,R0;Compare 'i' and 'n'
        BLE LOOP;if i < n goto LOOP
		BX lr

LOOP    VMUL.F32 S1,S1,S2; t = t*x
        B fact ;calculte the factorial value of counting variable stored in R1(i) which further will used in denominator of expression
facm    VMOV.F32 S5,R7;Moving the value of i! in R7 = R1!('i!') to S5(floating point register)
        VCVT.F32.U32 S5,S5;Converting the value present in R7(i!) into unsigned fp Number 32 bit
        VDIV.F32 S3,S1,S5;Divide t by 'i!' and store it into new temperory variable s3
        VADD.F32 S0,S0,S3;Finally add 's' to 'S3' and store it in 's'
        ADD R1,R1,#1;Increment the counter variable 'i'
        B LOOP1;Again goto comparision

 ; factorial program to find the factorial of counting variable 'i' 
fact	MOV r7,#1 ; if n = 0, at least 'i!' = 1
        MOV R6,R1 ; move value of R1('i') to R6 ('n') to store intermediate values during operation
loop2   CMP r6, #0 ; compare the value of n to zero
        MULGT r7, r6, r7 ; if i!=0
        SUBGT r6, r6, #1 ; decrement 'n'
        BGT loop2 ; do another mul if counter!= 0
        B facm ; pass the final factorial value when n=0

        endfunc
        end