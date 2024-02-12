import org.jfree.chart.ChartFactory;
import org.jfree.chart.StandardChartTheme;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.StandardChartTheme;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.data.statistics.BoxAndWhiskerCategoryDataset;
import org.jfree.data.statistics.DefaultBoxAndWhiskerCategoryDataset;
import org.jfree.data.statistics.BoxAndWhiskerCalculator;
import org.jfree.data.statistics.BoxAndWhiskerItem;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.chart.renderer.category.BoxAndWhiskerRenderer;
import org.jfree.chart.labels.BoxAndWhiskerToolTipGenerator;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.DatasetRenderingOrder;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.chart.labels.StandardCategoryToolTipGenerator;

import org.jfree.chart.ChartUtils;
import java.io.File;
import java.io.IOException;

import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;

import org.apache.commons.math3.stat.descriptive.SummaryStatistics;
public class Outlier {
    private static Outlier outlier = new Outlier();
    public static Outlier getInstance() {
        return outlier;
    }
    public double grubbs(double[] xi, double xk) {
        Grubbs g = new Grubbs();

        return g.calcStatistics(xi, xk);
    }
    
    public void errbar(String dname, double[] xi) {
        ChartPlot plot = new ErrorBarChartPlot();
        JFreeChart chart = plot.createChart("エラーバー", dname, xi);

        plot.writeJPEG("errbar.jpeg", chart, 800, 500);        
        
    }
    /*********************************/
    /* interface define              */
    /*********************************/
    private interface ChartPlot {
        JFreeChart createChart(String title, String dname, double[] xi);
        default void writeJPEG(String fname, JFreeChart chart, int width, int height) {
            File file = new File(fname);
            try {
                ChartUtils.saveChartAsJPEG(file, chart, width, height);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    private interface CreatePlot {
        CategoryPlot createPlot(String dname, double[] xi);
    }
    /*********************************/
    /* Class define                  */
    /*********************************/
    // 
    private class Grubbs {
        private SummaryStatistics stat = new SummaryStatistics();
        public double calcStatistics(double[] xi, double xk) {
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
    // error bar
    private class ErrorBarChartPlot implements ChartPlot{
        public JFreeChart createChart(String title, String dname, double[] xi) {
            CategoryPlot plot = createPlot(dname, xi);

            ChartFactory.setChartTheme(StandardChartTheme.createLegacyTheme());
            JFreeChart chart = new JFreeChart(title, plot);

            ChartUtils.applyCurrentTheme(chart);
            return chart;
        }
        private CategoryPlot createPlot(String dname, double[] xi) {
            CreatePlot plotImpl = new ErrorBarPlot();

            return plotImpl.createPlot(dname, xi);
        }
        public class ErrorBarPlot implements CreatePlot {
            public CategoryPlot createPlot(String dname, double[] xi) {
                BoxAndWhiskerRenderer renderer0 = new BoxAndWhiskerRenderer();
                LineAndShapeRenderer renderer1 = new LineAndShapeRenderer(false, true);

                renderer0.setDefaultToolTipGenerator(new BoxAndWhiskerToolTipGenerator());
                renderer0.setMaximumBarWidth(0.2);
                renderer1.setDefaultToolTipGenerator(
                    new StandardCategoryToolTipGenerator());
 
                CategoryPlot plot = new CategoryPlot();
                plot.setOrientation(PlotOrientation.VERTICAL);
                plot.mapDatasetToRangeAxis(0,0);
                plot.mapDatasetToRangeAxis(1,0);
	        plot.setDatasetRenderingOrder(DatasetRenderingOrder.FORWARD);

                /*--- 横軸 ---*/
                CategoryAxis categoryAxis = new CategoryAxis();
                plot.setDomainAxis(categoryAxis);

                /*--- 縦軸 ---*/
                NumberAxis valueAxis = new NumberAxis();
                valueAxis.setAutoRangeIncludesZero(false);
                plot.setRangeAxis(valueAxis);
                
                plot.setRenderer(0, renderer0);
                plot.setDataset(0, createDataset0(dname, xi));
                plot.setRenderer(1, renderer1);
                plot.setDataset(1, createDataset1(dname, xi));

                return plot;
            }
            private CategoryDataset createDataset0(String dname, double[] xi) {
                DefaultBoxAndWhiskerCategoryDataset data = 
                    new DefaultBoxAndWhiskerCategoryDataset();
                List<Double> values = new ArrayList<Double>();
                Arrays.stream(xi).forEach(values::add);

                BoxAndWhiskerItem item = 
                    BoxAndWhiskerCalculator.calculateBoxAndWhiskerStatistics(values);

                data.add(item, dname, "dt1");
                return data;
            }
            private CategoryDataset createDataset1(String dname, double[] xi) {
                DefaultCategoryDataset data = new DefaultCategoryDataset();
                SummaryStatistics stat = new SummaryStatistics();
                List<Double> values = new ArrayList<Double>();

                Arrays.stream(xi).forEach(stat::addValue);
                Arrays.stream(xi).forEach(values::add);

                BoxAndWhiskerItem item = 
                    BoxAndWhiskerCalculator.calculateBoxAndWhiskerStatistics(values);
                double minQ = ((Double)item.getMinOutlier()).doubleValue();
                double min = stat.getMin();
                double maxQ = ((Double)item.getMaxOutlier()).doubleValue();
                double max = stat.getMax();

                if (min < minQ) { data.addValue(min, "外れ値", "dt1"); };
                if (max > maxQ) { data.addValue(max, "外れ値", "dt1"); };
                return data;
            }
        }
    }
}


