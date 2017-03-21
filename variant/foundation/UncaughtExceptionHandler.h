//
//  UncaughtExceptionHandler.h
//  variant
//
//  Created by fallen.ink on 22/03/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler : NSObject

/*!
 *  异常的处理方法
 *
 *  @param install   是否开启捕获异常
 *  @param showAlert 是否在发生异常时弹出alertView
 */
+ (void)installUncaughtExceptionHandler:(BOOL)install showAlert:(BOOL)showAlert;

@end
