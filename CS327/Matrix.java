/**
 * A simple m x n matrix class. 
 *
 * TODO All of the methods currently just return default values. You need to make them match the Javadoc comments. 
 * 
 * @author Robert Petro
 * @version March 30, 2023
 */

public class Matrix {
  
  private int m, n;
  private double[][] M;
  
  public Matrix(double[][] array) {
    M = array;
    n = array.length; 
    m = array[0].length; 
  }
  
  /**
   * @return The number of columns in the matrix. 
   */
  public int nCols() { return m; }
  
  /** 
   * @return the number of rows.
   */ 
  public int nRows() { return n; }
  
  /** 
   * @param i 
   * @param j
   * @return The entry at row i column j. 
   */
  public double entry(int i, int j) { 
    return M[i][j];
  }
  
  /**
   * Computes the dot product of this matrix with the parameter that. (Return value is this . that)
   * Recall that the dot product is the typical matrix multiplication. 
   * @param that The matrix to apply this matrix to. 
   * @throws BadDimensionException If this.nCols() != that.nRows() because the dot product is not defined
   * @return The dot product of this matrix with that. 
   */
  public Matrix dot(Matrix that) throws UndefinedMatrixOpException {
    if (this.nCols() != that.nRows()) {
        throw new UndefinedMatrixOpException("Bad Dimensions Exception - Matrix Multiplicaton", this, that);
    }
    
    double[][] results = new double[this.nRows()][that.nCols()];
    for(int i = 0; i < this.nRows(); i++) {    
      for(int j = 0; j < that.nCols(); j++) {      
        for(int k = 0; k < this.nRows(); k++) {
          results[i][j] += M[i][k] * that.entry(k, j);
        }
      }
    }
    return new Matrix(results);
  }
  
  /**
   * Add this matrix to that and returns the result. (Return value is this + that)
   * @param that the matrix to add this matrix to. 
   * @throws BadDimensionException If the dimension of the two matrices are not identical. 
   * @return The sum of the this and that. 
   */
   public Matrix plus(Matrix that) throws UndefinedMatrixOpException {
     if (this.nRows() != that.nRows() || this.nCols() != that.nCols()) {
       throw new UndefinedMatrixOpException("Bad Dimensions Exception - Matrix Additon", this, that);
     }
     
     double[][] results = new double[m][n];
     for (int i = 0; i < m; i++) {
       for (int j = 0; j < n; j++) {
         results[i][j] = M[i][j] + that.entry(i, j);
       }
     }
     return new Matrix(results);
   }
   
   /**
    * @param theta The rotation angle. 
    * @return The homogeneous rotation matrix for a given value for theta. 
    */ 
   public static Matrix rotationH2D(double theta) {
     double[][] R = {{Math.cos(theta), -Math.sin(theta), 0}, {Math.sin(theta), Math.cos(theta), 0}, {0, 0, 1}};
     return new Matrix(R);
   }
   
   /**
    * @param tx The amount to translate in the x direction. 
    * @param ty The amount to translate in the y direction. 
    * @return The matrix representing a translation of tx, ty. 
    */
   public static Matrix translationH2D(double tx, double ty) {
     double[][] T = {{1, 0, tx}, 
                     {0, 1, ty}, 
                     {0, 0, 1}};
     return new Matrix(T);
   }
   
   /**
    * @param x The x coordinate
    * @param y The y coordinate
    * @return The column matrix representing in homogeneous coordinates the point (x, y). 
    */
   public static Matrix vectorH2D(double x, double y) {
     double[][] V = {{x}, {y}};
     return new Matrix(V);
   }
   
   /** 
    * @param n The dimension of the matrix. Recall that the identity matrix has 1's for any entry that is in the same row index as its column index, 0's everywhere else. 
    * @return the nxn identity matrix
    */
   public static Matrix identity(int n) {
     double[][] results = new double[n][n];
     for (int i = 0; i < n; i++) {
       for (int j = 0; j < n; j++) {
         if (i == j) {
           results[i][j] = 1;
         } else {
           results[i][j] = 0;
         }
       }
     }
     return new Matrix(results);
   }
   
   /**
    * Computes the mxn identity matrix which has 1's for every entry at the same row and column index and 
    * 0 for all other entries. 
    * @param m
    * @param n 
    * @return the mxn identity matrix. 
    */
    public static Matrix identity(int m, int n) {
      double[][] results = new double[m][n];
     for (int i = 0; i < m; i++) {
       for (int j = 0; j < n; j++) {
         if (i == j) {
           results[i][j] = 1;
         } else {
           results[i][j] = 0;
         }
       }
     }
     return new Matrix(results);
    }
    
    /** 
     * A little helpful toString() in case you want to print your matrix to System.out
     */
    public String toString() {
      StringBuilder sb = new StringBuilder();
      for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
          sb.append(M[i][j]);
          sb.append('\t');
        }
        sb.append('\n');
      }
      return sb.toString();
    }
}
