void A(int *a, int* b, float c, char* d) {    B(a, &b, &d);
      *b = d;
    }