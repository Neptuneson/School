import java.util.List;

public class AlphabeticalPrinter implements BookListPrinter{
  public void print(List<Book> books) {
    for (int i = 0; i < books.size() - 1; i++) {
      for (int j = 0; j < books.size() - i - 1; j++) {
          if (books.get(j).getTitle().compareTo(books.get(j + 1).getTitle()) > 0) {
              Book temp = books.get(j);
              books.set(j, books.get(j + 1));
              books.set(j + 1, temp);
          }
      }
    }
    
    for (Book book: books) {
      String year = "" + book.getYear();
      if (book.getYear() < 0) {
        year = "" + (book.getYear() * -1) + " BCE";
      }
      System.out.printf("%s by %s (%s)", book.getTitle(), book.getAuthor(), year);
      System.out.print(System.lineSeparator());
    }
  }
}