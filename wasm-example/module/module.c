//#include <stdio.h>
//#include <stdlib.h>


int sum(int a, int b){
	return a+b;
}

__attribute__((import_name("call"))) void call(void);
void callfunc(){
	call();
}
