# ZZRouter

[![CI Status](http://img.shields.io/travis/张苏亚/ZZRouter.svg?style=flat)](https://travis-ci.org/张苏亚/ZZRouter)
[![Version](https://img.shields.io/cocoapods/v/ZZRouter.svg?style=flat)](http://cocoapods.org/pods/ZZRouter)
[![License](https://img.shields.io/cocoapods/l/ZZRouter.svg?style=flat)](http://cocoapods.org/pods/ZZRouter)
[![Platform](https://img.shields.io/cocoapods/p/ZZRouter.svg?style=flat)](http://cocoapods.org/pods/ZZRouter)

[中文介绍和用法](http://www.jianshu.com/p/f7a4e311fe99)
## Example

You can run the project directly,Open the sarfri in the simulator or iphone of the project, enter url: 
1.zzrouter://productdetail
2.zzrouter://orderlist?orderid=xxx
3.zzrouter://category
4.zzrouter://homepage


## Requirements

## Installation

ZZRouter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZZRouter"
```

## Usage
After you import ZZRouter's pod, you need to do the following:

1.Redirect logic and logic realization of jump mode: new different class implements the ZZRouterJumpTypeProtocol (jump type), ZZRouterRedirectProtocol (redirect logic), ZZRouterSequentialIndependenceProtocol (Logic that independent of the main process )

2. Create the plist file for the method configuration, as follows:

![](http://upload-images.jianshu.io/upload_images/741221-e9e756d5a385566c.png?imageMogr2/auto-orient/strip)

3. Create the plist file for the URL configuration, as follows:

![](http://upload-images.jianshu.io/upload_images/741221-8b9acbfa00cd2630.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

4. Call the method of registering two plist files in the didFinishLaunchingWithOptions method of the AppDelegate class

```ruby
[ZZRouterHelper registMethodListName:@"RouterMethod" urlListName:@"UrlList"]; 
```
5.Configure scheme in URL type

![](http://upload-images.jianshu.io/upload_images/741221-879609b5d7f982e3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

6. Remote URL specification:

```ruby
1.Scheme is the scheme configured inside URL type
2.Host is description of the page function description
3.Parameters after ‘？’
4.Stitching parameters use ‘&’
5.Scheme, host, params are lowercase and conform to the standard URL specification
Example：zzrouter://orderlist?orderid=23245&type=3
```

## Author

张苏亚, suya.zhang@feiniu.com

## License

ZZRouter is available under the MIT license. See the LICENSE file for more info.
