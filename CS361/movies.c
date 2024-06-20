#define _POSIX_C_SOURCE 200809L // needed for strdup extension

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "movies.h"

// Given a string (possibly read-only) of IMDB movie data
// (formatted as "Title,Rating,Runtime,Year,Genre,OscarNominated"),
// create a movie_t object based on the appropriate fields.
movie_t
split_data (char *csv)
{
  movie_t movie;
  char *csvf = strdup (csv);
  char *token = strtok (csvf, ",");
  movie.title = strdup (token); // copy the first token as the title

  // Use strtok() repeatedly to get each string one at a time and format
  // the data fields as follows:

  //   Use strtof() to parse the next token as a float for the rating
  token = strtok (NULL, ",");
  movie.rating = strtof (token, NULL);

  //   Use strtol() to get the next two tokens as runtime and year
  token = strtok (NULL, ",");
  movie.runtime = strtol (token, NULL, 0);
  token = strtok (NULL, ",");
  movie.year = strtol (token, NULL, 0);

  //   Copy the token as the movie's genre field
  token = strtok (NULL, ",");
  movie.genre = strdup (token);

  //   If the last token is equal to "true", set the nominated field to true
  token = strtok (NULL, ",");
  if (!strcmp (token, "true"))
    movie.nominated = true;
  free (csvf);
  return movie;
}

// Build a dynamically allocated string from a movie_t object as follows:
// "[Year] Title - Runtime minutes"
// Rather than allocating all of the space ahead of time, use realloc()
// to grow the string at different stages as needed.
char *
merge_data (movie_t movie)
{
  // Initially an empty string with just enough space for "[Year] " and
  // write the year into this space.
  char *result = calloc (8, sizeof (char *));
  snprintf (result, 8, "[%d] ", movie.year);

  // Now, use realloc() to grow the string with enough space for the
  // title, then copy the title into the new space.
  result = realloc (result, (strlen (result) + strlen (movie.title) + 2)
                                * sizeof (char *));
  snprintf (result + 7, strlen (movie.title) + 2, "%s ", movie.title);

  // Finally, allocate enough space for the rest of the line and write
  // it in using snprintf(). You may assume the runtime is at most 3 characters
  // long.
  result = realloc (result, (strlen (result) + 14) * sizeof (char *));
  snprintf (result + strlen (result), 14, "- %d minutes", movie.runtime);
  return result;
}
