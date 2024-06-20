package bettersort;

@FunctionalInterface
public interface Generator {
  Integer[] generate(int size);
}
