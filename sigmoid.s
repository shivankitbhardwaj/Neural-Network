; sigmoid function
     AREA    sigmoid,CODE,READONLY
     EXPORT __main
	 IMPORT PrintSigmoid	 
     ENTRY
__main  FUNCTION
; IGNORE THIS PART

         VLDR.F32 S8,=-5 ; initialising x value(intermediatte)
	  	 VLDR.F32 S9,=5; max value of x
         VLDR.F32 S10,=1; x increment
SIGMOID  VMOV.F32 S2,S8 ; updating the x value
		 BL SR
		 VADD.F32 S11,S0,S10 ;  1+e^x
		 VDIV.F32 S12,S0,S11 ;  e^x/(1+e^x)
		 VMOV.F32 R0,S12 ; for display purpose
		 BL PrintSigmoid
	  	 VCMP.F32 S8, S9
	  	 vmrs APSR_nzcv, FPSCR
	  	 BEQ stop
	  	 VADD.F32 S8, S8, S10
	  	 B SIGMOID
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