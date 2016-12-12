//
//  NSWorkspace+Extension.h
//  core
//
//  Created by fallen.ink on 12/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// Process Dictionary keys
//
// NOTE: According to ProcessInformationCopyDictionary, the following may not be
// in the dictionary depending on the type of process:
//   kGTMWorkspaceRunningParentPSN, kGTMWorkspaceRunningFileType,
//   kGTMWorkspaceRunningFileCreator, kGTMWorkspaceRunningPID,
//   kGTMWorkspaceRunningBundlePath, kGTMWorkspaceRunningBundleIdentifier,
//   kGTMWorkspaceRunningBundleName, kGTMWorkspaceRunningBundleExecutable,
// And experience says the follow might also not be there:
//   kGTMWorkspaceRunningIsHidden

// Make sure to use numberToProcessSerialNumber: on the return values
// of these keys to get valid PSNs on both Leopard and Tiger.
// Numeric types come back as a NSNumber.
EXTERN NSString *const kGTMWorkspaceRunningPSN;  // long long
EXTERN NSString *const kGTMWorkspaceRunningParentPSN;  // long long

EXTERN NSString *const kGTMWorkspaceRunningFlavor;  // SInt32
EXTERN NSString *const kGTMWorkspaceRunningAttributes;  // SInt32
EXTERN NSString *const kGTMWorkspaceRunningFileType;  // NSString
EXTERN NSString *const kGTMWorkspaceRunningFileCreator;  // NSString
EXTERN NSString *const kGTMWorkspaceRunningPID;  // long
EXTERN NSString *const kGTMWorkspaceRunningLSBackgroundOnly;  // bool
EXTERN NSString *const kGTMWorkspaceRunningLSUIElement;  // bool
EXTERN NSString *const kGTMWorkspaceRunningIsHidden;  // bool
EXTERN NSString *const kGTMWorkspaceRunningCheckedIn;  // bool
EXTERN NSString *const kGTMWorkspaceRunningLSUIPresentationMode;  // Short
EXTERN NSString *const kGTMWorkspaceRunningBundlePath;  // NSString
EXTERN NSString *const kGTMWorkspaceRunningBundleVersion;  // NSString

// The docs for ProcessInformationCopyDictionary say we should use the constants
// instead of the raw string values, so map our values to those keys.
#define kGTMWorkspaceRunningBundleIdentifier  (NSString*)kCFBundleIdentifierKey // NSString
#define kGTMWorkspaceRunningBundleName        (NSString*)kCFBundleNameKey // NSString
#define kGTMWorkspaceRunningBundleExecutable  (NSString*)kCFBundleExecutableKey // NSString

@interface NSWorkspace (Extension)

// ----------------------------------
// GTMWorkspaceRunningAdditions
// ----------------------------------
- (BOOL)gtm_isAppWithIdentifierRunning:(NSString *)identifier; // Returns a YES/NO if a process w/ the given identifier is running
- (NSDictionary *)gtm_processInfoDictionary; // Returns a dictionary with info for our process. See Process Dictionary Keys above for values
- (NSDictionary *)gtm_processInfoDictionaryForActiveApp; // Returns a dictionary with info for the active process. See Process Dictionary Keys above for values
- (NSDictionary *)gtm_processInfoDictionaryForPID:(pid_t)pid; // Returns a dictionary with info for the process. See Process Dictionary Keys above for values
- (NSDictionary *)gtm_processInfoDictionaryForPSN:(const ProcessSerialNumberPtr)psn; // Returns a dictionary with info for the process. See Process Dictionary Keys above for values
- (BOOL)gtm_wasLaunchedAsLoginItem; // Returns true if we were launched as a login item.
- (BOOL)gtm_wasLaunchedByProcess:(NSString*)bundleid; // Returns true if we were launched by a given bundleid
- (BOOL)gtm_processSerialNumber:(ProcessSerialNumber*)outPSN
                   withBundleID:(NSString*)bundleID; // Returns true if the PSN was found for the running app with bundleID
- (ProcessSerialNumber)gtm_numberToProcessSerialNumber:(NSNumber *)number; // Converts PSNs stored in NSNumbers to real PSNs

// Returns a dictionary of launched applications like
// -[NSWorkspace launchedApplications], but does it much faster than the current
// version in Leopard which appears to regenerate the dictionary from scratch
// each time you request it.
// NB The main runloop has to run for this to stay up to date.
- (NSArray *)gtm_launchedApplications;

@end

import_category( NSWorkspace )
