import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class MovieTest {
  private Movie movie;
  
  @BeforeEach
  void setUp() throws Exception {
    movie = new Movie("tt0111161");
  }

  @Test
  void testConstructorValidID() {
    Movie validMovie = new Movie("tt0111161");
    assertEquals("The Shawshank Redemption", validMovie.getTitle());
  }
  
  @Test
  void testConstructorInvalidID() {
    new Movie("t");
  }
  
  @Test
  void testGetId() {
    assertEquals("tt0111161", movie.getId());
  }
  
  @Test
  void testGetTitle() {
    assertEquals("The Shawshank Redemption", movie.getTitle());
  }

  @Test
  void testGetYear() {
    assertEquals("1994", movie.getYear());
  }

  @Test
  void testGetImage() {
    assertEquals("https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_Ratio0.6762_AL_.jpg", movie.getImage());
  }

  @Test
  void testGetReleaseDate() {
    assertEquals("1994-10-14", movie.getReleaseDate());
  }

  @Test
  void testGetRunTime() {
    assertEquals("2h 22min (142min)", movie.getRunTime());
  }

  @Test
  void testGetPlot() {
    assertEquals("Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.", movie.getPlot());
  }

  @Test
  void testGetAwards() {
    assertEquals("Top rated movie #1 | Nominated for 7 Oscars, 21 wins & 43 nominations total", movie.getAwards());
  }

  @Test
  void testGetContentRating() {
    assertEquals("R", movie.getContentRating());
  }

  @Test
  void testGetImDbRating() {
    assertEquals("9.3", movie.getImDbRating());
  }

  @Test
  void testGetImDbRatingVotes() {
    assertEquals("2654945", movie.getImDbRatingVotes());
  }

  @Test
  void testGetMetacriticRating() {
    assertEquals("81", movie.getMetacriticRating());
  }

  @Test
  void testGetDirectors() {
    String[][] directorList = {{
      "nm0001104", 
      "Frank Darabont"
    }};
    assertEquals(directorList[0][0], movie.getDirectors()[0][0]);
    assertEquals(directorList[0][1], movie.getDirectors()[0][1]);
  }

  @Test
  void testGetWriters() {
    String[][] writerList = {{
      "nm0000175", 
      "Stephen King"
    }, {
        "nm0001104", 
        "Frank Darabont"
      }};
    for (int i = 0; i < movie.getWriters().length; i++) {
      for (int j = 0; j < movie.getWriters()[i].length; j++) {
        assertEquals(writerList[i][j], movie.getWriters()[i][j]);
      }
    }
  }

  @Test
  void testGetStars() {
    String[][] starList = {{
        "nm0000209",
        "Tim Robbins"
      }, {
        "nm0000151",
        "Morgan Freeman"
      }, {
        "nm0348409",
        "Bob Gunton"
      }};
    for (int i = 0; i < movie.getStars().length; i++) {
      for (int j = 0; j < movie.getStars()[i].length; j++) {
        assertEquals(starList[i][j], movie.getStars()[i][j]);
      }
    }
  }

  @Test
  void testGetActors() {
    String[][] actorList = {{
      "nm0000209",
      "https://m.media-amazon.com/images/M/MV5BMTI1OTYxNzAxOF5BMl5BanBnXkFtZTYwNTE5ODI4._V1_Ratio1.0000_AL_.jpg",
      "Tim Robbins",
      "Andy Dufresne"
    }, {
      "nm0542957",
      "https://imdb-api.com/images/original/nopicture.jpg",
      "Scott Mann",
      "Glenn Quentin"
    }};
    for (int i = 0; i < 4; i++) {
      assertEquals(actorList[0][i], movie.getActors()[0][i]);
      assertEquals(actorList[1][i], movie.getActors()[movie.getActors().length - 1][i]);
    }
  }

  @Test
  void testGetGenres() {
    assertEquals("Drama", movie.getGenres());
  }

  @Test
  void testGetCompanies() {
    String[][] companyList = {{
      "co0040620",
      "Castle Rock Entertainment"
    }};
    assertEquals(companyList[0][0], movie.getCompanies()[0][0]);
    assertEquals(companyList[0][1], movie.getCompanies()[0][1]);
  }

  @Test
  void testGetCountries() {
    assertEquals("USA", movie.getCountries());
  }

  @Test
  void testGetLanguages() {
    assertEquals("English", movie.getLanguages());
  }

  @Test
  void testGetBoxOffice() {
    String[] boxOffice = {
      "$25,000,000 (estimated)",
      "$727,327",
      "$28,767,189",
      "$28,884,504"
    };
    for (int i = 0; i < 4; i++) {
      assertEquals(boxOffice[i], movie.getBoxOffice()[i]);
    }
  }

  @Test
  void testGetSimilars() {
    String[][] similars = {{
      "tt0468569",
      "The Dark Knight",
      "https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_Ratio0.6763_AL_.jpg",
      "9.0"
    }, {
      "tt0167260",
      "The Lord of the Rings: The Return of the King",
      "https://m.media-amazon.com/images/M/MV5BNzA5ZDNlZWMtM2NhNS00NDJjLTk4NDItYTRmY2EwMWZlMTY3XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_Ratio0.6763_AL_.jpg",
      "9.0"
    }};
    for (int i = 0; i < 4; i++) {
      assertEquals(similars[0][i], movie.getSimilars()[0][i]);
      assertEquals(similars[1][i], movie.getSimilars()[movie.getSimilars().length - 1][i]);
    }
  }
}
