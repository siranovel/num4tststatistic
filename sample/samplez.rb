require 'num4tststatistic'
require_relative('mymatcher')

RSpec.describe Num4TstStatisticLib do
    describe Num4TstStatisticLib::ParametrixTestLib do
        let!(:paraTest) { Num4TstStatisticLib::ParametrixTestLib.new }

        it '#populationMean' do
            xi = [15.5, 15.7, 15.4, 15.4, 15.6, 15.4, 15.6, 15.5, 15.4]
            expect(
                paraTest.populationMean(xi, 15.4)
            ).to my_round(2.683, 3)
        end
        it '#populationVar' do
            xi = [35.2, 34.5, 34.9, 35.2, 34.8, 35.1, 34.9, 35.2, 34.9, 34.8]
            sd = 0.4
            expect(
                paraTest.populationVar(xi, sd * sd)
            ).to my_round(2.906, 3)
        end
        it '#populationRatio' do
            expect(
                paraTest.populationRatio(29, 346, 0.12)
            ).to my_round(-2.071, 3)
        end
        it '#diffPopulationMean2EquVar' do
            xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                paraTest.diffPopulationMean2EquVar(xi1, xi2)
            ).to my_round(-1.765, 3)
        end
        it '#diffPopulationMean2UnEquVar' do
            xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                paraTest.diffPopulationMean2UnEquVar(xi1, xi2)
            ).to my_round(-1.636, 3)
        end
        it '#df4welch' do
            xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                paraTest.df4welch(xi1, xi2)
            ).to eq 11
        end
        it '#diffPopulationMean' do
            xi1 = [37.1, 36.2, 36.6, 37.4, 36.8, 36.7, 36.9, 37.4, 36.6, 36.7]
            xi2 = [36.8, 36.6, 36.5, 37.0, 36.0, 36.5, 36.6, 37.1, 36.4, 36.7]
            expect(
                paraTest.diffPopulationMean(xi1, xi2)
            ).to my_round(2.283, 3)
        end
        it '#diffPopulationVar' do
            xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                paraTest.diffPopulationVar(xi1, xi2)
            ).to my_round(0.4727, 4)
        end
        it '#diffPopulationRatio' do
            expect(
                paraTest.diffPopulationRatio(469, 1200, 308, 900)
            ).to my_round(2.283, 3)
        end
        it '#pearsoCorrelation' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                paraTest.pearsoCorrelation(x, y)
            ).to my_round(0.761, 3)
        end
        it '#fidelity' do
            fi = [57, 33, 46, 14]
            pi = [0.4, 0.2, 0.3, 0.1]
            expect(
                paraTest.fidelity(fi, pi)
            ).to my_round(0.5389, 4)
        end
        it '#independency' do
            fij = [
               [57, 33, 46, 14],
               [89, 24, 75, 12],
            ]
            expect(
                paraTest.independency(fij)
            ).to my_round(8.5711, 4)
        end
    end
    describe Num4TstStatisticLib::NonParametrixTestLib do
        let!(:nonParaTest) { Num4TstStatisticLib::NonParametrixTestLib.new }
        it '#utest' do
            x = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            y = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                nonParaTest.utest(x, y)
            ).to my_round(1.1573, 4)
        end
        it '#wilcoxon' do
            x = [37.1, 36.2, 36.6, 37.4, 36.8, 36.7, 36.9, 37.4, 36.6, 36.7]
            y = [36.8, 36.6, 36.5, 37.0, 36.0, 36.5, 36.6, 37.1, 36.4, 36.7]
            expect(
                nonParaTest.wilcoxon(x, y)
            ).to my_round(1.9367, 4)
        end
        it '#spearmanscorr' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                nonParaTest.spearmanscorr(x, y)
            ).to my_round(0.745, 3)
        end
        it '#kendallscorr' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                nonParaTest.kendallscorr(x, y)
            ).to my_round(0.592, 3)
        end
        it '#ks2test' do
            xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                nonParaTest.ks2test(xi1, xi2, 0.05)
            ).to eq false
        end
    end
    it '#grubbs' do
        xi = [3.4, 3.5, 3.3, 2.2, 3.3, 3.4, 3.6, 3.2]
        expect(
            Num4TstStatisticLib.grubbs(xi, 2.2)
        ).to my_round(2.3724, 4)
    end
end

