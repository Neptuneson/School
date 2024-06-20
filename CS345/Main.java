import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.swing.JTree;
import javax.swing.border.Border;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Main {
  
  private JFrame frame;
  private JTree tree;
  private JLabel book;
  private JLabel cover;
  private JButton bookAddButton;
  private JButton bookEditButton;
  
  private Book selectedBook;
  private String selectedTitle;
  private String selectedAuthor;
  private String selectedCountry;
  private String selectedImage;
  private String selectedLanguage;
  private String selectedLink;
  private String selectedPages;
  private String selectedYear;
  
  private Container contentPane;
  
  private DefaultMutableTreeNode root;
  
  public Main() throws IOException {
    File file = new File("books.json");
    ArrayList<Book> bookList = BookListReader.readBookList(new FileInputStream(file));
    
    createTree(bookList);
    
    JPanel addEditPanel = new JPanel();
    
    bookAddButton = new JButton("Add Book");
    bookAddButton.addActionListener(new ActionListener () {
      public void actionPerformed(ActionEvent e) {
        JFrame addFrame = new JFrame("Add Book");
        addFrame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        addFrame.setPreferredSize(new Dimension(400, 800));
        Container infoPane = addFrame.getContentPane();
        infoPane.setLayout(new BorderLayout());
        
        JPanel addPanel = new JPanel();
        addPanel.setLayout(new GridLayout(8, 2));
        
        JLabel titleText = new JLabel("Title");
        JTextField title = new JTextField();
        addPanel.add(titleText);
        addPanel.add(title);
        
        JLabel authorText = new JLabel("Author");
        JTextField author = new JTextField();
        addPanel.add(authorText);
        addPanel.add(author);
        
        JLabel countryText = new JLabel("Country");
        JTextField country = new JTextField();
        addPanel.add(countryText);
        addPanel.add(country);
        
        JLabel imageText = new JLabel("ImageLink");
        JTextField image = new JTextField();
        addPanel.add(imageText);
        addPanel.add(image);
        
        JLabel languageText = new JLabel("Language");
        JTextField language = new JTextField();
        addPanel.add(languageText);
        addPanel.add(language);
        
        JLabel linkText = new JLabel("Link");
        JTextField link = new JTextField();
        addPanel.add(linkText);
        addPanel.add(link);
        
        JLabel pagesText = new JLabel("Pages");
        JTextField pages = new JTextField();
        addPanel.add(pagesText);
        addPanel.add(pages);
        
        JLabel yearText = new JLabel("Year");
        JTextField year = new JTextField();
        addPanel.add(yearText);
        addPanel.add(year);
        
        infoPane.add(addPanel, BorderLayout.CENTER);
        
        JButton save = new JButton("Save");
        save.addActionListener(new ActionListener () {
          public void actionPerformed(ActionEvent e) {
            boolean cont = true;
            ObjectMapper mapper = new ObjectMapper();
            
            Book newBook = null;
            try {
              newBook = new Book(title.getText(), author.getText(), country.getText(), image.getText(), language.getText(), link.getText(), Integer.parseInt(pages.getText()), Integer.parseInt(year.getText()));
              bookList.add(newBook);
              
            } catch (NumberFormatException nfe) {
              cont = false;
            }
            
            if (cont) {
              String json = "[" + System.lineSeparator();
              for (int i = 0; i < bookList.size(); i++) {
                try {
                  json += mapper.writerWithDefaultPrettyPrinter().writeValueAsString(bookList.get(i));
                }
                catch (JsonProcessingException e1) {
                  e1.printStackTrace();
                }
                if (i + 1 < bookList.size()) {
                  json += "," + System.lineSeparator();
                }
              }
              json += System.lineSeparator() +"]" + System.lineSeparator();
              
              try {
                File file = new File("books.json");
                FileWriter writer = new FileWriter(file);
                writer.write(json);
                writer.close();
              }
              catch (IOException e1) {
                e1.printStackTrace();
              }
              DefaultTreeModel model = (DefaultTreeModel) tree.getModel();
              DefaultMutableTreeNode root = (DefaultMutableTreeNode) model.getRoot();
              DefaultMutableTreeNode authorNode = new DefaultMutableTreeNode(newBook.getAuthor());
              DefaultMutableTreeNode bookNode = new DefaultMutableTreeNode(newBook);
              
              boolean isFound = false;
              for (int i = 0; i < root.getChildCount(); i++) {
                DefaultMutableTreeNode child = (DefaultMutableTreeNode) root.getChildAt(i);
                String nt = child.getUserObject().toString();
                if (nt.equalsIgnoreCase(newBook.getAuthor())) {
                  child.add(bookNode);
                  isFound = true;
                }
              }
              if (!isFound) {
                authorNode.add(bookNode);
                root.add(authorNode);
              }
              
              for(int i = 0; i < root.getChildCount() - 1; i++) {
                DefaultMutableTreeNode child = (DefaultMutableTreeNode) root.getChildAt(i);
                String nt = child.getUserObject().toString();
                for (int j = i + 1; j < root.getChildCount(); j++) {
                  DefaultMutableTreeNode prevNode = (DefaultMutableTreeNode) root.getChildAt(j);
                  String np = prevNode.getUserObject().toString();
                  if (nt.compareToIgnoreCase(np) > 0) {
                    root.insert(child, j);
                    root.insert(prevNode, i);
                  }
                }
              }
              model.reload(root);
              
            }
            addFrame.dispatchEvent(new WindowEvent(addFrame, WindowEvent.WINDOW_CLOSING));
          }
        });
        infoPane.add(save, BorderLayout.SOUTH);
        
        addFrame.pack();
        addFrame.setVisible(true);
      }
    });
    bookAddButton.setPreferredSize(new Dimension(100, 25));
    addEditPanel.add(bookAddButton);
    
    bookEditButton = new JButton("Edit Book");
    bookEditButton.setEnabled(false);
    bookEditButton.setPreferredSize(new Dimension(100, 25));
    addEditPanel.add(bookEditButton);
    bookEditButton.addActionListener(new ActionListener () {
      public void actionPerformed(ActionEvent e) {
        JFrame addFrame = new JFrame("Edit Book");
        addFrame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        addFrame.setPreferredSize(new Dimension(400, 800));
        Container infoPane = addFrame.getContentPane();
        infoPane.setLayout(new BorderLayout());
        
        JPanel addPanel = new JPanel();
        addPanel.setLayout(new GridLayout(8, 2));
        
        JLabel titleText = new JLabel("Title");
        JTextField title = new JTextField(selectedTitle);
        addPanel.add(titleText);
        addPanel.add(title);
        
        JLabel authorText = new JLabel("Author");
        JTextField author = new JTextField(selectedAuthor);
        addPanel.add(authorText);
        addPanel.add(author);
        
        JLabel countryText = new JLabel("Country");
        JTextField country = new JTextField(selectedCountry);
        addPanel.add(countryText);
        addPanel.add(country);
        
        JLabel imageText = new JLabel("ImageLink");
        JTextField image = new JTextField(selectedImage);
        addPanel.add(imageText);
        addPanel.add(image);
        
        JLabel languageText = new JLabel("Language");
        JTextField language = new JTextField(selectedLanguage);
        addPanel.add(languageText);
        addPanel.add(language);
        
        JLabel linkText = new JLabel("Link");
        JTextField link = new JTextField(selectedLink);
        addPanel.add(linkText);
        addPanel.add(link);
        
        JLabel pagesText = new JLabel("Pages");
        JTextField pages = new JTextField(selectedPages);
        addPanel.add(pagesText);
        addPanel.add(pages);
        
        JLabel yearText = new JLabel("Year");
        JTextField year = new JTextField(selectedYear);
        addPanel.add(yearText);
        addPanel.add(year);
        
        infoPane.add(addPanel, BorderLayout.CENTER);
        
        JButton save = new JButton("Save");
        save.addActionListener(new ActionListener () {
          public void actionPerformed(ActionEvent e) {
            boolean cont = true;
            ObjectMapper mapper = new ObjectMapper();
            if (!title.getText().equals(selectedTitle) || !author.getText().equals(selectedAuthor) || !country.getText().equals(selectedCountry) || !image.getText().equals(selectedImage) || (!link.getText().equals("") && !link.getText().equals(selectedLink)) || !language.getText().equals(selectedLanguage) || !pages.getText().equals(selectedPages) || !year.getText().equals(selectedYear)) {
              Book newBook = null;
              try {
                newBook = new Book(title.getText(), author.getText(), country.getText(), image.getText(), language.getText(), link.getText(), Integer.parseInt(pages.getText()), Integer.parseInt(year.getText()));
                for (int i = 0; i < bookList.size(); i++) {
                  if (bookList.get(i).getTitle().equals(newBook.getTitle())) {
                    bookList.remove(i);
                    bookList.add(i, newBook);
                  }
                }
              } catch (NumberFormatException nfe) {
                cont = false;
              }
              
              if (cont) {
                String json = "[" + System.lineSeparator();
                for (int i = 0; i < bookList.size(); i++) {
                  try {
                    json += mapper.writerWithDefaultPrettyPrinter().writeValueAsString(bookList.get(i));
                  }
                  catch (JsonProcessingException e1) {
                    e1.printStackTrace();
                  }
                  if (i + 1 < bookList.size()) {
                    json += "," + System.lineSeparator();
                  }
                }
                json += System.lineSeparator() +"]" + System.lineSeparator();
                
                try {
                  File file = new File("books.json");
                  FileWriter writer = new FileWriter(file);
                  writer.write(json);
                  writer.close();
                }
                catch (IOException e1) {
                  e1.printStackTrace();
                }
                
                DefaultTreeModel model = (DefaultTreeModel) tree.getModel();
                DefaultMutableTreeNode root = (DefaultMutableTreeNode) model.getRoot();
                DefaultMutableTreeNode authorNode = new DefaultMutableTreeNode(newBook.getAuthor());
                DefaultMutableTreeNode bookNode = new DefaultMutableTreeNode(newBook);
                
                if (!newBook.getAuthor().equalsIgnoreCase(selectedAuthor)) {
                  boolean found = false;
                  for (int i = 0; i < root.getChildCount(); i++) {
                    DefaultMutableTreeNode child = (DefaultMutableTreeNode) root.getChildAt(i);
                    String author = child.getUserObject().toString();
                    if (author.equalsIgnoreCase(newBook.getAuthor())) {
                      child.add(bookNode);
                      for (int j = 0; j < root.getChildCount(); j++) {
                        DefaultMutableTreeNode childCheck = (DefaultMutableTreeNode) root.getChildAt(j);
                        String authorCheck = childCheck.getUserObject().toString();
                        if (authorCheck.equalsIgnoreCase(selectedAuthor)) {
                          root.remove(childCheck);
                        }
                      }
                      found = true;
                    }
                  }
                  
                  if (!found) {
                    for (int i = 0; i < root.getChildCount(); i++) {
                      DefaultMutableTreeNode child = (DefaultMutableTreeNode) root.getChildAt(i);
                      String author = child.getUserObject().toString();
                      
                      if (author.equalsIgnoreCase(selectedAuthor)) {
                        if (child.getChildCount() == 1) {
                          root.remove(child);
                        } else {
                          for (int j = 0; j < child.getChildCount(); j++) {
                            DefaultMutableTreeNode childOfChild = (DefaultMutableTreeNode) child.getChildAt(j);
                            String oldBook = childOfChild.getUserObject().toString();
                            if (oldBook.equalsIgnoreCase(selectedBook.toString())) {
                              child.remove(childOfChild);
                            }
                          }
                        }
                      }
                    }
                    authorNode.add(bookNode);
                    root.add(authorNode);
                  }
                } else {
                  for (int i = 0; i < root.getChildCount(); i++) {
                    DefaultMutableTreeNode child = (DefaultMutableTreeNode) root.getChildAt(i);
                    for (int j = 0; j < child.getChildCount(); j++) {
                      DefaultMutableTreeNode bookChild = (DefaultMutableTreeNode) child.getChildAt(j);
                      if (bookChild.getUserObject().toString().equals(selectedBook.toString())) {
                        child.remove(bookChild);
                        child.add(bookNode);
                        book.setText(bookNode.getUserObject().toString());
                      }
                    }
                  }
                }
                
                for(int i = 0; i < root.getChildCount() - 1; i++) {
                  DefaultMutableTreeNode child = (DefaultMutableTreeNode) root.getChildAt(i);
                  String nt = child.getUserObject().toString();
                  for (int j = i + 1; j < root.getChildCount(); j++) {
                    DefaultMutableTreeNode prevNode = (DefaultMutableTreeNode) root.getChildAt(j);
                    String np = prevNode.getUserObject().toString();
                    if (nt.compareToIgnoreCase(np) > 0) {
                      root.insert(child, j);
                      root.insert(prevNode, i);
                    }
                  }
                }
                model.reload(root);
                
                selectedBook = newBook;
                selectedTitle = newBook.getTitle();
                selectedAuthor = newBook.getAuthor();
                selectedCountry = newBook.getCountry();
                selectedImage = newBook.getImageLink();
                selectedLanguage = newBook.getLanguage();
                selectedLanguage = newBook.getLink();
                selectedPages = Integer.toString(newBook.getPages());
                selectedYear = Integer.toString(newBook.getYear());
              }
            }
            bookEditButton.setEnabled(false);
            ImageIcon image = new ImageIcon(Main.class.getResource(""));
            cover = new JLabel(image);
            book.setText("");
            addFrame.dispatchEvent(new WindowEvent(addFrame, WindowEvent.WINDOW_CLOSING));
          }
        });
        infoPane.add(save, BorderLayout.SOUTH);
        
        addFrame.pack();
        addFrame.setVisible(true);
      }
    });
    contentPane.add(addEditPanel, BorderLayout.SOUTH);
    
    JPanel bookPanel = new JPanel();
    bookPanel.setLayout(new BoxLayout(bookPanel, BoxLayout.PAGE_AXIS));
    
    ImageIcon image = new ImageIcon(Main.class.getResource(""));
    cover = new JLabel(image);
    Border imageBorder = BorderFactory.createEmptyBorder(10, 10, 10, 10);
    cover.setBorder(imageBorder);
    bookPanel.add(cover);
    
    book = new JLabel("");
    Border border = BorderFactory.createEmptyBorder(10, 10, 10, 10);
    book.setBorder(border);
    bookPanel.add(book, BorderLayout.SOUTH);
    bookPanel.setPreferredSize(new Dimension(700,600));
    
    contentPane.add(bookPanel);
    
  }
  
  private void createTree(ArrayList<Book> bookList) {
    for (int i = 0; i < bookList.size() - 1; i++) {
      for (int j = 0; j < bookList.size() - i - 1; j++) {
          if (bookList.get(j).getAuthor().compareTo(bookList.get(j + 1).getAuthor()) > 0) {
              Book temp = bookList.get(j);
              bookList.set(j, bookList.get(j + 1));
              bookList.set(j + 1, temp);
          }
      }
    }
    
    root = new DefaultMutableTreeNode("Authors");
    
    String author = "";
    DefaultMutableTreeNode authorNode = null;
    for (Book book: bookList) {
      if (book.getAuthor().equals(author)) {
        DefaultMutableTreeNode bookNode = new DefaultMutableTreeNode(book);
        authorNode.add(bookNode);
      } else {
        DefaultMutableTreeNode bookNode = new DefaultMutableTreeNode(book);
        authorNode = new DefaultMutableTreeNode(book.getAuthor());
        authorNode.add(bookNode);
        root.add(authorNode);
        
      }
      author = book.getAuthor();
    }
    
    frame = new JFrame("Bookz");
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    contentPane = frame.getContentPane();
    contentPane.setLayout(new BorderLayout());
    
    for(int i = 0; i < root.getChildCount() - 1; i++) {
      DefaultMutableTreeNode child = (DefaultMutableTreeNode) root.getChildAt(i);
      String nt = child.getUserObject().toString();
      for (int j = i + 1; j < root.getChildCount(); j++) {
        DefaultMutableTreeNode prevNode = (DefaultMutableTreeNode) root.getChildAt(j);
        String np = prevNode.getUserObject().toString();
        if (nt.compareToIgnoreCase(np) > 0) {
          root.insert(child, j);
          root.insert(prevNode, i);
        }
      }
    }
    
    tree = new JTree(root);
    tree.setRootVisible(false);
    tree.setShowsRootHandles(true);
    tree.getSelectionModel().addTreeSelectionListener(new TreeSelectionListener() {
      public void valueChanged(TreeSelectionEvent e) {
        DefaultMutableTreeNode selectedNode = (DefaultMutableTreeNode) tree.getLastSelectedPathComponent();
        if (selectedNode != null && selectedNode.getUserObject() instanceof Book) {
          Book bookPic = (Book) selectedNode.getUserObject();
          
          selectedBook = bookPic;
          selectedTitle = bookPic.getTitle();
          selectedAuthor = bookPic.getAuthor();
          selectedCountry = bookPic.getCountry();
          selectedImage = bookPic.getImageLink();
          selectedLanguage = bookPic.getLanguage();
          selectedLanguage = bookPic.getLink();
          selectedPages = Integer.toString(bookPic.getPages());
          selectedYear = Integer.toString(bookPic.getYear());
          
          book.setText(selectedNode.getUserObject().toString());
          try {
            cover.setIcon(new ImageIcon(Main.class.getResource(bookPic.getImageLink())));
          } catch (NullPointerException npe) {
            
          }
          bookEditButton.setEnabled(true);
        }
      }
    });
    contentPane.add(new JScrollPane(tree), BorderLayout.WEST);
  }
  
  private void display() {
    frame.pack();
    frame.setVisible(true);
  }
  
  public static void main(String[] args) throws IOException {
    new Main().display();
  }
}
