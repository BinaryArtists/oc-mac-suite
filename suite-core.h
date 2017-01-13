//
//  suite-mac.h
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

// ----------------------------------
// 编码规则
// 1. IBOutlet 作为属性
// 2. 外部暴露的变量 作为属性
// 3. 除了1，2，其他作为成员变量
// 4. 成员变量 以_开头
// ----------------------------------

#ifdef __OBJC__

#import "suite-core-macros.h"

// foundation
#import "foundation/extobjc/extobjc.h"

#import "foundation/extension/NSObject+Extension.h"
#import "foundation/extension/NSString+Extension.h"
#import "foundation/extension/NSWorkspace+Extension.h"
#import "foundation/extension/NSArray+Extension.h"
#import "foundation/extension/NSImage+Extension.h"

#import "foundation/_runtime.h"
#import "foundation/_singleton.h"
#import "foundation/_notification.h"
#import "foundation/_thread.h"
#import "foundation/_property.h"

// support
#import "support/ReactiveObjc/ReactiveObjC.h"
#import "support/EventBus/EventBus.h"
#import "support/SSZipArchive/SSZipArchive.h"

// application
#import "application/SHSystem.h"

// helper
#import "helper/FileHelper.h"
#import "helper/ZIPHelper.h"
#import "helper/JSONHelper.h"

// network
#import "network/ftp/FTPKit.h"
#import "network/ftp/Protected/FTPKit+Protected.h"

#endif

// 一个简易的Mac开发教程：http://www.jianshu.com/p/feadeb1ae7ae

// 其他可能会用上的
// 1. JSONModel: https://github.com/jsonmodel/jsonmodel/blob/master/JSONModel/JSONModel/JSONModel.h
// 2. Masonry: https://github.com/SnapKit/Masonry, current version is 1.0.0
// 3. WKWebView使用案例: https://github.com/saitjr/WKWebViewSimpleDemo/blob/master/2015-01-31-WKWebViewDemo/2015-01-31-WKWebViewDemo/BaiduViewController.m
// 3.1 WKWebView包装的VC: https://github.com/Fogh/AFWebViewController/blob/master/AFWebViewController/AFWebViewController.m
// 4. macOS打包应用的问题: http://www.cocoachina.com/bbs/read.php?tid-1704657.html
// 5. 用户设置：https://github.com/kgn/DBPrefsWindowController
// 6. 字符轮转：https://github.com/zyafa/MPScrollingTextField
// 7. 文本自动补全：https://github.com/MindPreview/RSAutocomplete
// 8. 文本规则输入：https://github.com/andriitishchenko/NSTextFieldMask
// 9. 压缩／解压：[ZipArchive/ZipArchive](https://github.com/ZipArchive/ZipArchive)
// 10. mask的弹出框：[damarclabs/MLHudAlert](https://github.com/damarclabs/MLHudAlert)

// 其他一般用不上的
// 1. gyetvan-andras/Calendar-OSX
