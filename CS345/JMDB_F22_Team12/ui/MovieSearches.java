import java.io.IOException;
import java.net.URL;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class MovieSearches
{

  /*
   * Creates an array of search Results based on a search by movie title.
   *
   * @param titleToSearch the title
   * @return the array of results
   */
  protected static Result[] getMoviesFromTitle(String titleToSearch)
  {
    String link = String.format("https://imdb-api.com/en/API/SearchMovie/%s/%s", MovieDisplay.KEY,
        titleToSearch); // Specific search link for searching the title of a movie.
    JsonNode tree = null;
    try
    {
      URL search = new URL(link);
      ObjectMapper mapper = new ObjectMapper();
      tree = mapper.readTree(search); // Uses the url link to create a json tree of movies.
    }
    catch (IOException ioe)
    {

    }
    return fillTree(tree, MovieDisplay.RESULT_SIZE);
  }

  /*
   * Creates an array of search Results based on a search by actor name.
   *
   * @param nameToSearch the name
   * @return the array of results
   */
  protected static Result[] getActorsFromName(String nameToSearch)
  {

    String link = String.format("https://imdb-api.com/en/API/SearchName/%s/%s", MovieDisplay.KEY, nameToSearch);
    // Specific search link for searching the title of a movie.
    JsonNode tree = null;
    try
    {
      URL search = new URL(link);
      ObjectMapper mapper = new ObjectMapper();
      tree = mapper.readTree(search); // Uses the url link to create a json tree of movies.
    }
    catch (IOException ioe)
    {

    }
    return fillTree(tree, MovieDisplay.RESULT_SIZE);
  }

  /*
   * Creates an array of search Results based on a search by company name.
   *
   * @param nameToSearch the name
   * @return the array of results
   */
  protected static Result[] getCompaniesFromName(String companyName)
  {
    String link = String.format("https://imdb-api.com/en/API/SearchCompany/%s/%s", MovieDisplay.KEY,
        companyName); // Specific search link for searching the title of a movie.
    JsonNode tree = null;
    try
    {
      URL search = new URL(link);
      ObjectMapper mapper = new ObjectMapper();
      tree = mapper.readTree(search); // Uses the url link to create a json tree of movies.
    }
    catch (IOException ioe)
    {

    }
    return fillTree(tree, MovieDisplay.RESULT_SIZE);
  }

  protected static Result[] fillTree(JsonNode tree, int size)
  {
    Result[] results = new Result[size];
    if (tree == null) {
      return results;
    }
    String id = "";
    String title = "";
    String imageLink = "";
    String description = "";
    for (int i = 0; i < size; i++)
    {
      try {
      id = tree.get("results").get(i).get("id").asText();
        title = tree.get("results").get(i).get("title").asText();
        imageLink = tree.get("results").get(i).get("image").asText();
        description = tree.get("results").get(i).get("description").asText();
        results[i] = new Result(id, title, imageLink, description);      
      } catch (NullPointerException e) {
        results[i] = null;
      }
      
    }
    return results;
  }

}
