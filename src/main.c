#include <clib/dos_protos.h>

#pragma amiga library dos

int main () {
  PutStr((CONST_STRPTR)"Hello World!\n");
  return 0;
}
