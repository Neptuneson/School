import java.util.List;

public class ByAuthorPrinter implements BookListPrinter{
  public void print(List<Book> books) {
    for (int i = 0; i < books.size() - 1; i++) {
      for (int j = 0; j < books.size() - i - 1; j++) {
          if (books.get(j).getAuthor().compareTo(books.get(j + 1).getAuthor()) > 0) {
              Book temp = books.get(j);
              books.set(j, books.get(j + 1));
              books.set(j + 1, temp);
          }
      }
    }
    
    String author = "";
    for (Book book: books) {
      String year = "" + book.getYear();
      if (book.getYear() < 0) {
        year = "" + (book.getYear() * -1) + " BCE";
      }
      if (book.getAuthor().equals(author)) {
        System.out.printf("\t%s (%s)", book.getTitle(), year);
      } else {
        System.out.printf("%s:", book.getAuthor());
        System.out.print(System.lineSeparator());
        System.out.printf("\t%s (%s)", book.getTitle(), year);
      }
      author = book.getAuthor();
      System.out.print(System.lineSeparator());
    }
  }
}
