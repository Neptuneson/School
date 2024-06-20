import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;

public class affine {
  public static void main(String[] args) throws IOException {
    if (args[0].equalsIgnoreCase("encrypt")) {
      affineEncrypt(new File(args[1]), new File(args[2]), Integer.parseInt(args[3]), Integer.parseInt(args[4]));
    } else if (args[0].equalsIgnoreCase("decrypt")) {
      affineDecrypt(new File(args[1]), new File(args[2]), Integer.parseInt(args[3]), Integer.parseInt(args[4]));
    } else if (args[0].equalsIgnoreCase("decipher")) {
      affineDecipher(new File(args[1]), new File(args[2]), new File(args[3]));
    }
  }

  private static void affineEncrypt(File plaintextFile, File outputFile, int a, int b) throws IOException {
    if (!validKeys(a, b)) {
      System.out.printf("The key pair (%d, %d) is invalid, please select another key.", a, b);
    } else {
      BufferedInputStream bis = new BufferedInputStream(new FileInputStream(plaintextFile));
      BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(outputFile));
      byte[] bytes = bis.readAllBytes();
      for (byte m: bytes) {
        bos.write((a * m + b) % 128);
      }
      bis.close();
      bos.close();
    }
  }

  private static void affineDecrypt(File cyphertextFile, File outputFile, int a, int b) throws IOException {
    if (!validKeys(a, b)) {
      System.out.printf("The key pair (%d, %d) is invalid, please select another key.", a, b);
    } else {
      BufferedInputStream bis = new BufferedInputStream(new FileInputStream(cyphertextFile));
      BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(outputFile));
      byte[] bytes = bis.readAllBytes();
      for (byte c: bytes) {
        bos.write((multiInverse(a) * (c - b)) % 128);
      }
      bis.close();
      bos.close();
    }
  }

  private static void affineDecipher(File cyphertextFile, File outputFile, File dictionary) throws IOException {
    int mostWords = 0;
    int a = 0;
    int b = 0;
    for (int i = 1; i < 128; i++) {
      for (int j = 0; j < 128; j++) {
        if (validKeys(i, j)) {
          int wordCount = 0;
          affineDecrypt(cyphertextFile, outputFile, i, j);
          Scanner dictScan = new Scanner(dictionary);
          Scanner outputScan = new Scanner(outputFile);
          while(outputScan.hasNext()) {
            String word = outputScan.next().replaceAll("[-+.^:,()#@]","");
            while(dictScan.hasNext()) {
              if (word.compareToIgnoreCase(dictScan.next()) == 0) {
                wordCount++;
              }
            }
          }
          if (wordCount > mostWords) {
            mostWords = wordCount;
            a = i;
            b = j;
          }
          dictScan.close();
          outputScan.close();
        }
      }
    }

    String output = "";
    affineDecrypt(cyphertextFile, outputFile, a, b);
    Scanner outputScan = new Scanner(outputFile);
    while(outputScan.hasNext()) {
      output += " " + outputScan.next();
    }
    System.out.printf("%d %d\nDECIPHERED MESSAGE:\n%s\n", a, b, output);
  }

  private static boolean validKeys(int a, int b) {
    if (a != 0 && gcd(a, 128) == 1) {
      return true;
    }
    return false;
  }

  private static int gcd(int a, int b) {
    if (b == 0) {
      return a;
    }
    return gcd(b, a%b);
  }

  private static int multiInverse(int a) {
    for (int i = 0; i < 128; i++) {
      int value = (a * i) % 128;
      if (value == 1) {
        return i;
      }
    }
    return -1;
  }
}
