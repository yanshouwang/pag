#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint pag_darwin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'pag_darwin'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'pag_darwin_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
  
  s.ios.deployment_target = '12.0'
  s.ios.dependency 'Flutter'
  s.ios.dependency 'libpag', '~>4.4.26'

  s.osx.deployment_target = '10.11'
  s.osx.dependency 'FlutterMacOS'
  s.osx.dependency 'libpag-macOS', '~>4.4.26'
end
