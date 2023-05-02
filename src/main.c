// Make use of Amiga dos.library, ideally this should just be an include,
// but for now it is an include and a pragma.
#include <proto/dos.h>
#include <proto/exec.h>

int main () {
  PutStr((CONST_STRPTR)"Hello World!\n");
  return 0;
}
