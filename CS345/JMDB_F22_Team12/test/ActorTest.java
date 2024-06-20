import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ActorTest {
  private Actor actor;

  @BeforeEach
  void setUp() throws Exception {
    actor = new Actor("nm0000154");
  }

  @Test
  void testConstructor() {
    new Actor("nm0000154");
  }
  
  @Test
  void testGetId() {
    assertEquals("nm0000154", actor.getId());
  }
  
  @Test
  void testGetName() {
    assertEquals("Mel Gibson", actor.getName());
  }
  
  @Test
  void testGetRole() {
    assertEquals("Actor, Producer, Director", actor.getRole());
  }
  
  @Test
  void testGetImage() {
    assertEquals("https://m.media-amazon.com/images/M/MV5BNTUzOTMwNTM0OV5BMl5BanBnXkFtZTcwNDQwMTUxMw@@._V1_Ratio0.7256_AL_.jpg", actor.getImage());
  }
  
  @Test
  void testGetSummary() {
    assertEquals("Mel Columcille Gerard Gibson was born January 3, 1956 in Peekskill, New York, USA, as the sixth of eleven children of Hutton Gibson, a railroad brakeman, and Anne Patricia (Reilly) Gibson (who died in December of 1990). His mother was Irish, from County Longford, while his American-born father is of mostly Irish descent. Mel and his family moved to...", actor.getSummary());
  }
  
  @Test
  void testGetBirthDate() {
    assertEquals("1956-01-03", actor.getBirthDate());
  }
  
  @Test
  void testGetDeathDate() {
    assertEquals("null", actor.getDeathDate());
  }
  
  @Test
  void testGetAwards() {
    assertEquals("Won 2 Oscars. | Another 42 wins & 43 nominations.", actor.getAwards());
  }
  
  @Test
  void testGetHeight() {
    assertEquals("5' 9¾\" (1.77 m)", actor.getHeight());
  }
  
  @Test
  void testGetKnownFor() {
    String[][] expected = {{
      "tt0112573",
      "Braveheart",
      "1995",
      "William Wallace",
      "https://m.media-amazon.com/images/M/MV5BMzkzMmU0YTYtOWM3My00YzBmLWI0YzctOGYyNTkwMWE5MTJkXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_Ratio0.6852_AL_.jpg"
    }};
    for (int i = 0; i < 5; i++) {
      assertEquals(expected[0][i], actor.getKnownFor()[0][i]);
    }
    assertEquals(4, actor.getKnownFor().length);
  }
  
  @Test
  void testGetCastMovies() {
    String[][] expected = {{
      "tt16101924",
      "Actor",
      "Lethal Weapon 5",
      "2023",
      "(pre-production) Martin Riggs (rumored)"
    }};
    for (int i = 0; i < 5; i++) {
      assertEquals(expected[0][i], actor.getCastMovies()[0][i]);
    }
    assertEquals(10, actor.getCastMovies().length);
  }

}
