#include "palmlibc.h"
#include <unistd.h>
 
void f2c_name(print)();
 
 
int C_MAIN_FOR_FORTRAN(int argc, char **argv, char **envp) {
      int il_err = 0; 
 
      il_err = PALM_Init(argc, argv,"main_print");
      f2c_name(print)();
      il_err += PALM_Finalize();
      return (0);
}
