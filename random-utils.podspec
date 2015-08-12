Pod::Spec.new do |s|
  s.name         = "random-utils"
  s.version      = "0.1.0"
  s.summary      = "Utilities to work with random numbers, strings, selecting random elements in Objective-C."
  s.description  = <<-DESC
                   * Generating random numbers
                   * Generating random strings
                   * Selecting elements from NSArray randomly
                   * Selecting elements from NSDictionary randomly
                   * Seeded random generator
                   DESC

  s.homepage     = "https://github.com/grzegorzkrukowski/random-utils"
  s.license      = "MIT"
  s.author       = { "Grzegorz Krukowski" => "grkrukowski@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/grzegorzkrukowski/random-utils.git", :tag => "0.1.0" }
  s.source_files  = "random-utils"
  s.exclude_files = "Classes/Exclude"
end
