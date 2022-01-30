// Make use of Amiga dos.library, ideally this should just be an include,
// but for now it is an include and a pragma.
#include <clib/dos_protos.h>
#pragma amiga library dos

int main () {
  PutStr((CONST_STRPTR)"Hello World!\n");
  return 0;
}
