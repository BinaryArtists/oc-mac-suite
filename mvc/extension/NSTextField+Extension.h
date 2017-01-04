//
//  NSTextField+Extension.h
//  exam
//
//  Created by fallen.ink on 04/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTextField (Extension)

@property (nonatomic, strong) NSString *text;

// first of all, set its font, and call this!!!
- (CGSize)textSizeWithConstrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

//文字的行数
- (NSUInteger)numbersOfLineWithConstrainedToSize:(CGSize)size;

@end

import_category(NSTextField)
