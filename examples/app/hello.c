#include <stdio.h>
#include <string.h>
#define __FILENAME__ (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)
int main(int argc, char *argv[]){
  printf("%s, %s, %d: hello!!\n", __FILENAME__, __FUNCTION__, __LINE__);
  return 0; 
}
