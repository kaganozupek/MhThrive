# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def sharedPods
    use_frameworks!
    pod 'SwiftyJSON'
    pod 'ObjectMapper', '~> 2.2'
    pod 'RealmSwift'
    pod 'SDWebImage', '~> 4.0'
    
    
end





target 'My Thrive' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
    sharedPods
    pod 'DatePickerDialog'
   
  # Pods for My Thrive

  target 'My ThriveTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'My ThriveUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  



end

target 'My Thrive Watch Extension' do
    platform :watchos, '3.0'
    sharedPods
end



post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.1'
        end
    end
end
