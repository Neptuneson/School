import java.io.IOException;
import java.net.URL;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Class is for storing information about a specific movie.
 */
public class Movie {
  // ratings, wikipedia, posters, images, trailer all come up null for many different movies so not needed (can be re-implemented if necessary)
  // as well as originalTitle for most movies, full cast all will be omitted for now
  // type, full title as well as keywords is redundant for this scenario will also be ignored
  // awards for now
  private String id, title, year, image, releaseDate, runtimeMin, runtime, plot, awards, contentRating, imDbRating, imDbRatingVotes, metacriticRating, genres, languages, countries;
  private String directorList[][]; //id is first row and other information is columns
  private String writerList[][];
  private String starList[][];
  private String actorList[][];
  private String companyList[][];
  private String boxOffice[];
  private String similars[][];

  /**
   * Takes the Picked movies and does the full detailed search to create the object
   * @param id id of the movie
   * @throws IOException 
   */
  public Movie(String id) {
    boolean isValid = true;
    final String key = "k_mcx0w8kk";
    String link = String.format("https://imdb-api.com/en/API/Title/%s/%s", key, id);
    JsonNode tree = null;
    try {
      URL search = new URL(link);
      ObjectMapper mapper = new ObjectMapper();
      tree = mapper.readTree(search);
      isValid = !tree.hasNonNull("errorMessage");
    } catch (IOException ioe) {
      isValid = false;
    }
    
    // Check for valid information
    if (isValid) {
    
      //basic information
      this.id = tree.get("id").asText();
      title = tree.get("title").asText();
      year = tree.get("year").asText();
      image = tree.get("image").asText();
      releaseDate = tree.get("releaseDate").asText();
      runtimeMin = tree.get("runtimeMins").asText();
      runtime = tree.get("runtimeStr").asText();
      plot = tree.get("plot").asText();
      awards = tree.get("awards").asText();
      genres = tree.get("genres").asText();
      countries = tree.get("countries").asText();
      languages = tree.get("languages").asText();
      contentRating = tree.get("contentRating").asText();
      imDbRating = tree.get("imDbRating").asText();
      imDbRatingVotes = tree.get("imDbRatingVotes").asText();
      metacriticRating = tree.get("metacriticRating").asText();
      
      /**
       * Cast and Crew on Movie.
       */
      
      // Directors
      JsonNode directors = tree.get("directorList");
      directorList = new String[directors.size()][2];
      for (int i = 0; i < directors.size(); i++) {
        JsonNode director = directors.get(i);
        directorList[i][0] = director.get("id").asText();
        directorList[i][1] = director.get("name").asText();
      }
      
      // Writers
      JsonNode writers = tree.get("writerList");
      writerList = new String[writers.size()][2];
      for (int i = 0; i < writers.size(); i++) {
        JsonNode writer = writers.get(i);
        writerList[i][0] = writer.get("id").asText();
        writerList[i][1] = writer.get("name").asText();
      }
      
      // Stars
      JsonNode stars = tree.get("starList");
      starList = new String[stars.size()][2];
      for (int i = 0; i < stars.size(); i++) {
        JsonNode star = stars.get(i);
        starList[i][0] = star.get("id").asText();
        starList[i][1] = star.get("name").asText();
      }
      
      // Actors
      JsonNode actors = tree.get("actorList");
      actorList = new String[actors.size()][4];
      for (int i = 0; i < actors.size(); i++) {
        JsonNode actor = actors.get(i);
        actorList[i][0] = actor.get("id").asText();
        actorList[i][1] = actor.get("image").asText();
        actorList[i][2] = actor.get("name").asText();
        actorList[i][3] = actor.get("asCharacter").asText();
      }
      
      /**
       * Other information.
       */
      
      // Companies
      JsonNode companies = tree.get("companyList");
      companyList = new String[companies.size()][4];
      for (int i = 0; i < companies.size(); i++) {
        JsonNode company = companies.get(i);
        companyList[i][0] = company.get("id").asText();
        companyList[i][1] = company.get("name").asText();
      }
      
      // Box Office
      boxOffice = new String[4];
      boxOffice[0] = tree.get("boxOffice").get("budget").asText();
      boxOffice[1] = tree.get("boxOffice").get("openingWeekendUSA").asText();
      boxOffice[2] = tree.get("boxOffice").get("grossUSA").asText();
      boxOffice[3] = tree.get("boxOffice").get("cumulativeWorldwideGross").asText();
      
      // Similars
      JsonNode similarMovies = tree.get("similars");
      similars = new String[similarMovies.size()][4];
      for (int i = 0; i < similarMovies.size(); i++) {
        JsonNode similar = similarMovies.get(i);
        similars[i][0] = similar.get("id").asText();
        similars[i][1] = similar.get("title").asText();
        similars[i][2] = similar.get("image").asText();
        similars[i][3] = similar.get("imDbRating").asText();
      }
    }
  }

  // Getters
  // Some of these could be changed to just output information to GUI or to a change in String output formatting.
  // Depends on implementations.
  public String getId() {
    return id;
  }

  public String getTitle() {
    return title;
  }

  public String getYear() {
    return year;
  }

  public String getImage() {
    return image;
  }

  public String getReleaseDate() {
    return releaseDate;
  }

  public String getRunTime() {
    return String.format("%s (%smin)", runtime, runtimeMin);
  }

  public String getPlot() {
    return plot;
  }

  public String getAwards() {
    return awards;
  }

  public String getContentRating() {
    return contentRating;
  }

  public String getImDbRating() {
    return imDbRating;
  }

  public String getImDbRatingVotes() {
    return imDbRatingVotes;
  }

  public String getMetacriticRating() {
    return metacriticRating;
  }

  public String[][] getDirectors() {
    return directorList;
  }

  public String[][] getWriters() {
    return writerList;
  }

  public String[][] getStars() {
    return starList;
  }

  public String[][] getActors() {
    return actorList;
  }

  public String getGenres() {
    return genres;
  }

  public String[][] getCompanies() {
    return companyList;
  }

  public String getCountries() {
    return countries;
  }

  public String getLanguages() {
    return languages;
  }

  public String[] getBoxOffice() {
    return boxOffice;
  }

  public String[][] getSimilars() {
    return similars;
  }
}
