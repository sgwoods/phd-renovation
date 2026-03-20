int h() {};

typedef struct {
	int a;
	int (*g)();
} A;

A x = { 1,	h };

int f() {
	x.g();
}

main() {
	f();
}

