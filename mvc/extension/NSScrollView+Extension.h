//
//  NSScrollView+Extension.h
//  exam
//
//  Created by fallen.ink on 04/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSScrollView (Extension)

// U should update documentView 's height at [layout] function, like as below:
/*
- (void)layout {
    [super layout];
    
    NSView *view = _contentView.documentView;
    CGFloat contentHeight = _top > _contentView.height ? _top : _contentView.height;
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(contentHeight);
    }];
}
 */
+ (instancetype)verticalScrollView;

@end

import_category(NSScrollView)
