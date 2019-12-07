#include "stm32f4xx.h"
void printMsg(const int a,const int b,const int c,const int d)
{
	 char Msg[100];
	 char *ptr;
	switch (a) {
            case 7:
							sprintf(Msg, "\n AND %x ", a);
                break;
            case 6:
                sprintf(Msg, "\n OR %x   ", a);
                break;
            case 5:
                sprintf(Msg, "\n NOT %x ", a);
                break;
						case 4:
                sprintf(Msg, "\n  NAND %x", a);
						 break;
 						case 3:
                sprintf(Msg, "\n  NOR %x ", a);
						break;						
						case 2:
                sprintf(Msg, "\n  XOR %x ", a);
 						 break;
						case 1:
                sprintf(Msg, "\n XNOR %x ", a);  
					
						 
            
        }
	
	 
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
   
	 sprintf(Msg, "\n input1 = %x ", b);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
		 sprintf(Msg, " input2 = %x  ", c);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
		 sprintf(Msg, " input3 = %x  ",d);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
		
	 
}

