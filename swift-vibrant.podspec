#
# Be sure to run `pod lib lint swiftVibrant.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'swift-vibrant'
  s.version          = '0.1.0'
  s.summary          = 'Extract prominent colors from an image.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A swift port of the node-vibrant npm module. Extracts the dominant colors from an image and returns them as an easily digestible palette.
                       DESC

  s.homepage         = 'https://github.com/bd452/swift-vibrant'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Bryce Dougherty' => 'bryce.dougherty@gmail.com' }
  s.source           = { :git => 'https://github.com/bd452/swift-vibrant.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'swiftVibrant/**/*'
  
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'swiftVibrant' => ['swiftVibrant/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
