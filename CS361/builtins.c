#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

#include "hash.h"

// Given a message as input, print it to the screen followed by a
// newline ('\n'). If the message contains the two-byte escape sequence
// "\\n", print a newline '\n' instead. No other escape sequence is
// allowed. If the sequence contains a '$', it must be an environment
// variable or the return code variable ("$?"). Environment variable
// names must be wrapped in curly braces (e.g., ${PATH}).
//
// Returns 0 for success, 1 for errors (invalid escape sequence or no
// curly braces around environment variables).
int
echo (char *message)
{
  int i = 5;
  while (message[i] != '\0')
    {
      if (message[i] == '\\')
        {
          if (message[i + 1] == 'n')
            {
              printf ("\n");
              i++;
            }
          else if (message[i + 1] == '\\')
            {
              printf ("\\n");
              i++;
            }
          else
            {
              return 1;
            }
        }
      else if (message[i] == '$')
        {
          if (message[i + 1] == '?')
            {
              return 0;
            }
          else if (message[i + 1] == '{')
            {
              char *var = strstr (message, "{");
              var++;
              var[strlen (var) - 2] = 0;
              if (hash_find (var) != NULL)
                {
                  char *val = hash_find (var);
                  printf ("%s\n", val);
                }
              else
                {
                  printf ("\n");
                }
              i = i + strlen (var) + 1;
            }
          else
            {
              return 1;
            }
        }
      else
        {
          printf ("%c", message[i]);
        }
      i++;
    }
  return 0;
}

// Given a key-value pair string (e.g., "alpha=beta"), insert the mapping
// into the global hash table (hash_insert ("alpha", "beta")).
//
// Returns 0 on success, 1 for an invalid pair string (kvpair is NULL or
// there is no '=' in the string).
int export(char *kvpair)
{
  if (kvpair == NULL || strstr (kvpair, "=") == NULL)
    return 1;
  char *kv = strdup (kvpair);
  char *key = strtok (kv, "=");
  char *val = strtok (NULL, "=");
  bool ins = hash_insert (key, val);
  free (kv);
  if (ins)
    return 0;
  return 1;
}

// Prints the current working directory (see getcwd()). Returns 0.
int
pwd (void)
{
  char wd[1000];
  getcwd (wd, sizeof (wd));
  printf ("%s\n", wd);
  return 0;
}

// Removes a key-value pair from the global hash table.
// Returns 0 on success, 1 if the key does not exist.
int
unset (char *key)
{
  bool del = hash_remove (key);
  if (del)
    return 0;
  return 1;
}

// Given a string of commands, find their location(s) in the $PATH global
// variable. If the string begins with "-a", print all locations, not just
// the first one.
//
// Returns 0 if at least one location is found, 1 if no commands were
// passed or no locations found.
int
which (char *cmdline)
{
  int result = 0;
  char *cmd = strdup (cmdline);
  cmd[strcspn (cmd, "\n")] = 0;
  char *token = strtok (cmd, " ");
  token = strtok (NULL, " ");
  if (strcmp (token, "pwd") == 0 || strcmp (token, "cd") == 0
      || strcmp (token, "quit") == 0 || strcmp (token, "which") == 0
      || strcmp (token, "export") == 0 || strcmp (token, "unset") == 0
      || strcmp (token, "echo") == 0)
    {
      printf ("%s: dukesh built-in command\n", token);
    }
  else if (token[0] == '.')
    {
      printf ("%s\n", token);
    }
  else
    {
      char wd[1000];
      getcwd (wd, sizeof (wd));

      DIR *dp = opendir (wd);
      struct dirent *de;
      while ((de = readdir (dp)))
        {
          if (de->d_type != 8) // Only print regular files
            continue;
          if (strcmp (de->d_name, token) == 0)
            printf ("%s/%s\n", wd, de->d_name);
        }
      closedir (dp);
    }
  free (cmd);
  return result;
}

// Change the current working directory.
int
cd (char *path)
{
  int result = chdir (path);
  return result;
}

// Quit the program.
int
quit (void)
{
  printf ("\n");
  exit (0);
}
