#include "stm32f4xx.h"
#include <string.h>
void PrintSigmoid(const int a)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "%x\n", a);
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   } 
}