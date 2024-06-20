import java.io.IOException;
import java.net.URL;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Actor {
  private String id, name, role, image, summary, birthDate, deathDate, awards, height;
  private String[][] knownFor;
  private String[][] castMovies;
  
  public Actor(String id) {
    boolean isValid = true;
    final String key = "k_mcx0w8kk";
    String link = String.format("https://imdb-api.com/en/API/Name/%s/%s", key, id);
    JsonNode tree = null;
    try {
      URL search = new URL(link);
      ObjectMapper mapper = new ObjectMapper();
      tree = mapper.readTree(search);
    } catch (IOException ioe) {
      isValid = false;
    }
    
    // Check for valid information
    if (isValid) {
      this.id = tree.get("id").asText();
      name = tree.get("name").asText();
      role = tree.get("role").asText();
      image = tree.get("image").asText();
      summary = tree.get("summary").asText();
      birthDate = tree.get("birthDate").asText();
      deathDate = tree.get("deathDate").asText();
      awards = tree.get("awards").asText();
      height = tree.get("height").asText();
      
   // Known For
      JsonNode knowns = tree.get("knownFor");
      knownFor = new String[knowns.size()][5];
      for (int i = 0; i < knowns.size(); i++) {
        JsonNode known = knowns.get(i);
        knownFor[i][0] = known.get("id").asText();
        knownFor[i][1] = known.get("title").asText();
        knownFor[i][2] = known.get("year").asText();
        knownFor[i][3] = known.get("role").asText();
        knownFor[i][4] = known.get("image").asText();
        
      }
      
   // Cast Movies
      JsonNode movies = tree.get("castMovies");
      castMovies = new String[10][5];
      if (movies.size() < 10) {
        for (int i = 0; i < movies.size(); i++) {
          JsonNode movie = movies.get(i);
          castMovies[i][0] = movie.get("id").asText();
          castMovies[i][1] = movie.get("role").asText();
          castMovies[i][2] = movie.get("title").asText();
          castMovies[i][3] = movie.get("year").asText();
          castMovies[i][4] = movie.get("description").asText();
        }
      } else {
        for (int i = 0; i < 10; i++) {
          JsonNode movie = movies.get(i);
          castMovies[i][0] = movie.get("id").asText();
          castMovies[i][1] = movie.get("role").asText();
          castMovies[i][2] = movie.get("title").asText();
          castMovies[i][3] = movie.get("year").asText();
          castMovies[i][4] = movie.get("description").asText();
        }
      }
      
    }
  }
  
  public String getId() {
    return id;
  }
  
  public String getName() {
    return name;
  }
  
  public String getRole() {
    return role;
  }
  
  public String getImage() {
    return image;
  }
  
  public String getSummary() {
    return summary;
  }
  
  public String getBirthDate() {
    return birthDate;
  }
  
  public String getDeathDate() {
    return deathDate;
  }
  
  public String getAwards() {
    return awards;
  }
  
  public String getHeight() {
    return height;
  }
  
  public String[][] getKnownFor() {
    return knownFor;
  }
  
  public String[][] getCastMovies() {
    return castMovies;
  }
}
