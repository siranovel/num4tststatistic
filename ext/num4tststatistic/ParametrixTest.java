import java.util.Arrays;
import org.apache.commons.math3.stat.descriptive.SummaryStatistics;
import org.apache.commons.math3.stat.correlation.PearsonsCorrelation;
public class ParametrixTest {
    private static ParametrixTest paramTest = new ParametrixTest();
        
    public static ParametrixTest getInstance() {
        return paramTest;
    }
    // 正規母集団の母平均の検定量
    public double populationMean(double[] xi, double m0) {
        int n = xi.length;
        SummaryStatistics stat = new SummaryStatistics();

        Arrays.stream(xi).forEach(stat::addValue);
        double m = stat.getMean();     // 平均
        double s2 = stat.getVariance();// 分散
        return (m - m0) / Math.sqrt(s2 / n);
    }
    // 正規母集団の母分散の検定量
    public double populationVar(double[] xi, double sig0) {
        int n = xi.length;
        SummaryStatistics stat = new SummaryStatistics();
        Arrays.stream(xi).forEach(stat::addValue);
        double s2 = stat.getVariance();// 分散
      
        return (n - 1) * s2 / sig0;
    }
    // 母比率の検定量
    public double populationRatio(int m, int n, double p0) {
        double p = (double)m / (double)n;
        return (p - p0) / Math.sqrt(p0 * (1-p0) / n);
    }
    // 2つの母平均の差の検定量
    // (等分散性を仮定)
    public double diffPopulationMean2EquVar(double[] xi1, double[] xi2) {
        int n1 = xi1.length;
        int n2 = xi2.length;
        SummaryStatistics stat1 = new SummaryStatistics();
        SummaryStatistics stat2 = new SummaryStatistics();
        Arrays.stream(xi1).forEach(stat1::addValue);
        Arrays.stream(xi2).forEach(stat2::addValue);

        double m1 = stat1.getMean();
        double m2 = stat2.getMean();
        double s12 = stat1.getVariance();// 分散
        double s22 = stat2.getVariance();// 分散
        double s2 = ((n1 - 1) * s12 + (n2 - 1) * s22) / (n1 + n2 - 2);

        return (m1 - m2) / Math.sqrt((1.0 / n1 + 1.0 / n2) * s2);
    }
    // 2つの母平均の差の検定量
    // (不等分散性を仮定)
    public double diffPopulationMean2UnEquVar(double[] xi1, double[] xi2) {
        int n1 = xi1.length;
        int n2 = xi2.length;
        SummaryStatistics stat1 = new SummaryStatistics();
        SummaryStatistics stat2 = new SummaryStatistics();
        Arrays.stream(xi1).forEach(stat1::addValue);
        Arrays.stream(xi2).forEach(stat2::addValue);

        double m1 = stat1.getMean();
        double m2 = stat2.getMean();
        double s12 = stat1.getVariance();// 分散
        double s22 = stat2.getVariance();// 分散

        return (m1 - m2) / Math.sqrt(s12 / n1 + s22 / n2);
    }
    // ウェルチ検定の為の自由度
    public int df4welch(double[] xi1, double[] xi2) {
        int n1 = xi1.length;
        int n2 = xi2.length;
        SummaryStatistics stat1 = new SummaryStatistics();
        SummaryStatistics stat2 = new SummaryStatistics();
        Arrays.stream(xi1).forEach(stat1::addValue);
        Arrays.stream(xi2).forEach(stat2::addValue);

        double s12 = stat1.getVariance();// 分散
        double s22 = stat2.getVariance();// 分散
        double s14 = s12 * s12;
        double s24 = s22 * s22;
        int n12 = n1 * n1;
        int n22 = n2 * n2;
        double ns = (s12 / n1) + (s22 / n2);

        return (int)
        (
           (ns * ns) / 
           (
             s14 / (n12 * (n1 - 1)) + s24 / (n22 * (n2 - 1))
           )
        );
    }
    // 対応のある2つの母平均の差の検定量
    public double diffPopulationMean(double[] xi1, double[] xi2) {
        int n = xi1.length;
        SummaryStatistics stat = new SummaryStatistics();

        for(int i = 0; i < n; i++) {
            stat.addValue(xi1[i] - xi2[i]);
        }
        double m = stat.getMean();
        double s2 = stat.getVariance();// 分散
      
        return (m - 0) / Math.sqrt(s2/n);
    }
    // 2つの母分散の差の検定量
    public double diffPopulationVar(double[] xi1, double[] xi2) {
        SummaryStatistics stat1 = new SummaryStatistics();
        SummaryStatistics stat2 = new SummaryStatistics();
        Arrays.stream(xi1).forEach(stat1::addValue);
        Arrays.stream(xi2).forEach(stat2::addValue);

        double s12 = stat1.getVariance();// 分散
        double s22 = stat2.getVariance();// 分散
        return s12 / s22;
    }
    // 2つの母比率の差の検定量
    public double diffPopulationRatio(int m1, int n1, int m2, int n2) {
        double p1 = (double)m1 / (double)n1;
        double p2 = (double)m2 / (double)n2;
        double p = (double)(m1 + m2) / (double)(n1 + n2);

        return (p1 - p2) / Math.sqrt(p * (1 - p) * (1.0 / n1 + 1.0 / n2));
    }
    // 無相関の検定量
    public double unCorrelation(double[] x, double[] y) {
        int n = x.length;
        PearsonsCorrelation corel = new PearsonsCorrelation();
        double r = corel.correlation(x, y);

        return r * Math.sqrt(n - 2.0) / Math.sqrt(1.0 - r * r);
    }
    // 母相関係数の検定量
    public double populationCorre(double[] x, double[] y, double rth0) {
        int n = x.length;
        PearsonsCorrelation corel = new PearsonsCorrelation();
        double r = corel.correlation(x, y);

        return Math.sqrt(n-3.0) * 
               (
               0.5 * Math.log((1.0 + r) / (1.0 - r)) 
             - 0.5 * Math.log((1.0 + rth0) / (1.0 - rth0))
               );
    }
    // 適合度の検定量
    public double fidelity(double[] fi, double[] pi) {
        double[] e = new double[fi.length];
        double t = 0.0;
        SummaryStatistics stat = new SummaryStatistics();

        Arrays.stream(fi).forEach(stat::addValue);
        double s = stat.getSum();

        for (int i = 0; i < fi.length; i++) {
            e[i] = s * pi[i];
            double f_e = fi[i] - e[i];
            t += f_e * f_e / e[i];
        }
        return t;
    }
    // 独立性の検定量
    public double independency(double[][] fij) {
        Independency indep = new Independency(fij);

        indep.calsCells();
        double t = indep.calcStatistic();

        return t;
    }
    private class Independency {
        private double[] fa = null;
        private double[] fb = null;
        private double[][] fij = null;
        private long n = 0;
        public Independency(double[][] fij) {
            fa = new double[fij.length];
            fb = new double[fij[0].length];
            this.fij = fij;
        }
        // 各セルの計算
        public void calsCells() {
            for (int i = 0; i < fij.length; i++) {
                fa[i] = 0.0;
                for (int j = 0; j < fij[i].length; j++)  {
                    fa[i] += fij[i][j];
                    fb[j] += fij[i][j];
                    n += fij[i][j];
                }
            }
        }
        // 検定統計量計算
        public double calcStatistic() {
            double t = 0.0;

            for (int i = 0; i < fij.length; i++) {
                for (int j = 0; j < fij[i].length; j++)  {
                    double f_e = n * fij[i][j] - fa[i] * fb[j];

                    t += f_e * f_e / (n * fa[i] * fb[j]);
                }
            }
            return t;
        }
    }
}

