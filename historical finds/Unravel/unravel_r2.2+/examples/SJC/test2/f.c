int h() {
};

typedef struct A {
	int a;
	int (*g)();
};

A x = { 1,
	h
};


f() {
	x.g();
}

