Pod::Spec.new do |s|
  s.name         = "IMULoadingView"
  s.version      = "0.0.1"
  s.summary      = "A configurable (and nice looking) loading view with spinner and message."
  s.homepage     = "https://github.com/imulus/IMULoadingView"
  s.license      = { :type => 'WTFPL', :file => 'LICENSE' }
  s.author       = { "Bryce Hammond" => "bryce.hammond@imulus.com" }
  s.source       = { :git => "https://github.com/imulus/IMULoadingView.git", :tag => "0.0.1" }
  s.platform     = :ios, '5.0'

  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'
  s.framework  = 'QuartzCore'
  s.requires_arc = true

end
