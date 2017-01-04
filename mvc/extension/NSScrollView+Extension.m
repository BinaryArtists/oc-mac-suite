//
//  NSScrollView+Extension.m
//  exam
//
//  Created by fallen.ink on 04/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#import "NSScrollView+Extension.h"

@implementation NSScrollView (Extension)

+ (instancetype)verticalScrollView {
    NSScrollView *scrollView = [NSScrollView new];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:NO];
    
    NSView *documentView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 0, 0)];
    scrollView.documentView = documentView;
    
    NSView *superView = documentView.superview;
    [documentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(superView.mas_leading);
        make.trailing.equalTo(superView.mas_trailing);
        make.top.equalTo(superView.mas_top);
        make.height.mas_equalTo(200);
    }];
    
    return scrollView;
}

@end

def_import_category(NSScrollView)
