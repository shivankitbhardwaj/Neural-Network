#include "stm32f4xx.h"
#include <string.h>
void PrintMsg(const int a, const int b, const int c, const int d)
{
	 char Msg[100];
	 char *ptr;

if (a<=4)	
	 sprintf(Msg, "You have selected dataset number %x\n", a);
else 
	sprintf(Msg, "You have selected an invalid dataset number\n");
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }

if (b==1)	
	 sprintf(Msg, "You have selected NAND logic %x", b);
else if (b==2) 
	sprintf(Msg, "You have selected NOR logic %x", b);
else if (b==3) 
	sprintf(Msg, "You have selected AND logic %x", b);
else if (b==4) 
	sprintf(Msg, "You have selected OR logic %x", b);
else if (b==5) 
	sprintf(Msg, "You have selected XOR logic %x", b);
else if (b==6) 
	sprintf(Msg, "You have selected XNOR logic %x", b);
else if (b==7) 
	sprintf(Msg, "You have selected NOT logic %x", b);
else 
	sprintf(Msg, "You have selected an invalid logic");
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }		 
if ((a>4) || (b>4))
	 sprintf(Msg, "\nFinal value can not be found due to invalid selection");
else sprintf(Msg, "\nFinal value is %x", c);
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }	
if ((a>4) || (b>4))
	sprintf(Msg, "\nTraining data value can not be found due to invalid selection");
else sprintf(Msg, "\nTraining data value is %d", d);
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }	 
	 
}