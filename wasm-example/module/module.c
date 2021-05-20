#include <stdio.h>
#include <stdlib.h>


int sum(int a, int b){
	printf("%d\n",a+b);
	return a+b;
}

__attribute__((import_name("callfunc"))) void call(void);
void callcallback(){
	call();
}
