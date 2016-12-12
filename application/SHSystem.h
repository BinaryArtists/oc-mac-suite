//
//  SHSystem.h
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "suite-core.h"

@interface SHSystem : NSObject

@singleton(SHSystem)

// 打开文件

- (BOOL)openApplicationWithAppName:(NSString *)appName, ... NS_REQUIRES_NIL_TERMINATION; // 打开外部app, appName 可以是一个完整的命令

- (BOOL)openFile:(NSString *)filepath; // @"/Users/lijie/Desktop/fallenink.git/YYKit/YYKit.xcodeproj"

- (BOOL)closePreview; // 关闭当前打开的Preview进程，可用于关闭打开的pdf、image文件

- (BOOL)closeXcode; // 关闭当前打开的Xcode进程，会误伤

#pragma mark - 开机启动项

- (void)setApp:(NSString *)appname loginItemEnabled:(BOOL)enabled;


@end
