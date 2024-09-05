# Uncomment the next line to define a global platform for your project

source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
source 'https://github.com/aliyun/aliyun-specs.git'
platform :ios, '11.0'
target 'AnAnVideo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SnapKit'
  pod 'Moya'
  pod 'SwiftyJSON'
  pod 'HandyJSON'
  pod 'Toast-Swift'
  pod 'Kingfisher'
  # swift三方数据库
#  pod 'RealmSwift'
#  pod 'Realm'
  # Reusable 简便，快速的注册cell的三方库
  # 讲解地址  https://blog.csdn.net/m0_56310654/article/details/124158891
  pod 'Reusable'
  # 轮播图
  pod 'JXBanner'
  pod 'NetSpeed'
  pod 'AlicloudMAN'
  pod 'AlicloudUT'

  # Pods for AnAnVideo

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |build_configuration|
      build_configuration.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
      build_configuration.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
    if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
          target.build_configurations.each do |config|
              config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
          end
    end

#    xcode14上pod插件需要指定team ID，下面的设置是为了避免没有选择teamID报错
#    target.build_configurations.each do |config|
##        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
#        config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
#        config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
#        config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
#     end
  end
end
