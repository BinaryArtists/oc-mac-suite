//
//  WebView+Extension.m
//  exam
//
//  Created by fallen.ink on 12/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "WebView+Extension.h"

@implementation WebView (Extension)

- (void)f5 {
    [[[[self mainFrame] frameView] documentView] layout];
}

@end
