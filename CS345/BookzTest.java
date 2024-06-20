import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.util.List;

import org.junit.jupiter.api.Test;

class BookzTest {
  
  @Test
  void testReadBookList() throws IOException {
    InputStream in = BookzTest.class.getResourceAsStream("test_data.json");
    List<Book> booksList = BookListReader.readBookList(in);
    Book b1 = booksList.get(0);
    Book b2 = booksList.get(1);
    assertEquals("7", b1.getTitle());
    assertEquals("1", b1.getAuthor());
    assertEquals(8, b1.getYear());
    assertEquals("17", b2.getTitle());
    assertEquals("11", b2.getAuthor());
    assertEquals(-18, b2.getYear());
  }
  
  @Test
  void testAlphabeticalPrinter() throws IOException {
    InputStream in = BookzTest.class.getResourceAsStream("test_data.json");
    List<Book> booksList = BookListReader.readBookList(in);
    PrintStream stdOut = null;
    String expected = "17 by 11 (18 BCE)\n7 by 1 (8)\n";
    try {
      stdOut = System.out;
      ByteArrayOutputStream baos = new ByteArrayOutputStream();
      System.setOut(new PrintStream(baos));
      new AlphabeticalPrinter().print(booksList);
      assertEquals(expected, baos.toString());
    } finally {
      System.setOut(stdOut);
    }
  }
  
  @Test
  void testByAuthorPrinter() throws IOException {
    InputStream in = 
        BookzTest.class.getResourceAsStream("test_data2.json");
    List<Book> booksList = BookListReader.readBookList(in);
    PrintStream stdOut = null;
    String expected = "1:\n\t7 (8)\n11:\n\t17 (18 BCE)\n\t27 (17 BCE)\n";
    try {
      stdOut = System.out;
      ByteArrayOutputStream baos = new ByteArrayOutputStream();
      System.setOut(new PrintStream(baos));
      new ByAuthorPrinter().print(booksList);
      assertEquals(expected, baos.toString());
    } finally {
      System.setOut(stdOut);
    }
  }
}