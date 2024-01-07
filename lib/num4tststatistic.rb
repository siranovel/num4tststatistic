require 'java'
require 'num4tststatistic.jar'
require 'commons-math3-3.6.1.jar'
require 'jfreechart-1.5.4.jar'

java_import 'Outlier'
java_import 'ParametrixTest'
java_import 'NonParametrixTest'

# 検定統計量を計算
#  (Apache commoms math3使用)
module Num4TstStatisticLib
    class ParametrixTestLib
        def initialize
            @paramTest = ParametrixTest.getInstance()
        end
        # 正規母集団の母平均の検定量
        #
        # @overload populationMean(xi, m0)
        #   @param  [Array]  xi データ(double[])
        #   @param  [double] m0 母平均
        #   @return [double] 検定統計量
        # @example
        #   xi = [15.5, 15.7, 15.4, 15.4, 15.6, 15.4, 15.6, 15.5, 15.4]
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.populationMean(xi, 15.4)
        #   => 2.683
        # @note
        #   自由度(N-1)のt分布に従う
        def populationMean(xi, m0)
            return @paramTest.populationMean(xi.to_java(Java::double), m0)
        end
        # 正規母集団の母分散の検定量
        #
        # @overload populationVar(xi, sig0)
        #   @param  [Array]  xi データ(double[])
        #   @param  [double] sig0 母分散
        #   @return [double] 検定統計量
        # @example
        #   xi = xi = [35.2, 34.5, 34.9, 35.2, 34.8, 35.1, 34.9, 35.2, 34.9, 34.8]
        #   sd = 0.4
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.populationVar(xi, sd*sd)
        #   => 2.906
        # @note
        #   自由度(N-1)の階2乗分布に従う
        def populationVar(xi, sig0)
            return @paramTest.populationVar(xi.to_java(Java::double), sig0)
        end
        # 母比率の検定量
        #
        # @overload populationRatio(m, n, p0)
        #   @param [int]     m m値
        #   @param [int]     n N値
        #   @param [double]  p0 母比率
        #   @return [double] 検定統計量
        # @example
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.populationRatio(29, 346, 0.12)
        #   => -2.071
        # @note
        #   標準正規分布 N(0,1*1)に従う
        def populationRatio(m, n, p0)
            return @paramTest.populationRatio(m, n, p0)
        end
        # 2つの母平均の差の検定量
        # (等分散性を仮定)
        #
        # @overload diffPopulationMean2EquVar(xi1, xi2)
        #   @param [Array] xi1 x1のデータ(double[])
        #   @param [Array] xi2 x2のデータ(double[])
        #   @return [double] 検定統計量
        # @example
        #   xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.diffPopulationMean2EquVar(xi1, xi2)
        #   => -1.765
        # @note
        #   N1+N2-2のt分布に従う
        def diffPopulationMean2EquVar(xi1, xi2)
            return @paramTest.diffPopulationMean2EquVar(
                xi1.to_java(Java::double), xi2.to_java(Java::double)
            )
        end
        # 2つの母平均の差の検定量
        # (不等分散性を仮定)
        #
        # @overload diffPopulationMean2UnEquVar(xi1, xi2)
        #   @param [Array] xi1 x1のデータ(double[])
        #   @param [Array] xi2 x2のデータ(double[])
        #   @return [double] 検定統計量
        # @example
        #   xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.diffPopulationMean2UnEquVar(xi1, xi2)
        #   => -1.636
        # @note
        #   df4welch関数で求めた自由度のt分布に従う
        def diffPopulationMean2UnEquVar(xi1, xi2)
            return @paramTest.diffPopulationMean2UnEquVar(
                xi1.to_java(Java::double), xi2.to_java(Java::double)
            )
        end
        # ウェルチ検定の為の自由度
        #
        # @overload df4welch(xi1, xi2)
        #   @param [Array] xi1 x1のデータ(double[])
        #   @param [Array] xi2 x2のデータ(double[])
        #   @return [int] 自由度
        # @example
        #   xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.df4welch(xi1, xi2)
        #   => 11
        def df4welch(xi1, xi2)
            return @paramTest.df4welch(
                xi1.to_java(Java::double), xi2.to_java(Java::double)
            )
        end
        # 対応のある2つの母平均の差の検定量
        #
        # @overload diffPopulationMean(xi1, xi2)
        #   @param [Array] xi1 x1のデータ(double[])
        #   @param [Array] xi2 x2のデータ(double[])
        #   @return [double] 検定統計量
        # @example
        #   xi1 = [37.1, 36.2, 36.6, 37.4, 36.8, 36.7, 36.9, 37.4, 36.6, 36.7]
        #   xi2 = [36.8, 36.6, 36.5, 37.0, 36.0, 36.5, 36.6, 37.1, 36.4, 36.7]
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.diffPopulationMean(xi1, xi2)
        #   => 2.283
        # @note
        #   自由度(N-1)のt分布に従う
        def diffPopulationMean(xi1, xi2)
            return @paramTest.diffPopulationMean(
                xi1.to_java(Java::double), xi2.to_java(Java::double)
            )
        end
        # 2つの母分散の差の検定量
        #
        # @overload diffPopulationVar(xi1, xi2)
        #   @param [Array] xi1 x1のデータ(double[])
        #   @param [Array] xi2 x2のデータ(double[])
        #   @return [double] 検定統計量
        # @example
        #   xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.diffPopulationVar(xi1, xi2)
        #   => 0.4727
        # @note
        #   自由度(N1-1,N2-1)のF分布に従う
        def diffPopulationVar(xi1, xi2)
            return @paramTest.diffPopulationVar(
                xi1.to_java(Java::double), xi2.to_java(Java::double)
            )
        end
        # 2つの母比率の差の検定量
        #
        # @overload diffPopulationRatio(m1, n1, m2, n2)
        #   @param [int] m1 m1値
        #   @param [int] n1 N1値
        #   @param [int] m2 m2値
        #   @param [int] n2 N2値
        #   @return [double] 検定統計量
        # @example
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.diffPopulationRatio(469, 1200, 308, 900)
        #   => 2.283
        # @note
        #   標準正規分布 N(0,1*1)に従う
        def diffPopulationRatio(m1, n1, m2, n2)
            return @paramTest.diffPopulationRatio(m1, n1, m2, n2)
        end
        # ピアソン相関係数
        #  (相関係数の検定)
        #
        # @overload pearsoCorrelation(x, y)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @return [double] 相関係数
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.pearsoCorrelation(x, y)
        #   => 3.1035
        def pearsoCorrelation(x, y)
            return @paramTest.pearsoCorrelation(
                x.to_java(Java::double), y.to_java(Java::double)
            )
        end
        # 適合度の検定量
        #
        # @overload fidelity(fi, pi)
        #   @param [Array] fi 実測度数(double[])
        #   @param [Array] pi 比率(double[])
        #   @return [double] 検定統計量
        # @example
        #   fi = [57, 33, 46, 14]
        #   pi = [0.4, 0.2, 0.3, 0.1]
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.fidelity(fi, pi)
        #   => 0.5389
        # @note
        #   自由度(n-1)の階２乗分布に従う
        def fidelity(fi, pi)
            return @paramTest.fidelity(fi.to_java(Java::double), pi.to_java(Java::double))
        end
        # 独立性の検定量
        #
        # @overload independency(fij)
        #   @param [Array] fij 実測度数(double[][])
        #   @return [double] 検定統計量
        # @example
        #   fij = [
        #     [57, 33, 46, 14],
        #     [89, 24, 75, 12],
        #   ]
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        #   paraTest.independency(fij)
        #   => 8.5711
        # @note
        #   自由度(m-1)(n-1)の階２乗分布に従う
        def independency(fij)
            return @paramTest.independency(fij.to_java(Java::double[]))
        end
    end
    class NonParametrixTestLib
        def initialize
            @nonParamTest = NonParametrixTest.getInstance()
        end
        # マン・ホイットニーのU検定
        #
        # @overload utest(x, y)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @return [double] 検定統計量
        # @example
        #   x = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   y = [180, 180, 235, 270, 240, 285, 164, 152]
        #   nonParaTest = Num4TstStatisticLib::NonParametrixTestLib.new
        #   nonParaTest.utest(x, y)
        #   => 63.0
        # @note
        #   近似的に標準正規分布 N(0,1*1)に従う
        def utest(x, y)
            return @nonParamTest.utest(x.to_java(Java::double), y.to_java(Java::double))
        end
        # ウィルコクス符号付き順位検定
        #
        # @overload wilcoxontest(x, y)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @return [double] 検定統計量
        # @example
        #   x = [37.1, 36.2, 36.6, 37.4, 36.8, 36.7, 36.9, 37.4, 36.6, 36.7]
        #   y = [36.8, 36.6, 36.5, 37.0, 36.0, 36.5, 36.6, 37.1, 36.4, 36.7]
        #   nonParaTest = Num4TstStatisticLib::NonParametrixTestLib.new
        #   nonParaTest.wilcoxon(x, y)
        #   => 46.5
        # @note
        #   近似的に標準正規分布 N(0,1*1)に従う
        def wilcoxon(x, y)
            return @nonParamTest.wilcoxon(x.to_java(Java::double), y.to_java(Java::double))
        end
        # スピアマンの順位相関係数
        #
        # @overload spearmanscorr(x, y)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @return [double] 相関係数
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   nonParaTest = Num4TstStatisticLib::NonParametrixTestLib.new
        #   nonParaTest.spearmanscorr(x, y)
        #   => 0.745
        # @note
        #   無相関検定
        def spearmanscorr(x, y)
            return @nonParamTest.spearmanscorr(x.to_java(Java::double), y.to_java(Java::double))
        end
        # ケンドールの順位相関係数
        #
        # @overload kendallscorr(x, y)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @return [double] 相関係数
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   nonParaTest = Num4TstStatisticLib::NonParametrixTestLib.new
        #   nonParaTest.kendallscorr(x, y)
        #   => 0.592
        # @note
        #   無相関検定
        def kendallscorr(x, y)
            return @nonParamTest.kendallscorr(x.to_java(Java::double), y.to_java(Java::double))
        end
        # コルモゴルフ・スミルノフ検定(2標本)
        #
        # @overload ks2test(xi1, xi2)
        #   @param [Array] xi1 x1のデータ(double[])
        #   @param [Array] xi2 x2のデータ(double[])
        #   @param [double] xi2 x2のデータ(double[])
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        #   nonParaTest = Num4TstStatisticLib::NonParametrixTestLib.new
        #   nonParaTest.ks2test(xi1, xi2, 0.05)
        #   => false
        # @note
        #   N1+N2-2のt分布に従う
        def ks2test(xi1, xi2, a)
            return @nonParamTest.ks2test(xi1.to_java(Java::double), xi2.to_java(Java::double), a)
        end
    end
    class OutlierLib
        def initialize
            @outlier = Outlier.getInstance()
        end
        # グラプス・スミルノフの外れ値の検定量
        #
        # @overload grubbs(xi, xk)
        #   @param [Array] xi xiのデータ(double[])
        #   @param [double] xk 外れ値
        #   @return [double] 検定統計量
        # @example
        #   xi = [3.4, 3.5, 3.3, 2.2, 3.3, 3.4, 3.6, 3.2]
        #   Num4TstStatisticLib.grubbs(xi, 2.2)
        #   => 2.3724
        # @note
        #   外れ値の検定に従う
        def grubbs(xi, xk)
            return @outlier.grubbs(xi.to_java(Java::double), xk)
        end
        # エラーバー出力
        #
        # @overload errbar(dname, xi)
        #   @param [String] dname データ名
        #   @param [Array] xi xiのデータ(double[])
        #   @return [void]  errbar.jpegファイルを出力
        # @example
        #   xi = [3.4, 3.5, 3.3, 2.2, 3.3, 3.4, 3.6, 3.2]
        #   Num4TstStatisticLib.grubbs("LDH", xi)
        #   => errbar.jpeg
        # @note
        #   グラフは、jfreechartを使用
        def errbar(dname, xi)
            return @outlier.errbar(dname, xi.to_java(Java::double))
        end
    end
end

