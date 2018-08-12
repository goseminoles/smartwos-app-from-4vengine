use_frameworks!

target 'smartwos-app' do
    pod 'Alamofire', '~> 4.7'
    pod 'RxSwift',    '~> 4.0'
    pod 'RxSwiftExt'
    pod 'RxCocoa',    '~> 4.0'
    pod 'RxDataSources'
    pod 'Kingfisher', '~> 4.0'
    pod 'PKHUD', '~> 5.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.1'
        end
    end
end
