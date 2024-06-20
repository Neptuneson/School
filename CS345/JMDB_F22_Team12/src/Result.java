/**
 * Class is for storing and retrieving information from basic search.
 */
public class Result{
  private String id;
  private String title;
  private String image;
  private String description;
  /**
   * Creates search result after first search is performed.
   * 
   * @param id            key for result
   * @param title         title for result
   * @param image         image link for result (should always be empty if company)
   * @param description   short result description
   */
  public Result(String id, String title, String image, String description) {
    this.id = id;
    this.title = title;
    this.image = image;
    this.description = description;
  }
  
  // Getters
  // can also be changed based on output preferences
  public String getId() {
    return id;
  }
  
  public String getTitle() {
    return title;
  }
  
  public String getImage() {
    return image;
  }
  
  public String getDescription() {
    return description;
  }

}
