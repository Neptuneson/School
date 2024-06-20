import static org.junit.jupiter.api.Assertions.*;


import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class MovieResultTest {
  private Result movieResult;
  
  @BeforeEach
  void setUp() throws Exception {
    movieResult = new Result("tt0111161", "The Shawshank Redemption", "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_Ratio0.6757_AL_.jpg", "1994 Tim Robbins, Morgan Freeman");
  }

  @Test
  void testConsturctor() {
    new Result("tt0111161", "The Shawshank Redemption", "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_Ratio0.6757_AL_.jpg", "1994 Tim Robbins, Morgan Freeman");
  }
  
  @Test
  void testGetId() {
    assertEquals("tt0111161", movieResult.getId());
  }
  
  @Test
  void testGetTitle() {
    assertEquals("The Shawshank Redemption", movieResult.getTitle());
  }
  
  @Test
  void testGetImage() {
    assertEquals("https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_Ratio0.6757_AL_.jpg", movieResult.getImage());
  }
  
  @Test
  void testGetDescription() {
    assertEquals("1994 Tim Robbins, Morgan Freeman", movieResult.getDescription());
  }

}
