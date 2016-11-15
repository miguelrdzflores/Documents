#include "palmlibc.h"
#include <unistd.h>
 
void f2c_name(difusion)();
 
 
int C_MAIN_FOR_FORTRAN(int argc, char **argv, char **envp) {
      int il_err = 0; 
 
      il_err = PALM_Init(argc, argv,"main_difusion");
      f2c_name(difusion)();
      il_err += PALM_Finalize();
      return (0);
}
