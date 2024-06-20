package bettersort;

@FunctionalInterface
public interface Sorter<T extends Comparable<T>> {
  void sort(T[] items);
}
