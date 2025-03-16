#include "lib.h"
#include <stdio.h>

int main(void) {
  char *msg = hello();
  printf("%s\n", msg);
  return 0;
}
