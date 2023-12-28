import java.util.Arrays;

import org.apache.commons.math3.stat.inference.WilcoxonSignedRankTest;
import org.apache.commons.math3.stat.inference.MannWhitneyUTest;
import org.apache.commons.math3.stat.correlation.SpearmansCorrelation;
import org.apache.commons.math3.stat.correlation.KendallsCorrelation;

import org.apache.commons.math3.stat.inference.TestUtils;
public class NonParametrixTest {
    private static NonParametrixTest nonParamTest = new NonParametrixTest();
    public static NonParametrixTest getInstance() {
        return nonParamTest;
    }
    
    // ウィルコクス符号付き順位検定
    public double wilcoxon(double[] x, double[] y) {
        int n = x.length;
        WilcoxonSignedRankTest wilcox = new WilcoxonSignedRankTest();
        double w = wilcox.wilcoxonSignedRank(x, y); 
        double e_w = n * (n  + 1.0) / 4.0;
        double var_w = n * (n + 1.0) * (2.0 * n + 1.0) / 24.0;

        return (w - e_w) / Math.sqrt(var_w); 
    }
    // マン・ホイットニーのU検定
    public double utest(double[] x, double[] y) {
        int n1 = x.length;
        int n2 = y.length;
        MannWhitneyUTest utest = new MannWhitneyUTest();
        double u = utest.mannWhitneyU(x, y);
        double e_u = n1 * n2 / 2.0;
        double var_u = (n1 * n2 * (n1 + n2 + 1.0)) / 12.0;

        return (u - e_u) / Math.sqrt(var_u);
    }
    // スピアマンの順位相関係数
    public double spearmanscorr(double[] x, double[] y) {
        SpearmansCorrelation speamans = new SpearmansCorrelation();

        return speamans.correlation(x, y);
    }
    // ケンドールの順位相関係数
    public double kendallscorr(double[] x, double[] y) {
        KendallsCorrelation kendalls = new KendallsCorrelation();

        return kendalls.correlation(x, y);
    }
    // コルモゴルフ・スミルノフ検定(2標本)
    public boolean ks2test(double[] xi1, double[] xi2, double a) {
        double p = TestUtils.kolmogorovSmirnovTest(xi1, xi2);

        return (p < a) ? true : false;
    }
}

