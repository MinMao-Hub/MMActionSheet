Pod::Spec.new do |s|

  s.name          = "MMActionSheet"
  s.version       = "2.0"
  s.summary       = "MMActionSheet is an simple pop-up selection box(ActionSheet) written in pure Swift"
  s.homepage      = "https://github.com/MinMao-Hub"
  s.license       = "MIT"
  s.author        = { "gyh" => "m12860gyh@gmail.com" }
  s.platform      = :ios, "8.0"
  s.swift_version = '4.0'
  s.source        = { :git => "https://github.com/MinMao-Hub/MMActionSheet.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/MMActionSheet"
end
