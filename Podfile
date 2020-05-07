use_frameworks!
inhibit_all_warnings!
workspace 'NASAImages'
platform :ios, '11.0'

def alamofire
  pod 'Alamofire', '~> 5'
end

def base_rx_pods
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
end

def rswift
  pod 'R.swift', '~> 5.1.0'
end

def snap_kit
  pod 'SnapKit', '~> 5.0.0'
end

def swiftlint
  pod 'SwiftLint', '~> 0.39.0'
end

target 'NASAImages' do
  base_rx_pods
  rswift
  snap_kit
  swiftlint
  pod 'Toast-Swift', '~> 5.0.1'
  pod 'Kingfisher', '~> 5.0'
end

target 'NASAImagesCore' do
  project 'NASAImagesCore/NASAImagesCore.xcodeproj'
  base_rx_pods
  swiftlint
  snap_kit
end

target 'NASAImagesService' do
  project 'NASAImagesService/NASAImagesService.xcodeproj'
  base_rx_pods
  swiftlint
end

target 'NASAImagesNetwork' do
  project 'NASAImagesNetwork/NASAImagesNetwork.xcodeproj'
  alamofire
  base_rx_pods
  swiftlint
end
