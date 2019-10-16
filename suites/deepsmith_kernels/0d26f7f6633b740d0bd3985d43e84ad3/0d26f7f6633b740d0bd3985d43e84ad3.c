void A(int *a, int* b, float c, char* d) { int f = *d;
    if (!f) {
      f = G(c, &d);
      if (!f)
        d = 0;
    }
  }