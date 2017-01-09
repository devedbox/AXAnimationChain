
Pod::Spec.new do |s|

s.name         = "AXAnimationChain"
s.version      = "0.0.7"
s.summary      = "`AXAnimationChain` is an iOS chain animation manater."

s.description  = <<-DESC
               `AXAnimationChain` is an iOS chain animation manater which is easy to use.
               DESC
s.homepage     = "https://github.com/devedbox/AXAnimationChain"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "devedbox" => "devedbox@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/devedbox/AXAnimationChain.git", :tag => "0.0.7" }
s.source_files  = "AXAnimationChain/Classes/*.{h,m}"
s.frameworks = "UIKit", "Foundation", "QuartzCore"
s.requires_arc = true

end
