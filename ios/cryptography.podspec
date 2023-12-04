#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint cryptography.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'cryptography'
  s.version          = '1.0.0'
  s.summary          = 'EZCareTech Cryptography Flutter plugin.'
  s.description      = <<-DESC
EZCareTech Cryptography Flutter plugin.
                       DESC
  s.homepage         = 'https://github.com/ezcaretech-com/Cryptography.FlutterPlugIn'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'EZCareTech' => 'smart@ezcaretech.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'CryptoSwift'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
