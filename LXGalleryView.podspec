Pod::Spec.new do |s|
  s.name             = 'LXGalleryView'
  s.version          = '1.0.0'
  s.summary          = 'A GalleryView for custom Cells'
  s.homepage         = 'https://github.com/leonx98/LXGalleryView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leon Hoppe' => 'leonhoppe98@gmail.com' }
  s.source           = { :git => 'https://github.com/leonx98/LXGalleryView.git', :tag => s.version }
  s.swift_version = '4.0'
  s.ios.deployment_target = '9.0'
  s.source_files = 'LXGalleryView/Classes/**/*'
  s.resource_bundles = {'LXGalleryView' => ['LXGalleryView/Assets/*.xcassets']}
end
