import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;



public class SmokeRunner {
  @Test
  public void testSmoke() {

    Results results = Runner.path(
            "classpath:scripts/contacts","classpath:scripts/company"
    ).parallel(4);


    Assertions.assertTrue(results.getFailCount() == 0,results.getErrorMessages());

    //return Karate.run("classpath:scripts/company").tags("@smoke").relativeTo(getClass()).parallel(2);
  }


//  @Karate.Test
//  Karate testSample() {
//    return Karate.run("classpath:AllFeatures/Users").relativeTo(getClass());
//  }
//
}
