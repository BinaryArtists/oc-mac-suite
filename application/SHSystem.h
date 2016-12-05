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

// functions

- (BOOL)openApplicationWithAppName:(NSString *)appName, ... NS_REQUIRES_NIL_TERMINATION; // 打开外部app, appName 可以是一个完整的命令

- (BOOL)openFile:(NSString *)filepath; // @"/Users/lijie/Desktop/fallenink.git/YYKit/YYKit.xcodeproj"

@end
