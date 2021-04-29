
int sum(int a, int b){
	return a+b;
}


void callcallback(){
	__attribute__((import_name("callfunc"))) void call(void);
	call();
}




