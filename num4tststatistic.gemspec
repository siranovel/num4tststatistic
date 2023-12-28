Gem::Specification.new do |s|
  s.name        = 'num4tststatistic'
  s.version     = '0.1.1'
  s.date        = '2023-12-27'
  s.summary     = "num for test statistic!"
  s.description = "numerical solution for test statistic"
  s.platform      = 'java'
  s.authors     = ["siranovel"]
  s.email       = "siranovel@gmail.com"
  s.homepage    = "http://github.com/siranovel/num4tststatistic"
  s.license     = "MIT"
  s.files       = ["LICENSE", "Gemfile", "CHANGELOG.md"]
  s.files       += Dir.glob("{lib,ext}/**/*")
  s.extensions  = %w[Rakefile]
  s.add_development_dependency 'rake', '~> 12.3', '>= 12.3.3'
  s.add_development_dependency 'rake-compiler', '~> 1.2', '>= 1.2.5'
end
