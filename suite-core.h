//
//  suite-mac.h
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

// ----------------------------------
// ////////
// ----------------------------------

#ifdef __OBJC__

#import "suite-core-macros.h"

// foundation
#import "foundation/extobjc/extobjc.h"

#import "foundation/extension/NSObject+Extension.h"
#import "foundation/extension/NSString+Extension.h"
#import "foundation/extension/NSWorkspace+Extension.h"

#import "foundation/_runtime.h"
#import "foundation/_singleton.h"
#import "foundation/_notification.h"

// support
#import "support/ReactiveObjc/ReactiveObjC.h"
#import "support/EventBus/EventBus.h"

// application
#import "application/SHSystem.h"

// helper
#import "helper/FileHelper.h"
#import "helper/PDFHelper.h"
#import "helper/ZIPHelper.h"
#import "helper/JSONHelper.h"

// network
#import "network/ftp/FTPKit.h"
#import "network/ftp/Protected/FTPKit+Protected.h"

#endif

// 其他可能会用上的
// 1. JSONModel: https://github.com/jsonmodel/jsonmodel/blob/master/JSONModel/JSONModel/JSONModel.h
// 2. Masonry: https://github.com/SnapKit/Masonry, current version is 1.0.0
// 3. WKWebView使用案例: https://github.com/saitjr/WKWebViewSimpleDemo/blob/master/2015-01-31-WKWebViewDemo/2015-01-31-WKWebViewDemo/BaiduViewController.m
// 3.1 WKWebView包装的VC: https://github.com/Fogh/AFWebViewController/blob/master/AFWebViewController/AFWebViewController.m
// 4. macOS打包应用的问题: http://www.cocoachina.com/bbs/read.php?tid-1704657.html
// 5. 用户设置：https://github.com/kgn/DBPrefsWindowController
// 6.

// 其他一般用不上的
// 1. gyetvan-andras/Calendar-OSX
