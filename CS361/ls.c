#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <dirent.h>
#include <stdbool.h>
#include <getopt.h>
#include <string.h>
#include <sys/stat.h>

static void usage (void);

int
main (int argc, char *argv[])
{
  bool all = false;
  bool sizes = false;
  char *optionStr = "+as";
  int opt;
  while((opt = getopt(argc, argv, optionStr))  != -1)
    {
      switch (opt)
        {
            case 'a':
              all = true;
              break;
            case 's':
              sizes = true;
              break;
            default:
              return EXIT_FAILURE;
              break;
        }
    }

  if (optind == argc - 1)
    {
      char *wd;
      wd = argv[optind];

      struct stat path_stat;
      stat(wd, &path_stat);
      if (S_ISDIR(path_stat.st_mode) == 0)
        {
          return EXIT_FAILURE;
        }

      DIR* dp = opendir(wd);
      struct dirent* de;

      if (all)
        {
          if (sizes)
            {
              struct stat st;
              stat(wd, &st);
              printf("%ld .\n", st.st_size);

              char parent[200];
              snprintf(parent, sizeof(parent), "%s/..", wd);
              stat(wd, &st);
              printf("%ld ..\n", st.st_size);
            }
          else
            {
              printf(".\n");
              printf("..\n");
            }
        }
      while ((de = readdir(dp)))
        { 
          if (de->d_type != 8)
            continue;
          if (all || de->d_name[0] != '.')
            {
            if (sizes)
              {
                struct stat st;
                char *path = malloc(strlen(wd) + strlen(de->d_name) + 2);
                strcat(strcat(strcat(path, wd), "/"), de->d_name);
                stat(path, &st);
                printf("%ld %s\n", st.st_size, de->d_name);
              }
            else
              {
                printf("%s\n", de->d_name);
              }
            }
        }
      closedir(dp);
    }
  else
    {
      char wd[1000];
      getcwd(wd, sizeof(wd));
      DIR* dp = opendir(wd);
      struct dirent* de;
      while ((de = readdir(dp)))
        { 
          if (de->d_type != 8)
            continue;
          if (all || de->d_name[0] != '.')
            {
            if (sizes)
              {
                printf("%d %s\n", de->d_reclen, de->d_name);
              }
            else
              {
                printf("%s\n", de->d_name);
              }
            }
        }
      closedir(dp);
    }
  return EXIT_SUCCESS;
}

static void __attribute__((unused))
usage (void)
{
  printf ("ls, list directory contents\n");
  printf ("usage: ls [FLAG ...] [DIR]\n");
  printf ("FLAG is one or more of:\n");
  printf ("  -a       list all files (even hidden ones)\n");
  printf ("  -s       list file sizes\n");
  printf ("If no DIR specified, list current directory contents\n");
}
