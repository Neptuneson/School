#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <dirent.h>
#include <stdbool.h>
#include <getopt.h>
#include <string.h>

// You may assume that lines are no longer than 1024 bytes
#define LINELEN 1024

static void usage (void);

int
main (int argc, char *argv[])
{
  int n = 5;
  char *optionStr = "+n:";
  int opt;
  while((opt = getopt(argc, argv, optionStr))  != -1)
    {
      switch (opt)
        {
            case 'n':
              n = atoi(optarg);
              break;
            default:
              return EXIT_FAILURE;
              break;
        }
    }
    if (n > 5)
      n = 5;
  FILE *f;

  if (optind != argc - 1)
    {
      char line[LINELEN];
      while(fgets(line, sizeof (line), stdin))
        {
          if (n == 0)
            {
              break;
            }
          printf("%s", line);
          n--;
        }
    }
  else
    {
      f = fopen (argv[optind], "r");
      if(!f)
        {
          return EXIT_FAILURE;
        }
      char line[LINELEN];
      while(fgets(line, sizeof(line), f))
        {
          if (n == 0)
            {
              break;
            }
          printf("%s", line);
          n--;
        }    
    }
  return EXIT_SUCCESS;
}

static void __attribute__((unused))
usage (void)
{
  printf ("head, prints the first few lines of a file\n");
  printf ("usage: head [FLAG] FILE\n");
  printf ("FLAG can be:\n");
  printf ("  -n N     show the first N lines (default 5)\n");
  printf ("If no FILE specified, read from STDIN\n");
}
