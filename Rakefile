require  'rake/javaextensiontask'

Rake::JavaExtensionTask.new(name='num4tststatistic')  do | ext |
  ext.release          = '11'
  ext.classpath        = 'lib/commons-math3-3.6.1.jar'
end
task :default => [:compile]
