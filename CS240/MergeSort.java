package bettersort;

/**
 * Merge sort class.
 */
public class MergeSort {
  /**
   * Merge sort the provided array.
   */
  @SuppressWarnings("unchecked")
  public static <T extends Comparable<T>> void mergeSort(T[] items) {
    // Unfortunately, it is not possible to create an array of Ts, this is the
    // workaround.
    T[] tmps = (T[]) new Comparable[items.length];
    mergeSort(items, tmps, 0, items.length - 1);
  }

  /**
   * Recursive helper method for the merge sort algorithm.
   * 
   * @param items The array to sort
   * @param tmps Temporary array for merge operation
   * @param left Index of the left end of the region to sort
   * @param right Index of the right end of the region to sort.
   */
  private static <T extends Comparable<T>> void mergeSort(T[] items, T[] tmps, int left, int right) {
    if (left < right) {
      int mid = (left + right) / 2;
      mergeSort(items, tmps, left, mid);
      mergeSort(items, tmps, mid + 1, right);
      merge(items, tmps, left, mid, right);
    }
  }

  /**
   * Merge two sorted sub-arrays.
   */
  private static <T extends Comparable<T>> void merge(T[] items, T[] tmps, int left, int mid, int right) {
    // Copy items to temporary array since we're about to
    // chaotically reorganize the original.
    for (int i = left; i <= right; ++i) {
      tmps[i] = items[i];
    }

    int i = left;
    int leftIndex = left;
    int rightIndex = mid + 1;

    // Compare heads until one subarray is empty.
    for (; leftIndex <= mid && rightIndex <= right; ++i) {
      if (tmps[leftIndex].compareTo(tmps[rightIndex]) <= 0) {
        items[i] = tmps[leftIndex];
        ++leftIndex;
      } else {
        items[i] = tmps[rightIndex];
        ++rightIndex;
      }
    }

    // Copy over remainder of left subarray.
    for (; leftIndex <= mid; ++leftIndex, ++i) {
      items[i] = tmps[leftIndex];
    }

    // Copy over remainder of right subarray.
    for (; rightIndex <= right; ++rightIndex, ++i) {
      items[i] = tmps[rightIndex];
    }
  }
}
