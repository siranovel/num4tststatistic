import java.util.Arrays;

import org.apache.commons.math3.stat.inference.WilcoxonSignedRankTest;
import org.apache.commons.math3.stat.inference.MannWhitneyUTest;

public class NonParametrixTest {
    private static NonParametrixTest nonParamTest = new NonParametrixTest();
    public static NonParametrixTest getInstance() {
        return nonParamTest;
    }
    
    // ウィルコクス符号付き順位検定
    public double wilcoxon(double[] x, double[] y) {
        WilcoxonSignedRankTest wilcox = new WilcoxonSignedRankTest();

        return wilcox.wilcoxonSignedRank(x, y); 
    }
    // マン・ホイットニーのU検定
    public double utest(double[] x, double[] y) {
        MannWhitneyUTest utest = new MannWhitneyUTest();

        return utest.mannWhitneyU(x, y);
    }
}

