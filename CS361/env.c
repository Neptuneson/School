#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>


static void usage (void);

int
main (int argc, char *argv[], char *envp[])
{
  char *cmdline = strdup(argv[1]);
  cmdline[strcspn(cmdline, "\n")] = 0;
  char *token = strtok (cmdline, " ");
  while (token != NULL)
    {
      if (strstr(token, "=") != NULL)
        {
          printf("%s\n", token);
        }
      token = strtok (NULL, " ");
    }
  free(cmdline);
  return EXIT_SUCCESS;
}

static void __attribute__((unused))
usage (void)
{
  printf ("env, set environment variables and execute program\n");
  printf ("usage: env [name=value ...] PROG ARGS\n");
}

