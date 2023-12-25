import java.util.Arrays;

import org.apache.commons.math3.stat.descriptive.SummaryStatistics;
public class TstStatistic {
    public static double grubbs(double[] xi, double xk) {
        SummaryStatistics stat = new SummaryStatistics();

        Arrays.stream(xi).forEach(stat::addValue);
        double m = stat.getMean();     // 平均
        double sd = stat.getStandardDeviation();// 標準偏差
        double min = stat.getMin();
        double max = stat.getMax();
        double t = 0.0;

        if (xk == min) { t = (m - xk) / sd; }
        if (xk == max) { t = (xk - m) / sd; }
        return t;
    }
}


