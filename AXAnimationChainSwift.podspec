
Pod::Spec.new do |s|

s.name         = "AXAnimationChainSwift"
s.version      = "0.4.1"
s.summary      = "`AXAnimationChainSwift` is an iOS chain animation hooker for `AXAnimationChain-Swift` using objc."

s.description  = <<-DESC
               `AXAnimationChain-Swift` is an iOS chain animation hooker for `AXAnimationChain-Swift` using objc which is easy to use.
               DESC
s.homepage     = "https://github.com/devedbox/AXAnimationChain"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "devedbox" => "devedbox@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/devedbox/AXAnimationChain.git", :tag => s.version }
s.source_files  = 'AXAnimationChain/Classes/UIView+ChainAnimator.{h,m}', 'AXAnimationChain/Classes/AXChainAnimator.{h,m}', 'AXAnimationChain/Classes/CALayer+AnchorPoint.{h,m}', 'AXAnimationChain/Classes/CoreAnimation/*.{h,m}'

s.frameworks = "UIKit", "Foundation", "QuartzCore"
s.requires_arc = true

end
