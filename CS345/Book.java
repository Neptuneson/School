
public class Book {
  private String title, author, country, imageLink, language, link;
  private int pages, year;
  public Book(String title, String author, String country, String imageLink, String language, String link, int pages, int year) {
    this.title = title;
    this.author = author;
    this.country = country;
    this.imageLink = imageLink;
    this.language = language;
    this.link = link;
    this.pages = pages;
    this.year = year;
  }
  
  public String getTitle() {
    return title;
  }
  
  public String getAuthor() {
    return author;
  }
  
  public String getCountry() {
    return country;
  }
  
  public String getImageLink() {
    return imageLink;
  }
  
  public String getLanguage() {
    return language;
  }
  
  public String getLink() {
    return link;
  }
  
  public int getPages() {
    return pages;
  }
  
  public int getYear() {
    return year;
  }
  
  public String toString() {
    String year = "" + getYear();
    if (getYear() < 0) {
      if (getYear() < 0) {
        year = "" + (getYear() * -1) + " BCE";
      }
    }
    return String.format("%s by %s (%s)", getTitle(), getAuthor(), year);
  }
}
