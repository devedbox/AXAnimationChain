
Pod::Spec.new do |s|

s.name         = "AXAnimationChain-Swift"
s.version      = "0.1.4"
s.summary      = "`AXAnimationChain-Swift` is an iOS chain animation kit using swift3.0."

s.description  = <<-DESC
               `AXAnimationChain-Swift` is an iOS chain animation kit using swift3.0 which is easy to use.
               DESC
s.homepage     = "https://github.com/devedbox/AXAnimationChain"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "devedbox" => "devedbox@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/devedbox/AXAnimationChain.git", :tag => "0.1.4" }
s.source_files  = 'AXAnimationChain/Classes/UIView+ChainAnimator.{h,m}', 'AXAnimationChain/Classes/AXChainAnimator.{h,m}', 'AXAnimationChain/Classes/CoreAnimation/*.{h,m}'
s.frameworks = "UIKit", "Foundation", "QuartzCore"
s.requires_arc = true

s.subspec 'CoreAnimation' do |ss|
    ss.source_files = 'AXAnimationChain/Classes/CoreAnimation/*.{h,m}'
end

end
