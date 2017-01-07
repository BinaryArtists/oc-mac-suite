//
//  SHSystem.m
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <sys/sysctl.h>
#import <arpa/inet.h>
#import <net/if.h>
#import <ifaddrs.h>

#import "SHSystem.h"

@implementation SHSystem

@def_singleton(SHSystem)

- (NSString *)ip {
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0) {
                //NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                //if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                {
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    break;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return localIP;
}

#pragma mark - functions

- (BOOL)openApplicationWithAppName:(NSString *)appName, ... {
    NSMutableArray *arguments = [NSMutableArray new];
    
    va_list args;
    va_start(args, appName);
    
    if (is_string_empty(appName)) {
        return NO;
    }
    
    NSString *str;
        
    while (YES) {//在循环中遍历
        str = va_arg(args, NSString *);
        if (!str) {//当最后一个参数为nil的时候跳出循环
            break;
        } else {
            [arguments addObject:str];
        }
    }
    
    va_end(args);
    
    NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
    
    if (!arguments.count) {
        // 无参数
        return [workspace launchApplication:appName];
    } else {
        NSURL *url = [NSURL fileURLWithPath:[workspace fullPathForApplication:appName]];
        return [workspace launchApplicationAtURL:url
                                         options:0
                                   configuration:[NSDictionary dictionaryWithObject:arguments forKey:NSWorkspaceLaunchConfigurationArguments]
                                           error:nil] != nil;
    }
}

- (BOOL)openFile:(NSString *)filepath {
    [[NSWorkspace sharedWorkspace] openFile:@"" withApplication:@""];
    return [[NSWorkspace sharedWorkspace] openFile:filepath];
}

- (BOOL)closePreview {
    NSBundle *softBundle = [NSBundle bundleWithPath:app_path_preview];
    NSString *bundleID = [softBundle bundleIdentifier];
    NSArray *array = [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleID];
    if ([array count] > 0) {
        NSRunningApplication *runningApp = [array objectAtIndex:0];
        
        return [runningApp terminate];
    }
    
    return NO;
}

- (BOOL)closeXcode {
    NSBundle *softBundle = [NSBundle bundleWithPath:app_path_xcode];
    NSString *bundleID = [softBundle bundleIdentifier];
    NSArray *array = [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleID];
    if ([array count] > 0) {
        NSRunningApplication *runningApp = [array objectAtIndex:0];
        
        return [runningApp terminate];
    }
    
    return NO;
}

- (NSTask *)openTaskWithFile:(NSString *)filepath { // 未使用
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/open"];
    [task setArguments:[NSArray arrayWithObject:filepath]];
    [task launch];
    
    return task;
}

- (void)closeTask:(NSTask *)task { // 未使用
//    NSTask *worktask = [[NSTask alloc] init];
//    [worktask setLaunchPath:@"/bin/kill"];
//    
//    NSString *argument = [NSString stringWithFormat:@"-9 %d", task.processIdentifier];
//    [worktask setArguments:@[argument]];
//    
//    [worktask launch];
    
    NSBundle *softBundle = [NSBundle bundleWithPath:@"/Applications/Preview.app"];
    NSString *bundleID = [softBundle bundleIdentifier];
    NSArray *array = [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleID];
    if ([array count] > 0) {
        NSRunningApplication *runningApp = [array objectAtIndex:0];
        
        [runningApp terminate];
    }
}

#pragma mark - 开机启动项

// http://blog.csdn.net/pleasurelong/article/details/10828341
// http://stackoverflow.com/questions/26475008/swift-getting-a-mac-app-to-launch-on-startup
// http://blog.csdn.net/lexiaoyao20/article/details/7622867
- (void)setApp:(NSString *)appname loginItemEnabled:(BOOL)enabled {
    if (enabled) {
        LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
        
        //url为app所在的目录
        
        CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath:appname];
        
        LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(loginItems, kLSSharedFileListItemLast, NULL, NULL, url, NULL, NULL);
        
        CFRelease(item);
        
        CFRelease(loginItems);
    } else {
        UInt32 seedValue;
        LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
        CFArrayRef loginItemsArray = LSSharedFileListCopySnapshot(loginItems, &seedValue);
        
        for (id item in (__bridge NSArray *)loginItemsArray) {
            
            LSSharedFileListItemRef itemRef = (__bridge LSSharedFileListItemRef)item;
            
//            extern CFURLRef
//            LSSharedFileListItemCopyResolvedURL(
//                                                LSSharedFileListItemRef           inItem,
//                                                LSSharedFileListResolutionFlags   inFlags,
//                                                CFErrorRef *                      outError)
            
//            extern OSStatus
//            LSSharedFileListItemResolve(
//                                        LSSharedFileListItemRef           inItem,
//                                        LSSharedFileListResolutionFlags   inFlags,
//                                        CFURLRef *                        outURL,
//                                        FSRef *                           outRef)
            CFErrorRef error = nil;
            CFURLRef thePath = LSSharedFileListItemCopyResolvedURL(itemRef, 0, &error);
            if (error == noErr) {
                
//                extern OSStatus
//                LSSharedFileListItemRemove(
//                                           LSSharedFileListRef       inList,
//                                           LSSharedFileListItemRef   inItem)
                
                //appPath目录为要取消开机启动app的路径
                
                if ([[(__bridge NSURL *)thePath path] hasPrefix:appname]) {
                    LSSharedFileListItemRemove(loginItems, itemRef); // 删除指定的启动项
                }
                CFRelease(thePath);                  
                
            }          
            
        }          
        
        CFRelease(loginItemsArray);          
        
        CFRelease(loginItems);
    }
}

@end
