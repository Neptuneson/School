import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.WindowEvent;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Random;

import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JTextField;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Main movie display class.
 */
public class MovieDisplay
{
  private String searchOpt = "Movie";
  private JFrame frame;
  private JPanel renders;
  private JLabel[] rendStorage;
  private JLabel render;
  private Result[] results;
  private int identity; // If 0, movie; if 1, actor; if 2, company
  private int lives = 5;
  private String hangTitle;
  private boolean win = false;
  private Result result;
  final static int RESULT_SIZE = 4;
  final static String KEY = "k_mcx0w8kk"; // The premade key provided.

  /*
   * Main method. Automatically starts the process of creating the window.
   *
   * @param args command line
   */
  public static void main(String[] args)
  {
    new MovieDisplay();
  }

  /**********************************************************
                     CONSTRUCTION METHODS
   **********************************************************/
  /*
   * MovieDisplay object. Creates the window.
   */
  private MovieDisplay()
  {
    frame = new JFrame("Games");
    frame.setPreferredSize(new Dimension(1500, 500));
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

    buildGui();

    frame.pack();
    frame.setExtendedState(JFrame.MAXIMIZED_BOTH);
    frame.setVisible(true);
  }

  /*
   * Constructs the GUI interface.
   */
  private void buildGui()
  {
    Container window = frame.getContentPane();
    window.setLayout(new BorderLayout());

    // Search bar and drop down
    buildSearch(window);

    // Game window
    JButton game = new JButton("Hangman");
    game.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e)
      {
        buildGame();
      }
    });
    window.add(game, BorderLayout.SOUTH);

    // Render movie poster
    renders = new JPanel(new GridLayout(RESULT_SIZE / 2, 2));
    rendStorage = new JLabel[RESULT_SIZE];
    for (int i = 0; i < RESULT_SIZE; i++)
    {
      render = new JLabel();
      render.setHorizontalTextPosition(JLabel.RIGHT); // Right align from poster
      render.setPreferredSize(new Dimension(250, 150)); // Poster size
      render.addMouseListener(new MouseAdapter()
      {
        public void mouseClicked(MouseEvent e)
        {
          JLabel idPanel = (JLabel) e.getSource();
          if (idPanel.getIcon() != null && idPanel.getText() != null)
          {
            switch (identity)
            {
              case 0: // Type: movie
                Movie clickMov = new Movie(idPanel.getName());
                MovieFunctions.popUpMovieInfo(clickMov);
                break;
              case 1: // Type: actor
                Actor clickAct = new Actor(idPanel.getName());
                MovieFunctions.popUpActorInfo(clickAct);
                break;
              default: // company and unexpected types
                break;
            }
          }
        }
      });
      renders.add(render);
      // Storage of renders for easy access
      rendStorage[i] = render;
    }
    window.add(renders, BorderLayout.CENTER);
  }

  /*
   *  Builds the search functions in the container.
   *  
   *  @param window the container to manipulate
   */
  private void buildSearch(Container window)
  {
    JPanel searchPanel = new JPanel(); // Panel for search components
    JTextField searchBox = new JTextField(30); // Search space


    searchPanel.add(searchBox);
    @SuppressWarnings({"rawtypes", "unchecked"})
    // Options for search type
    JComboBox searchList = new JComboBox(new String[] {"Movie", "Actor", "Company"});
    searchList.addActionListener(new ActionListener()
    {
      @Override
      public void actionPerformed(ActionEvent e)
      {
        @SuppressWarnings("rawtypes")
        JComboBox cb = (JComboBox) e.getSource();
        searchOpt = (String) cb.getSelectedItem();
      }
    });
    searchPanel.add(searchList);

    // Proper search button
    JButton search = new JButton("Search");
    searchBox.addKeyListener(new KeyListener() // Enter key
    		{
				@Override
				public void keyTyped(KeyEvent e) {
				  // Nothing
				}
				@Override
				public void keyPressed(KeyEvent e) {
				  // Nothing
				}
				@Override
				public void keyReleased(KeyEvent e) {
					if (e.getKeyCode() == KeyEvent.VK_ENTER) {
						interpretSearch(searchBox);
					}
				}});
    search.addActionListener(new ActionListener() // GUI button
    {
      @Override
      public void actionPerformed(ActionEvent e)
      {
        interpretSearch(searchBox);
      }
    });
    searchPanel.add(search);
    // Advanced search button
    JButton advanced = new JButton("Advanced Search");
    advanced.addActionListener(new ActionListener()
    {
      @Override
      public void actionPerformed(ActionEvent e)
      {
        JFrame searchFrame = new JFrame("Advanced Search"); // New window for options
        searchFrame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        searchFrame.setPreferredSize(new Dimension(800, 800));
        Container search = searchFrame.getContentPane();
        JPanel searches = new JPanel();

        searches.setLayout(new GridLayout(7, 1));

        // Title advanced
        JPanel titleSearch = new JPanel();
        titleSearch.setLayout(new GridLayout(2, 1));
        titleSearch.add(new JLabel("Title"));
        JTextField title = new JTextField(20);
        titleSearch.add(title);
        searches.add(titleSearch);

        JPanel typeSearch = new JPanel();
        typeSearch.setLayout(new GridLayout(2, 1));
        typeSearch.add(new JLabel("Title Type"));
        JPanel titleType = new JPanel();
        titleType.setLayout(new GridLayout(1, 1));
        JRadioButton feature = new JRadioButton("Feature Film");
        titleType.add(feature);
        typeSearch.add(titleType);
        searches.add(typeSearch);

        searches.add(new JLabel("Genres"));
        JPanel genres = new JPanel();
        genres.setLayout(new GridLayout(6, 6));
        JRadioButton[] genreSet = new JRadioButton[26];
        String[] genreNames = new String[] {"action", "comedy", "family", "history", "mystery",
            "sci_fi", "war", "adventure", "crime", "fantasy", "horror", "news", "sport", "western",
            "animation", "documentary", "film_noir", "music", "reality_tv", "talk_show",
            "biography", "drama", "game_show", "musical", "romance", "thriller"};
        for (int i = 0; i < genreSet.length; i++)
        {
          // Reformatter - capitalize first letter, change all _s to -s, swap tv to TV
          String name = (genreNames[i].substring(0, 1).toUpperCase() + genreNames[i].substring(1))
              .replace("_", "-").replace("tv", "TV");
          JRadioButton genre = new JRadioButton(name);
          genreSet[i] = genre;
          genres.add(genre);
        }
        searches.add(genres);

        JRadioButton[] ratings = new JRadioButton[5];
        String[] ratingNames = new String[] {"G", "PG", "PG-13", "R", "NC-17"};
        searches.add(new JLabel("Age Rating"));
        JPanel ageRating = new JPanel();
        ageRating.setLayout(new GridLayout(1, 5));
        for (int i = 0; i < ratings.length; i++)
        {
          JRadioButton rating = new JRadioButton(ratingNames[i]);
          ratings[i] = rating;
          ageRating.add(rating);
        }
        searches.add(ageRating);

        JButton searchButton = new JButton("Search");
        searchButton.addActionListener(new ActionListener()
        {
          @Override
          public void actionPerformed(ActionEvent e)
          {
            boolean isMultiple = false;
            String link = String.format("https://imdb-api.com/API/AdvancedSearch/%s?", KEY);

            if (title.getText().length() != 0)
            {
              link += "title=" + title.getText();
              isMultiple = true;
            }

            if (feature.isSelected())
            {
              if (isMultiple)
              {
                link += "&";
              }
              else
              {
                isMultiple = true;
              }
              link += "title_type=feature";
            }

            boolean hasGenres = true;
            boolean isFirst = true;
            for (int i = 0; i < genreSet.length; i++)
            {
              JRadioButton radio = genreSet[i];
              if (radio.isSelected())
              {
                if (isMultiple && isFirst)
                {
                  link += "&";
                  isFirst = false;
                }
                else
                {
                  isMultiple = true;
                  isFirst = false;
                }
                if (hasGenres)
                {
                  link += "genres=" + genreNames[i];
                  hasGenres = false;
                }
                else
                {
                  link += "," + genreNames[i];
                }
              }
            }

            boolean hasRatings = true;
            isFirst = true;
            for (int i = 0; i < ratings.length; i++)
            {
              JRadioButton radio = ratings[i];
              if (radio.isSelected())
              {
                if (isMultiple && isFirst)
                {
                  link += "&";
                  isFirst = false;
                }
                else
                {
                  isMultiple = true;
                  isFirst = false;
                }
                if (hasRatings)
                {
                  link += "certificates=us:" + ratingNames[i];
                  hasRatings = false;
                }
                else
                {
                  link += ",us:" + ratingNames[i];
                }
              }
            }

            JsonNode tree = null;
            try
            {
              URL search = new URL(link);
              ObjectMapper mapper = new ObjectMapper();
              tree = mapper.readTree(search); // Uses the url link to create a json tree of movies.
            }
            catch (IOException ioe)
            {

            }
            Result[] results = MovieSearches.fillTree(tree, MovieDisplay.RESULT_SIZE);
            modifyRenders(0, results);
            searchFrame.dispatchEvent(new WindowEvent(searchFrame, WindowEvent.WINDOW_CLOSING));
          }
        });
        searches.add(searchButton);

        JScrollPane scrPane = new JScrollPane(searches);
        search.add(scrPane);
        searchFrame.pack();
        searchFrame.setVisible(true);
      }
    });
    searchPanel.add(advanced);
    window.add(searchPanel, BorderLayout.NORTH);
  }

  /*
   * Creates a pop-up window for a hangman game to run.
   */
  private void buildGame() {
    JFrame gameFrame = new JFrame("Hangman"); // New window for options
    gameFrame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    gameFrame.setPreferredSize(new Dimension(1000, 1000));
    Container gameWindow = gameFrame.getContentPane();
    JPanel game = new JPanel();
    game.setLayout(new BorderLayout());

    String[] genreNames = new String[] {"action", "comedy", "family", "history", "mystery",
        "sci_fi", "war", "adventure", "crime", "fantasy", "horror", "news", "sport", "western",
        "animation", "documentary", "film_noir", "music", "reality_tv", "talk_show",
        "biography", "drama", "game_show", "musical", "romance", "thriller"};

    Random random = new Random();
    JsonNode tree = null;
    do {
      int pick = random.nextInt(26);
      String link = String.format("https://imdb-api.com/API/AdvancedSearch/%s?title_type=feature&genres=%s", KEY, genreNames[pick]);
      JPanel catagoryPanel = new JPanel();
      JLabel catagory = new JLabel(genreNames[pick].toUpperCase());
      catagory.setFont(new Font("Serif", Font.BOLD, 48));
      catagoryPanel.add(catagory);
      game.add(catagoryPanel, BorderLayout.NORTH);
  
      try
      {
        URL search = new URL(link);
        ObjectMapper mapper = new ObjectMapper();
        tree = mapper.readTree(search); // Uses the url link to create a json tree of movies.
      }
      catch (IOException ioe)
      {
  
      }
    } while(tree.get("results").size() == 0);
    
    do {
      int movieNum = random.nextInt(tree.get("results").size());
      hangTitle = tree.get("results").get(movieNum).get("title").asText();
      String id = tree.get("results").get(movieNum).get("id").asText();
      String imageLink = tree.get("results").get(movieNum).get("image").asText();
      String description = tree.get("results").get(movieNum).get("description").asText();
      result = new Result(id, hangTitle, imageLink, description);
    } while(hangTitle.length() > 30);

    String startGuess = "";
    for (int i = 0; i < hangTitle.length(); i++) {
      if (i == 0) {
        startGuess += '_';
      } else if (hangTitle.charAt(i) == ' ') {
        startGuess += ' ';
      } else if (hangTitle.charAt(i) == '-' || hangTitle.charAt(i) == ':' || hangTitle.charAt(i) == '!' || hangTitle.charAt(i) == '?' || hangTitle.charAt(i) == '\'') {
        startGuess += hangTitle.charAt(i);
      } else {
        startGuess += " _";
      }
    }

    ArrayList<Character> correctGuesses = new ArrayList<>();
    correctGuesses.add(' ');
    correctGuesses.add('-');
    correctGuesses.add(':');
    correctGuesses.add('!');
    correctGuesses.add('?');
    correctGuesses.add('\'');

    JPanel guessPanel = new JPanel();
    guessPanel.setLayout(new BoxLayout(guessPanel, BoxLayout.Y_AXIS));
    JLabel guessHint = new JLabel(startGuess);
    guessHint.setFont(new Font("Serif", Font.BOLD, 60));
    guessHint.setAlignmentX(Component.CENTER_ALIGNMENT);
    guessPanel.add(guessHint);
    game.add(guessPanel, BorderLayout.CENTER);

    JPanel guessingPanel = new JPanel();
    JLabel livesLabel = new JLabel("" + lives);
    JLabel gameOverLabel = new JLabel("Game Over");
    gameOverLabel.setFont(new Font("Serif", Font.BOLD, 80));
    gameOverLabel.setForeground(Color.RED);
    gameOverLabel.setVisible(false);
    gameOverLabel.setAlignmentX(Component.CENTER_ALIGNMENT);
    guessPanel.add(gameOverLabel);
    JTextField textGuess = new JTextField(30);
    guessingPanel.add(textGuess);
    JButton guess = new JButton("Guess");
    textGuess.addKeyListener(new KeyListener() {
      @Override
      public void keyReleased(KeyEvent e)
      {
        if (e.getKeyCode() == KeyEvent.VK_ENTER) {
          if (textGuess.getText().length() != 0 && !win) {
            if (lives > 0) {
              String userGuess = textGuess.getText().toLowerCase();
              textGuess.setText("");
              if (hangTitle.toLowerCase().contains(userGuess)) {
                correctGuesses.add(userGuess.charAt(0));
              } else {
                lives--;
                livesLabel.setText("" + lives);
              }

              String update = "";
              if (lives == 0) {
                for (int i = 0; i < hangTitle.length(); i++) {
                  if (i != 0) {
                    update += " ";
                  }
                  update += hangTitle.charAt(i);
                }
              } else {
                for (int i = 0; i < hangTitle.length(); i++) {
                  if (i != 0) {
                    update += " ";
                  }
                  if (correctGuesses.contains(hangTitle.toLowerCase().charAt(i))) {
                    update += hangTitle.charAt(i);
                  } else {
                    update += '_';
                  }
                }
              }

              if (!update.contains("_")) {
                win = true;
              }

              if (win || lives == 0) {
                if (lives != 0) {
                  gameOverLabel.setText("You Win!");
                  gameOverLabel.setFont(new Font("Serif", Font.BOLD, 80));
                  gameOverLabel.setForeground(Color.GREEN);
                }
                gameOverLabel.setVisible(true);
                JLabel winLabel = new JLabel();
                winLabel.setAlignmentX(Component.CENTER_ALIGNMENT);
                guessPanel.add(winLabel);
                renderMovieBasics(result, winLabel);
              }

              guessHint.setText(update);
            }
          }
        }
      }

      @Override
      public void keyTyped(KeyEvent e) {}

      @Override
      public void keyPressed(KeyEvent e) {}

    });
    guess.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e)
      {
        if (textGuess.getText().length() != 0 && !win) {
          if (lives > 0) {
            String userGuess = textGuess.getText().toLowerCase();
            textGuess.setText("");
            if (hangTitle.toLowerCase().contains(userGuess)) {
              correctGuesses.add(userGuess.charAt(0));
            } else {
              lives--;
              livesLabel.setText("" + lives);
            }

            String update = "";
            if (lives == 0) {
              gameOverLabel.setVisible(true);
              for (int i = 0; i < hangTitle.length(); i++) {
                if (i != 0) {
                  update += " ";
                }
                update += hangTitle.charAt(i);
              }
            } else {
              for (int i = 0; i < hangTitle.length(); i++) {
                if (i != 0) {
                  update += " ";
                }
                if (correctGuesses.contains(hangTitle.toLowerCase().charAt(i))) {
                  update += hangTitle.charAt(i);
                } else {
                  update += '_';
                }
              }
            }

            if (!update.contains("_")) {
              win = true;
            }

            if (win || lives == 0) {
              if (lives != 0) {
                gameOverLabel.setText("You Win!");
                gameOverLabel.setFont(new Font("Serif", Font.BOLD, 80));
                gameOverLabel.setForeground(Color.GREEN);
              }
              gameOverLabel.setVisible(true);
              JLabel winLabel = new JLabel();
              winLabel.setAlignmentX(Component.CENTER_ALIGNMENT);
              guessPanel.add(winLabel);
              renderMovieBasics(result, winLabel);
            }

            guessHint.setText(update);
          }
        }
      }
    });
    guessingPanel.add(guess);
    guessingPanel.add(livesLabel);
    JButton newGame = new JButton("New Game?");
    newGame.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e)
      {
        gameFrame.dispatchEvent(new WindowEvent(gameFrame, WindowEvent.WINDOW_CLOSING));
        win = false;
        lives = 5;
        buildGame();
      }
    });
    guessingPanel.add(newGame);
    game.add(guessingPanel, BorderLayout.SOUTH);


    gameWindow.add(game);
    gameFrame.pack();
    gameFrame.setExtendedState(JFrame.MAXIMIZED_BOTH);
    gameFrame.setVisible(true);
  }

  

  
  /**********************************************************
                         VISUAL METHODS
   **********************************************************/
  /*
   * Changes the text and poster for each of the renders.
   *
   * @param id the type of data being rendered (movie, actor, company)
   */
  protected void modifyRenders(int id, Result[] results)
  {
    if (results != null) {
      identity = id;
      for (int i = 0; i < RESULT_SIZE; i++)
      {
        renderMovieBasics(results[i], rendStorage[i]);
      }
    }
  }
  
  /*
   * Interprets the input of a searchBox to determine how to modify the results.
   * 
   * @param searchBox the text box to interpret
   */
  protected void interpretSearch(JTextField searchBox)
  {
    String text = searchBox.getText();
    if(text != null) {
      switch (searchOpt)
      {
        case "Movie":
          results = MovieSearches.getMoviesFromTitle(text);
          modifyRenders(0, results);
          break;
        case "Actor":
          results = MovieSearches.getActorsFromName(text);
          modifyRenders(1, results);
          break;
        case "Company":
          results = MovieSearches.getCompaniesFromName(text);
          modifyRenders(2, results);
          break;
      }
    }
  }

  /*
   * Takes a Result (movie, actor, or company) and builds its functionality in the main window.
   */
  protected void renderMovieBasics(Result result, JLabel render)
  {
    if (result != null)
    {
      try
      {
        // Gets ImageIcon from URL, then scales it
        ImageIcon poster = new ImageIcon(new ImageIcon(new URL(result.getImage())).getImage()
            .getScaledInstance(150, 250, Image.SCALE_SMOOTH));
        render.setIcon(poster); // Indirectly enables clicking for pop-up
      }
      catch (MalformedURLException e1)
      {
        render.setIcon(null); // Indirectly disables clicking for pop-up
      }
      render.setName(result.getId()); // Storage for pulling up detailed data later
      render.setText(String.format("%s - %s", result.getTitle(), result.getDescription()));
    }
    else {
    	render.setIcon(new ImageIcon());
    	render.setName(null);
    	render.setText("");
    }
  }
}