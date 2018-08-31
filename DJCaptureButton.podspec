#
# Be sure to run `pod lib lint DJCaptureButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DJCaptureButton'
  s.version          = '0.1.0'
  s.summary          = 'Camera styled capture button with 3D touch'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    This is a camera styled capture button. Used for one of my apps and i wanted to share it. It uses tap and 3D Touch to fire the action.
                       DESC

  s.homepage         = 'https://github.com/davnag/DJCaptureButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'David Jonsén' => 'dev.jonsen@outlook.com' }
  s.source           = { :git => 'https://github.com/davnag/DJCaptureButton.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/'

  s.swift_version = '4.0'

  s.ios.deployment_target = '10.0'

  s.source_files = 'DJCaptureButton/Classes/**/*'

end
