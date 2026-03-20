int h() {};

typedef struct {
	int a;
	int (*g)();
} A;

A x = { 1,	h };

f() {
	x.g();
}

main() {
	f();
}

