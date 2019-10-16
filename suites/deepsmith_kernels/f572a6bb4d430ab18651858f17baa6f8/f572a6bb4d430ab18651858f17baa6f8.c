void A(int *a, int* b, float c, char* d) {    B(a, b[0], a[0] & ~b[0] ^ b[12]);
      *b = b[1];
    }