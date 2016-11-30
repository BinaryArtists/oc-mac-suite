//
//  suite-mac.h
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#ifdef __OBJC__

#import "suite-mac-macros.h"

// foundation
#import "NSObject+Extension.h"

#import "_runtime.h"
#import "_singleton.h"
#import "_notification.h"

// mvc
#import "Masonry.h"

#import "NSWindowController+Extension.h"
#import "NSView+Extension.h"
#import "NSViewController+Extension.h"
#import "NSColor+Extension.h"
#import "NSObject+MVC.h"

#import "BaseWebVC.h"
#import "BaseWindowController.h"

// application
#import "SHSystem.h"

// helper
#import "FileHelper.h"
#import "PDFHelper.h"
#import "ZIPHelper.h"
#import "JSONHelper.h"

// network
#import "FTPKit.h"
#import "FTPKit+Protected.h"

#endif

// 其他可能会用上的
// 1. JSONModel: https://github.com/jsonmodel/jsonmodel/blob/master/JSONModel/JSONModel/JSONModel.h
// 2. Masonry: https://github.com/SnapKit/Masonry, current version is 1.0.0
// 3. WKWebView使用案例: https://github.com/saitjr/WKWebViewSimpleDemo/blob/master/2015-01-31-WKWebViewDemo/2015-01-31-WKWebViewDemo/BaiduViewController.m
// 3.1 WKWebView包装的VC: https://github.com/Fogh/AFWebViewController/blob/master/AFWebViewController/AFWebViewController.m
// 4. macOS打包应用的问题: http://www.cocoachina.com/bbs/read.php?tid-1704657.html


// 其他一般用不上的
// 1. gyetvan-andras/Calendar-OSX
