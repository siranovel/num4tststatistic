require_relative('myroundmatcher')
require_relative('myfilematcher')

RSpec.configure do |config|
  config.include MyRoundMatcher
  config.include MyFileMatcher
end

