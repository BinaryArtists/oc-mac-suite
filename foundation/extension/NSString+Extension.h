//
//  NSString+Extension.h
//  exam
//
//  Created by fallen.ink on 01/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString *)append:(NSString *)string;

- (BOOL)is:(NSString *)aString;

// generate 32 bytes randomly string.
+ (NSString *)random32;

@end

import_category(NSString)
