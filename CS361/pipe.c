#include <fcntl.h>
#include <spawn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

#include "pipe.h"

/* Given a writable string buffer, find the first space and replace it
   with a '\0', thus ending the string at that location. Sample call:

     char buffer[] = "hello world";
     char *result = split_string (buffer);
     // result points to buffer, which prints as "hello"
   */
char *
split_string (char *buffer)
{
  char *space = strchr (buffer, ' ');
  *space = '\0';
  return buffer;
}

/* Creates a child process. If this fails, close the pipe and return NULL.
   If the child is created, use it to run the cksum program on the filename
   passed. Send the result back through the pipe. The parent process should
   just return the child's PID. Sample call:

     int fd[2];
     pipe (fd);
     pid_t child_pid = create_cksum_child (fd, "foo.txt");
  */
pid_t
create_cksum_child (int *pipe, char *const filename)
{
  pid_t child = fork ();

  if (child == 0)
    {
      if (access (filename, F_OK) == 0)
        {
          dup2 (pipe[1], STDOUT_FILENO);
          execlp ("cksum", "cksum", filename, NULL);
        }
      else
        {
          char *buffer = " ";
          write (pipe[1], buffer, strlen (buffer));
        }
    }
  if (child == -1)
    {
      close (pipe[0]);
      close (pipe[1]);
    }
  return child;
}

/* Uses the cksum program on the input filename. Start by creating a pipe
   and calling create_cksum_child() to create the child process. If that
   fails, return NULL. Otherwise, implement the parent here so that it
   reads the result of the cksum calculation from the pipe and returns
   the result. Sample call:

     char *sum = get_cksum ("data/f1.txt");
     // sum is "3015617425 6 data/f1.txt\n" [with the newline]
   */
char *
get_cksum (char *const filename)
{
  int fd[2];
  pipe (fd);
  pid_t child_pid = create_cksum_child (fd, filename);
  if (child_pid > 0)
    {
      char *sum = (char *)calloc (100, sizeof (char));
      read (fd[0], sum, 100);
      return sum;
    }
  return NULL;
}

/* Re-implementation of the create_cksum_child() in pipe.c. Instead of
   using the calls to pipe/fork/dup2/exec, combine the latter three
   into a call to posix_spawn(). Sample call:

     char *sum = spawn_cksum ("data/f1.txt");
     // sum is "3015617425 6 data/f1.txt\n" [with the newline]
   */
char *
spawn_cksum (char *const filename)
{
  // Use these parameters to posix_spawn(). You will need to set up
  // the posix_spawn_file_actions_t by (1) initializing it, (2) adding
  // a close action, and (3) adding a dup2 action so that STDOUT writes
  // to a pipe. After spawning the new process, make sure to call
  // posix_spawn_file_actions_destroy() on the actions to prevent
  // memory leaks.
  int fd[2];
  pipe (fd);
  pid_t child = -1;
  posix_spawn_file_actions_t file_actions;
  const char *path = "/usr/bin/cksum";
  char *const argv[] = { "cksum", filename, NULL };

  if (access (filename, F_OK) == 0)
    {
      posix_spawn_file_actions_init (&file_actions);
      posix_spawn_file_actions_addclose (&file_actions, STDOUT_FILENO);
      posix_spawn_file_actions_adddup2 (&file_actions, fd[1], STDOUT_FILENO);

      posix_spawn (&child, path, &file_actions, NULL, argv, NULL);

      posix_spawn_file_actions_destroy (&file_actions);
    }
  else
    {
      char *buffer = " ";
      write (fd[1], buffer, strlen (buffer));
    }

  // Instead of using fork() and exec(), use the posix_spawn functions.
  // Note that you will need to add a close and dup2 action to the
  // set of file actions to run when spawning. You will also need to
  // create the pipe to use with the dup2 action.

  // Parent code: read the value back from the pipe into a dynamically
  // allocated buffer. Wait for the child to exit, then return the
  // buffer.
  wait (NULL);
  char *buffer = (char *)calloc (100, sizeof (char));
  read (fd[0], buffer, 100);
  return buffer;
}
