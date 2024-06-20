package bettersort;

import java.util.Random;

/**
 * Introspective Sort.
 */
public class IntrospectiveSort {
  /**
   * Introspective Sort starts as quick sort,
   * then moves to adaptive merge sort when depth exceeds 2(log(N)).
   *
   * @param items list of items being sorted
   * @param <T> objects being sorted that extends comparable
   */
  public static <T extends Comparable<T>> void introspectiveSort(T[] items) {
    int depthLimit = (int) (2 * Math.floor(Math.log(items.length) / Math.log(2)));
    introspectiveSort(items, 0, items.length - 1, depthLimit);
  }

  private static <T extends Comparable<T>> void introspectiveSort(
              T[] items, int left, int right, int depthLimit) {
    if (left < right) {
      if (depthLimit == 0) {
        MergeSortImproved.mergeSubsortAdaptive(items, left, right);
      } else {
        depthLimit = depthLimit - 1;
        int lastSmallIndex = partition(items, left, right);
        introspectiveSort(items, left, lastSmallIndex, depthLimit);
        introspectiveSort(items, lastSmallIndex + 1, right, depthLimit);
      }
    }
  }

  private static <T extends Comparable<T>> int partition(T[] items, int left, int right) {
    int pivotIndex = left + (right - left) / 2;
    T pivot = items[pivotIndex];

    // Advance from both ends until window collapses.
    boolean isDone = false;
    while (!isDone) {
      // Skip rightward past < pivots.
      while (items[left].compareTo(pivot) < 0) {
        left++;
      }

      // Skip leftward past > pivots.
      while (items[right].compareTo(pivot) > 0) {
        right--;
      }

      if (left < right) {
        BasicSorts.swap(items, left, right);
        left++;
        right--;
      } else {
        isDone = true;
      }
    }

    return right;
  }
}
