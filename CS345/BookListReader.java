import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;


public class BookListReader {
  public static ArrayList<Book> readBookList(InputStream in) throws IOException{
    ArrayList<Book> books = new ArrayList<Book>();
    ObjectMapper mapper = new ObjectMapper();
    JsonNode tree = mapper.readTree(in);
    for(int i = 0; i < tree.size(); i++) {
      JsonNode root = tree.get(i);
      books.add(new Book(root.get("title").asText(), root.get("author").asText(), root.get("country").asText(), 
          root.get("imageLink").asText(), root.get("language").asText(), root.get("link").asText(), 
          root.get("pages").asInt(), root.get("year").asInt()));
    }
    return books;
  }
}
