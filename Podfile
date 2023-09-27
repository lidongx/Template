platform :ios, '13.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        xcconfig_path = config.base_configuration_reference.real_path
        xcconfig = File.read(xcconfig_path)
        xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
        File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
      end
    if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle" # <--- this
      target.build_configurations.each do |config|
          config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      end
    end
  end
  
  #Xcode 15 编译报错
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          xcconfig_path = config.base_configuration_reference.real_path
          xcconfig = File.read(xcconfig_path)
          xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
          File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
      end
  end
  
end

source "https://github.com/retro-labs/specs-ios-swift.git"
source 'https://github.com/CocoaPods/Specs.git'

target 'Template' do
  if File.exist?('./AppStoreEnv.rb');eval File.read('./AppStoreEnv.rb');end
  use_frameworks!

  pod 'FpgSdk','3.1.0'
  pod 'IAPManager/rc', '~> 11.2.0'
  pod 'HandyJSON', '~> 5.0.4-beta'
  pod 'IQKeyboardManagerSwift','6.5.11'
  pod 'MPEvent', '~> 12.0.2'
  
end

target 'OneSignalNotificationServiceExtension' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'OneSignalXCFramework', '>= 3.0.0', '< 4.0'
end
