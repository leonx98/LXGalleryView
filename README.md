# LXGalleryView

![Xcode 9.0+](https://img.shields.io/badge/Xcode-9.0%2B-blue.svg)
![iOS 9.0+](https://img.shields.io/badge/iOS-9.0%2B-blue.svg)
![Swift 4.0+](https://img.shields.io/badge/Swift-4.0%2B-orange.svg)
![CocoaPods Compatible](https://img.shields.io/badge/pod-1.0.0-blue.svg)  
![Platform](https://img.shields.io/badge/platform-ios-lightgray.svg)
[![License][license-image]][license-url]

LXGalleryView is a customizable slideshow for custom cells.

![](Screenshots/LXGalleryView-Preview.gif)


## Requirements

- Swift 4+
- iOS 9.0+
- Xcode 9+

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `LXGalleryView` by adding it to your `Podfile`:

```ruby
pod 'LXGalleryView'
```

## Usage

Create a 'LXGalleryView' Instance.
```swift
let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 230)
let galleryView = LXGalleryView(frame: frame, delegate: self, dataSource: self)

self.view.addSubview(galleryView)
```

Register a custom cell to the LXGalleryView. Cell size automatically adjusts to 'LXGalleryView' bounds.
```swift
galleryView.galleryCollection.register(UINib(nibName: "myCustomCell", bundle: Bundle.main), forCellWithReuseIdentifier: "myCell")
```

Implement the 'LXGalleryViewDataSource' protocol.
```swift
@objc public protocol LXGalleryViewDataSource {
func galleryView(_ galleryView: LXGalleryView, numberOfItemsInSection section: Int) -> Int
func galleryView(_ galleryView: LXGalleryView, cellForItemAt: IndexPath) -> UICollectionViewCell
}
```

## Additional methods, properties & delegate
Public Methods:
```swift
galleryView.setButtonImages(left: UIImage, right: UIImage, for state: UIControlState) // to set custom navigation buttons
```

Public Properties:
```swift
galleryView.galleryCollection: LXGalleryViewCollection // wrapped CarouselCollection (Subclass of UICollectionView)
galleryView.dataSource: LXGalleryDataSource // dataSource
galleryView.delegate: LXGalleryDelegate // delegate
galleryView.isAnimated: Bool // automatic scrolling
galleryView.duration: Double // duration until the next cell should animate in
galleryView.isInfinite: Bool // endless scrolling
galleryView.rightButton: UIButton // right navigation button
galleryView.leftButton: UIButton // left navigation button
galleryView.areButtonsHidden: Bool // turn navigation buttons on or off
```

Delegate protocol:
```swift
@objc public protocol LXGalleryViewDelegate {
optional func galleryViewDidPaged(_ galleryView: LXGalleryView, toPage: Int)
optional func galleryViewDidScroll(_ galleryView: LXGalleryView)
}
```

## Donation

If you like my open source libraries, you can sponsor it! ☺️

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.me/leonx98)

## Author

Leon Hoppe, leonhoppe98@gmail.com

## License

Distributed under the MIT license. See ``LICENSE`` for more information.


[license-image]: https://img.shields.io/badge/License-MIT-green.svg
[license-url]: LICENSE
