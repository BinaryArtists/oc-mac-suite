//
//  NSTextField+Extension.m
//  exam
//
//  Created by fallen.ink on 04/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#import "NSTextField+Extension.h"

@implementation NSTextField (Extension)

// ----------------------------------
// make properties
// ----------------------------------

- (NSString *)text {
    return self.stringValue;
}

- (void)setText:(NSString *)text {
    self.stringValue = text;
}

// ----------------------------------
//
// ----------------------------------

- (CGSize)textSizeWithConstrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName];
        textSize = [self.text sizeWithAttributes:attributes];
    } else {
        NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin;
        // NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。
        // 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略
        // NSStringDrawingUsesFontLeading计算行高时使用行间距。（译者注：字体大小+行间距=行高）
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName];
        
        TODO("注意：这里用旧API，替换了新的！旧的将在10.11后废弃")
//        CGRect rect = [self.text boundingRectWithSize:size options:option attributes:attributes context:nil];
        CGRect rect = [self.text boundingRectWithSize:size options:option attributes:attributes];
        
        textSize = rect.size;
    }
    return CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
}

- (CGSize)textSizeForOneLine {
    return [self textSizeWithConstrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
}

- (NSUInteger)numbersOfLineWithConstrainedToSize:(CGSize)size {
    CGFloat realHeight = [self textSizeWithConstrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping].height;
    
    // 要去掉空白字符，去掉换行符等
    NSString *fixedString = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    fixedString = [fixedString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    fixedString = [fixedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSTextField *text = [NSTextField new];
    text.font = self.font;
    text.text = fixedString;
    
    CGFloat oneLineHeight = [text textSizeForOneLine].height;

    return (NSUInteger)ceilf(realHeight/oneLineHeight);
}

@end

def_import_category(NSTextField)
