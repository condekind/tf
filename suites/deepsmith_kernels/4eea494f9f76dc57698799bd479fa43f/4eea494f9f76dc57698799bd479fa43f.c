void A(int *a, int* b, float c, char* d) {      B(b, *a);
          *b++ = 1;
          if (a)
            C(b, 2, d);
          return;
      }