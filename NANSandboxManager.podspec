#
# Be sure to run `pod lib lint NANSandboxManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NANSandboxManager'
  s.version          = '0.0.1'
  s.summary          = '沙盒管理器'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  iOS开发过程中，总会遇到沙盒文件的读写，为了在调试过程中能够快速定位文件，查看沙盒文件列表，开发了沙盒管理器，方便开发人员集成和添加沙盒入口
                      DESC

  s.homepage         = 'https://github.com/nanyueze/sandboxManager.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nanyueze' => 'lizenan@126.com' }
  s.source           = { :git => 'https://github.com/nanyueze/sandboxManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'NANSandboxManager/Classes/*'
  
  # s.resource_bundles = {
  #   'NANSandboxManager' => ['NANSandboxManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
