require './lib/reporter'

desc "Value, Cost and Profit Report"
task :report do
  reporter = Reporter.new
  puts reporter.report
end

desc "Test Mode, for the paranoid"
task :test_mode do
  reporter = Reporter.new(test_mode=true)
  puts reporter.report
end