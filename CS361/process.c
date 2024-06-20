// The contents of this file are up to you, but they should be related to
// running separate processes. It is recommended that you have functions
// for:
//   - performing a $PATH lookup
//   - determining if a command is a built-in or executable
//   - running a single command in a second process
//   - running a pair of commands that are connected with a pipe

#include <fcntl.h>
#include <spawn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

#include "builtins.h"

int
run (char *name, int *fd, int prev)
{
  int result = 0;
  char *cmdline = strdup (name);
  cmdline[strcspn (cmdline, "\n")] = 0;
  char *token = strtok (cmdline, " ");
  if (strcmp (token, "pwd") == 0)
    {
      result = pwd ();
    }
  else if (strcmp (token, "cd") == 0)
    {
      token = strtok (NULL, " ");
      result = cd (token);
    }
  else if (strcmp (token, "quit") == 0)
    {
      result = quit ();
    }
  else if (strcmp (token, "which") == 0)
    {
      result = which (name);
    }
  else if (strcmp (token, "export") == 0)
    {
      token = strtok (NULL, " ");
      result = export(token);
    }
  else if (strcmp (token, "unset") == 0)
    {
      result = unset (name);
    }
  else if (strcmp (token, "echo") == 0)
    {
      result = echo (name);
      if (strstr (name, "?") != NULL)
        {
          printf ("%d\n", prev);
        }
    }
  else if (strstr (token, "cat") != NULL)
    {
      pid_t child = -1;
      const char *path = token;
      token = strtok (NULL, " ");
      char *const argv[] = { "cat", token, NULL };
      posix_spawn (&child, path, NULL, NULL, argv, NULL);
      wait (NULL);
    }
  else if (strstr (token, "env") != NULL)
    {
      int fd[2];
      pipe (fd);
      pid_t child = -1;
      const char *path = token;
      char *const argv[] = { "env", name, NULL };
      if (strstr (name, "|") != NULL)
        {
          posix_spawn_file_actions_t file_actions;
          posix_spawn_file_actions_init (&file_actions);
          posix_spawn_file_actions_addclose (&file_actions, STDOUT_FILENO);
          posix_spawn_file_actions_adddup2 (&file_actions, fd[1],
                                            STDOUT_FILENO);

          posix_spawn (&child, path, &file_actions, NULL, argv, NULL);
          wait (NULL);

          posix_spawn_file_actions_destroy (&file_actions);

          char *buffer = "\n";
          write (fd[1], buffer, strlen (buffer));

          char *str = strstr (name, "|");
          char *cmd2 = strdup (str);
          char *token2 = strtok (cmd2, " ");
          token2 = strtok (NULL, " ");
          token2 = strtok (NULL, " ");

          pid_t child2 = -1;
          const char *path2 = "./bin/head";
          char *flags2 = token2;
          token2 = strtok (NULL, " ");
          char *val = token2;
          char *const argv2[] = { "head", flags2, val, NULL, NULL };

          posix_spawn_file_actions_t file_actions2;
          posix_spawn_file_actions_init (&file_actions2);
          posix_spawn_file_actions_addclose (&file_actions, fd[1]);
          posix_spawn_file_actions_adddup2 (&file_actions2, fd[0],
                                            STDIN_FILENO);

          posix_spawn (&child2, path2, &file_actions2, NULL, argv2, NULL);
          wait (NULL);

          posix_spawn_file_actions_destroy (&file_actions2);
          free (cmd2);
        }
      else
        {
          posix_spawn (&child, path, NULL, NULL, argv, NULL);
          wait (NULL);
        }
    }
  else if (strstr (token, "head") != NULL)
    {
      pid_t child = -1;
      const char *path = token;
      token = strtok (NULL, " ");
      char *flags = token;
      token = strtok (NULL, " ");
      char *val = token;
      token = strtok (NULL, " ");
      char *const argv[] = { "head", flags, val, token, NULL };
      posix_spawn (&child, path, NULL, NULL, argv, NULL);
      wait (NULL);
    }
  else if (strstr (token, "ls") != NULL)
    {
      int fd[2];
      pipe (fd);
      pid_t child = -1;
      const char *path = token;
      token = strtok (NULL, " ");
      char *flags = token;
      token = strtok (NULL, " ");
      char *const argv[] = { "ls", flags, token, NULL };
      if (strstr (name, "|") != NULL)
        {
          posix_spawn_file_actions_t file_actions;
          posix_spawn_file_actions_init (&file_actions);
          posix_spawn_file_actions_addclose (&file_actions, STDOUT_FILENO);
          posix_spawn_file_actions_adddup2 (&file_actions, fd[1],
                                            STDOUT_FILENO);

          posix_spawn (&child, path, &file_actions, NULL, argv, NULL);
          wait (NULL);

          posix_spawn_file_actions_destroy (&file_actions);

          char *buffer = "\n";
          write (fd[1], buffer, strlen (buffer));

          token = strtok (NULL, " ");
          token = strtok (NULL, " ");

          pid_t child2 = -1;
          const char *path2 = token;
          token = strtok (NULL, " ");
          char *flags2 = token;
          token = strtok (NULL, " ");
          char *val = token;
          token = strtok (NULL, " ");
          char *const argv2[] = { "head", flags2, val, token, NULL };

          posix_spawn_file_actions_t file_actions2;
          posix_spawn_file_actions_init (&file_actions2);
          posix_spawn_file_actions_addclose (&file_actions, fd[1]);
          posix_spawn_file_actions_adddup2 (&file_actions2, fd[0],
                                            STDIN_FILENO);

          posix_spawn (&child2, path2, &file_actions2, NULL, argv2, NULL);
          wait (NULL);

          posix_spawn_file_actions_destroy (&file_actions2);
        }
      else
        {
          posix_spawn (&child, path, NULL, NULL, argv, NULL);
          int wstatus;
          waitpid (-1, &wstatus, 0);
          result = WEXITSTATUS (wstatus);
        }
    }
  else if (strstr (token, "rm") != NULL)
    {
      pid_t child = -1;
      const char *path = token;
      token = strtok (NULL, " ");
      char *const argv[] = { "rm", token, NULL };
      posix_spawn (&child, path, NULL, NULL, argv, NULL);
      wait (NULL);
    }
  free (cmdline);
  fflush (stdout);
  return result;
}
