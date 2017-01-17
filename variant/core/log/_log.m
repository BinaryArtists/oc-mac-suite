//
//  _Log.m
//  core
//
//  Created by fallen.ink on 16/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#import "_log.h"
#import "HTTPServer.h"
#import "db/FMDBLogger.h"
#import "web/classes/MyHTTPConnection.h"

@interface _Log () {
    HTTPServer *_httpServer;
    
    DDFileLogger *_fileLogger;
    DDASLLogger *_aslLogger;
    DDTTYLogger *_ttyLogger;
    FMDBLogger *_sqliteLogger;
}

@end

@implementation _Log

@def_singleton(_Log)

- (instancetype)init {
    if (self = [super init]) {
        
        {
            _fileLogger = [DDFileLogger new];
            _fileLogger.maximumFileSize = 1024 * 1024;    // 1 MB
            _fileLogger.rollingFrequency = 60 * 60 * 24; //  24 Hours
            _fileLogger.logFileManager.maximumNumberOfLogFiles = 4;
            
            _sqliteLogger = [[FMDBLogger alloc] initWithLogDirectory:path_of_cache];
            _sqliteLogger.saveThreshold     = 500;
            _sqliteLogger.saveInterval      = 60;               // 60 seconds
            _sqliteLogger.maxAge            = 60 * 60 * 24 * 1; //  1 day
            _sqliteLogger.deleteInterval    = 60 * 5;           //  5 minutes
            _sqliteLogger.deleteOnEverySave = NO;
            
            _ttyLogger = [DDTTYLogger sharedInstance];
            _aslLogger = [DDASLLogger sharedInstance];
        }
        
        {
            // Create server using our custom MyHTTPServer class
            _httpServer = [[HTTPServer alloc] init];
            
            // Configure it to use our connection class
            [_httpServer setConnectionClass:[MyHTTPConnection class]];
            
            // Set the bonjour type of the http server.
            // This allows the server to broadcast itself via bonjour.
            // You can automatically discover the service in Safari's bonjour bookmarks section.
            [_httpServer setType:@"_http._tcp."];
            
            [_httpServer setPort:110];
            
            // Serve files from our embedded Web folder
            NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
            [_httpServer setDocumentRoot:webPath];
        }
    }
    
    return self;
}

#pragma mark - Setting

- (void)setEnabledFileLog:(BOOL)enabledFileLog {
    _enabledFileLog = enabledFileLog;
    
    if (enabledFileLog) {
        [DDLog addLogger:_fileLogger];
    } else {
        [DDLog removeLogger:_fileLogger];
    }
}

- (void)setEnabledTTYLog:(BOOL)enabledTTYLog {
    _enabledTTYLog = enabledTTYLog;
    
    if (enabledTTYLog) {
        [DDLog addLogger:_ttyLogger];
    } else {
        [DDLog removeLogger:_ttyLogger];
    }
    
}

- (void)setEnabledASLLog:(BOOL)enabledASLLog {
    _enabledASLLog = enabledASLLog;
    
    if (enabledASLLog) {
        [DDLog addLogger:_aslLogger];
    } else {
        [DDLog removeLogger:_aslLogger];
    }
    
}

- (void)setEnabledWebLog:(BOOL)enabledWebLog {
    _enabledWebLog = enabledWebLog;
    
    if (enabledWebLog) {
        [self setEnabledFileLog:YES];
        
        // Start the server (and check for problems)
        NSError *error = nil;
        if (![_httpServer start:&error]) {
            DDLogError(@"Error starting HTTP Server: %@", error);
        }
    } else {
        // won't touch FileLog switch
        
        if ([_httpServer isRunning]) {
            [_httpServer stop];
        }
    }
}

- (void)setEnabledDatabaseLog:(BOOL)enabledDatabaseLog {
    _enabledDatabaseLog = enabledDatabaseLog;
    
    if (enabledDatabaseLog) {
        [DDLog addLogger:_sqliteLogger];
    } else {
        [DDLog removeLogger:_sqliteLogger];
    }
}

#pragma mark - How to use LumberJack log

// Add File Log
//DDFileLogger* fileLogger = [[DDFileLogger alloc] init];
//fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
//fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
//[DDLog addLogger:fileLogger];
//
//// Add Apple System Log
//[DDLog addLogger:[DDASLLogger sharedInstance]];
//
//// Enable XcodeColors
//setenv("XcodeColors", "YES", 0);
//// Add Standard lumberjack initialization
//[DDLog addLogger:[DDTTYLogger sharedInstance]];
//// And then enable colors
//[[DDTTYLogger sharedInstance] setColorsEnabled:YES];
//
//// Set colors for levels
//[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagInfo];
//[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:DDLogFlagDebug];
//[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor lightGrayColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
//
//// Set format
//HHLogFormatter* logFormatter = [[HHLogFormatter alloc]init];
//[fileLogger setLogFormatter:logFormatter];
//[[DDASLLogger sharedInstance] setLogFormatter:logFormatter];
//[[DDTTYLogger sharedInstance] setLogFormatter:logFormatter];

@end
