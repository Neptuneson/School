import java.awt.Image;
import java.net.MalformedURLException;
import java.net.URL;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

public class MovieFunctions
{
  
  /*
   * Takes a Result (movie, actor, or company) and builds its functionality in the main window.
   */
  protected static void renderMovieBasics(Result result, JLabel render)
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
  }
  
  /*
   * Creates a pop-up window featuring the details of a Movie.
   * 
   * @param movie the Movie to pull from
   */
  public static void popUpMovieInfo(Movie movie)
  {
      // displays movie poster
      if (movie != null)
      {
        try
        {
          ImageIcon moviePoster = new ImageIcon(new ImageIcon(new URL(movie.getImage())).getImage()
              .getScaledInstance(300, 500, Image.SCALE_SMOOTH)); // Gets ImageIcon from URL, then scales it
          String info = String.format("%s\n\n%s\n%s\nCritics give this movie: %s\n%s\n\nStarring: \n",
              movie.getPlot(), movie.getGenres(), movie.getContentRating(), movie.getImDbRating(),
              movie.getRunTime());
          String[][] actors = movie.getActors();
          for (int i = 0; i < actors.length && i < 4; i++) {
            info += actors[i][2] +"\n";
          }
          JOptionPane.showMessageDialog(null, "<html><body><p style='width: 200px;'>"+info, movie.getTitle(),
              JOptionPane.INFORMATION_MESSAGE, moviePoster);
        }
        catch (MalformedURLException e1) {}
      }
  }

  /*
   * Creates a pop-up window featuring the details of an Actor.
   * 
   * @param actor the Actor to pull from
   */
  public static void popUpActorInfo(Actor actor)
  {
    // displays movie poster
    if (actor != null)
    {
      try
      {
        ImageIcon actorImage = new ImageIcon(new ImageIcon(new URL(actor.getImage())).getImage()
            .getScaledInstance(300, 500, Image.SCALE_SMOOTH)); // Gets ImageIcon from URL, then scales it
        String[] days = new String[] {"Born: Unlisted", ""}; // Birthday and Death-day
        if (!(actor.getBirthDate().equals("null"))) {
          days[0] = "Born: " + actor.getBirthDate();
        }
        if (!(actor.getDeathDate().equals("null")))
        {
          days[1] = " - Died: " + actor.getDeathDate();
        }
        String info = String.format("%s\n%s\n%s%s\n%s\n\nKnown for: \n", actor.getName(), actor.getRole(),
            days[0], days[1], actor.getAwards());
        String[][] knownFor = actor.getKnownFor();
        for (int i = 0; i < knownFor.length && i < 4; i++)
        {
          info += knownFor[i][1] + "\n";
        }
        JOptionPane.showMessageDialog(null, "<html><body><p style='width: 200px;'>" + info,
            actor.getName(), JOptionPane.INFORMATION_MESSAGE, actorImage);
      }
      catch (MalformedURLException e1) {}
    }
  }

}
