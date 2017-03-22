//
//  _log.h
//  core
//
//  Created by fallen.ink on 16/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

// Config wrapper for CocoaLumberJack

@class DDFileLogger;

@interface _Log : NSObject

@singleton(_Log)

@property (nonatomic, assign) BOOL enabledFileLog; // default NO
@property (nonatomic, assign) BOOL enabledTTYLog; // default NO
@property (nonatomic, assign) BOOL enabledASLLog; // Apple system log, default NO
/**
 * Visit http://ip:10000
 */
@property (nonatomic, assign) BOOL enabledWebLog; // default NO
@property (nonatomic, assign) BOOL enabledDatabaseLog; // default NO

@property (nonatomic, readonly) DDFileLogger *fileLogger;

@end

// Macro wrapper
#define logInst [_Log sharedInstance]

#define loge        DDLogError
#define logw        DDLogWarn
#define logi        DDLogInfo
#define logd        DDLogDebug
#define logv        DDLogVerbose

// 一些类的参照

// Protocol to be implemented by a GTMLogWriter instance.
//@protocol GTMLogWriter <NSObject>
// Writes the given log message to where the log writer is configured to write.
//- (void)logMessage:(NSString *)msg level:(GTMLoggerLevel)level;
//@end  // GTMLogWriter

// Protocol to be imlemented by a GTMLogFilter instance.
//@protocol GTMLogFilter <NSObject>
// Returns YES if |msg| at |level| should be filtered out; NO otherwise.
//- (BOOL)filterAllowsMessage:(NSString *)msg level:(GTMLoggerLevel)level;
//@end  // GTMLogFilter

// Protocol to be implemented by a GTMLogFormatter instance.
//@protocol GTMLogFormatter <NSObject>
// Returns a formatted string using the format specified in |fmt| and the va
// args specified in |args|.
//- (NSString *)stringForFunc:(NSString *)func
//                 withFormat:(NSString *)fmt
//                     valist:(va_list)args
//                      level:(GTMLoggerLevel)level NS_FORMAT_FUNCTION(2, 0);
//@end  // GTMLogFormatter

//@interface GTMLogger : NSObject {
//@private
//    id<GTMLogWriter> writer_;
//    id<GTMLogFormatter> formatter_;
//    id<GTMLogFilter> filter_;
//}
