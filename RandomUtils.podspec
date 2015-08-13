Pod::Spec.new do |s|
  s.name         = "RandomUtils"
  s.version      = "0.2.0"
  s.summary      = "Utilities to work with random numbers, strings, selecting random elements in Objective-C."
  s.description  = <<-DESC
                   * Generating random numbers
                   * Generating random strings
                   * Selecting elements from NSArray randomly
                   * Selecting elements from NSDictionary randomly
                   * Seeded random generator
                   DESC

  s.homepage     = "https://github.com/grzegorzkrukowski/RandomUtils"
  s.license      = "MIT"
  s.author       = { "Grzegorz Krukowski" => "grkrukowski@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/grzegorzkrukowski/RandomUtils.git", :tag => "0.2.0" }
  s.source_files  = "RandomUtils"
end
