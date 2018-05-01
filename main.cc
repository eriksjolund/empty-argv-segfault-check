#include <cstdlib>
#include <unistd.h>

int main(int argc, char* argv[]) {
  if (argc != 2) {
    return EXIT_FAILURE;
  }
  char* arr[] = {nullptr};
  execv(argv[1], arr);
}
