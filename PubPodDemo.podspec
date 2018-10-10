#
# Be sure to run `pod lib lint PubPodDemo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PubPodDemo'
  s.version          = '0.0.3'
  s.summary          = 'Pod共有库练习'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    练习Pod共有库，对全代码情况、包含framework&a文件情况和bundle情况进行练习
                       DESC

  s.homepage         = 'https://github.com/JoyaGuo/PubPodDemo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JoyaGuo' => '971840097@qq.com' }
  s.source           = { :git => 'https://github.com/JoyaGuo/PubPodDemo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PubPodDemo/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PubPodDemo' => ['PubPodDemo/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'WechatOpenSDK'

end
