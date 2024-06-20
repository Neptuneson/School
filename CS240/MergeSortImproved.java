package bettersort;

import java.util.Random;

/**
 * Improved Merge Sort class.
 */
public class MergeSortImproved {

  /**
   * Merge sort the provided array using an improved merge operation.
   *
   * @param items list of items being sorted
   * @param <T> object being sorted that extends comparable
   */
  public static <T extends Comparable<T>> void mergeSortHalfSpace(T[] items) {
    T[] temps = (T[]) new Comparable[items.length + 1 / 2];
    mergeSortHalfSpace(items, temps, 0, items.length - 1);
  }

  private static <T extends Comparable<T>> void mergeSortHalfSpace(T[] items,
                                                                   T[] temps, int left, int right) {
    if (left < right) {
      int mid = (left + right) / 2;
      mergeSortHalfSpace(items, temps, left, mid);
      mergeSortHalfSpace(items, temps, mid + 1, right);
      mergeHalfSpace(items, temps, left, mid, right);
    }
  }

  private static <T extends Comparable<T>> void mergeHalfSpace(T[] items,
                                                      T[] temps, int left, int mid, int right) {
    int j = 0;
    for (int i = left; i <= mid; i++) {
      temps[j] = items[i];
      j++;
    }

    int tempIndex = 0;
    int mergeIndex = left;
    int rightIndex = mid + 1;

    while (tempIndex < j && rightIndex <= right) {
      if (temps[tempIndex].compareTo(items[rightIndex]) <= 0) {
        items[mergeIndex] = temps[tempIndex];
        tempIndex++;
        mergeIndex++;
      } else {
        items[mergeIndex] = items[rightIndex];
        rightIndex++;
        mergeIndex++;
      }
    }

    while (tempIndex < j) {
      items[mergeIndex] = temps[tempIndex];
      tempIndex++;
      mergeIndex++;
    }

    while (rightIndex <= right) {
      items[mergeIndex] = items[rightIndex];
      rightIndex++;
      mergeIndex++;
    }
  }

  /**
   * Merge sort the provided array by using an improved merge operation and
   * switching to insertion sort for small sub-arrays.
   *
   * @param items list of items being sorted
   * @param <T> object being sorted that extends comparable
   */
  public static <T extends Comparable<T>> void mergeSortAdaptive(T[] items) {
    mergeSubsortAdaptive(items, 0, items.length - 1);
  }

  /**
   * Merge sort the provided sub-array using our improved merge sort. This is the
   * fallback method used by introspective sort.
   *
   * @param items list of items being sorted
   * @param <T> object being sorted that extends comparable
   * @param start left end of sub array being sorted
   * @param end right end of sub array being sorted
   */
  public static <T extends Comparable<T>> void mergeSubsortAdaptive(T[] items, int start, int end) {
    //85 gives 0.00068114
    final int threshold = 79;
    if (end - start <= threshold) {
      BasicSorts.insertionSubsort(items, start, end);
    } else {
      T[] temps = (T[]) new Comparable[items.length / 2];
      int mid = (start + end) / 2;
      mergeSubsortAdaptive(items, start, mid);
      mergeSubsortAdaptive(items, mid + 1, end);
      mergeHalfSpace(items, temps, start, mid, end);
    }
  }
}
