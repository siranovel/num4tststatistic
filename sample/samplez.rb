require 'num4tststatistic'
# 小数点桁四捨五入
module MyRoundMatcher
  class Matcher
    def initialize(expected, n)
      @expected = expected
      @n = n
    end

    def matches?(actual)
      @actual = actual.round(@n)
      @actual == @expected
    end

    def failure_message
      "#{@expected} expected but got #{@actual}"
    end
  end
  def my_round(expected, n)
    Matcher.new(expected, n)
  end
end

RSpec.configure do |config|
  config.include MyRoundMatcher
end



RSpec.describe Num4TstStatisticLib do
    it '#populationMean' do
        xi = [15.5, 15.7, 15.4, 15.4, 15.6, 15.4, 15.6, 15.5, 15.4]
        expect(
            Num4TstStatisticLib.populationMean(xi, 15.4)
        ).to my_round(2.683, 3)
    end
    it '#populationVar' do
        xi = [35.2, 34.5, 34.9, 35.2, 34.8, 35.1, 34.9, 35.2, 34.9, 34.8]
        sd = 0.4
        expect(
            Num4TstStatisticLib.populationVar(xi, sd * sd)
        ).to my_round(2.906, 3)
    end
    it '#populationRatio' do
        expect(
            Num4TstStatisticLib.populationRatio(29, 346, 0.12)
        ).to my_round(-2.071, 3)

    end
    it '#diffPopulationMean2EquVar' do
        xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        expect(
            Num4TstStatisticLib.diffPopulationMean2EquVar(xi1, xi2)
        ).to my_round(-1.765, 3)
    end
    it '#diffPopulationMean2UnEquVar' do
        xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        expect(
            Num4TstStatisticLib.diffPopulationMean2UnEquVar(xi1, xi2)
        ).to my_round(-1.636, 3)
    end
    it '#df4welch' do
        xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        expect(
            Num4TstStatisticLib.df4welch(xi1, xi2)
        ).to eq 11
    end
    it '#diffPopulationMean' do
        xi1 = [37.1, 36.2, 36.6, 37.4, 36.8, 36.7, 36.9, 37.4, 36.6, 36.7]
        xi2 = [36.8, 36.6, 36.5, 37.0, 36.0, 36.5, 36.6, 37.1, 36.4, 36.7]
        expect(
            Num4TstStatisticLib.diffPopulationMean(xi1, xi2)
        ).to my_round(2.283, 3)

    end
    it '#diffPopulationVar' do
        xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        expect(
            Num4TstStatisticLib.diffPopulationVar(xi1, xi2)
        ).to my_round(0.4727, 4)
    end
    it '#diffPopulationRatio' do
        expect(
            Num4TstStatisticLib.diffPopulationRatio(469, 1200, 308, 900)
        ).to my_round(2.283, 3)
    end
    it '#unCorrelation' do
        x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        expect(
            Num4TstStatisticLib.unCorrelation(x, y)
        ).to my_round(3.1035, 4)
    end
    it '#populationCorre' do
        x = [2750, 2956, 2675, 3198, 1816, 2233, 2375, 2288, 1932, 2036, 2183, 2882]
        y = [249, 713, 1136, 575, 5654, 2107, 915, 4193, 7225, 3730, 472, 291]
        expect(
            Num4TstStatisticLib.populationCorre(x, y, -0.3)
        ).to my_round(-2.107168, 6)
    end
end

