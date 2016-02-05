source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target 'PtvApi' do
	pod 'SwiftyJSON' , :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git'
end

target 'PtvApiTests' do

end

target 'PtvApiUITests' do

end

post_install do |installer|
    installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
        configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
    end
end

