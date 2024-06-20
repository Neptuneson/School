import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;

public class CompanyTest {
	public Result company;
	
	@BeforeEach
	public void setup() {
		company = new Result("co0040846", "Warner Bross Marte Films", "", "");
	}
	
	@Test
	public void getIdTest() {
		assertEquals("co0040846", company.getId());
	}
	
	@Test
	public void getNameTest() {
		assertEquals("Warner Bross Marte Films", company.getTitle());
	}
	
	@Test
	public void getDescriptionTest() {
		assertEquals("", company.getDescription());
	}
}
