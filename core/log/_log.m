//
//  _Log.m
//  core
//
//  Created by fallen.ink on 16/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#import "_log.h"
#import "db/FMDBLogger.h"
#import "web/classes/MyHTTPConnection.h"

static const DDLogLevel ddLogLevel = DDLogLevelDebug;

@interface _Log () {
    HTTPServer *_httpServer;
}

@end

@implementation _Log

@def_singleton(_Log)

- (void)setEnabledFileLog:(BOOL)enabledFileLog {
    if (!_fileLogger) {
        _fileLogger = [DDFileLogger new];
        
        _fileLogger.maximumFileSize = 1024 * 1024;    // 1 MB
        _fileLogger.rollingFrequency = 60 * 60 * 24; //  24 Hours
        
        _fileLogger.logFileManager.maximumNumberOfLogFiles = 4;
        
        [DDLog addLogger:_fileLogger];
    }
}

- (void)setEnabledTTYLog:(BOOL)enabledTTYLog {
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}

- (void)setEnabledWebLog:(BOOL)enabledWebLog {
    if (!_httpServer) {
        [self setEnabledFileLog:YES];
        
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
        
        // Start the server (and check for problems)
        
        NSError *error = nil;
        if (![_httpServer start:&error]) {
            DDLogError(@"Error starting HTTP Server: %@", error);
        }
    }
}

- (void)setEnabledDatabaseLog:(BOOL)enabledDatabaseLog {
    FMDBLogger *sqliteLogger = [[FMDBLogger alloc] initWithLogDirectory:path_of_cache];
    
    sqliteLogger.saveThreshold     = 500;
    sqliteLogger.saveInterval      = 60;               // 60 seconds
    sqliteLogger.maxAge            = 60 * 60 * 24 * 1; //  1 day
    sqliteLogger.deleteInterval    = 60 * 5;           //  5 minutes
    sqliteLogger.deleteOnEverySave = NO;
    
    [DDLog addLogger:sqliteLogger];
}

#pragma mark -


@end
