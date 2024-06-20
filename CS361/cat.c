#include <stdio.h>
#include <stdlib.h>

static void usage (void);

int
main (int argc, char *argv[])
{
  FILE *fptr;
  fptr = fopen(argv[1], "r");
  if(!fptr || argc != 2)
    {
      usage();
      return EXIT_FAILURE;
    }
  char ch;
  while((ch = fgetc(fptr)) != EOF)
    {
      printf("%c", ch);
    }
  fclose(fptr);
  return EXIT_SUCCESS;
}

static void
usage (void)
{
  printf ("cat, print the contents of a file\n");
  printf ("usage: cat FILE\n");
}
