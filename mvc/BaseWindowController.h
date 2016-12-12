//
//  BaseWindowController.h
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BaseViewController;

@interface BaseWindowController : NSWindowController {
    @private
    NSMutableArray *_viewControllers;
}

- (NSArray *)viewControllers;
- (void)setViewControllers:(NSArray*)theViewControllers;
- (void)addViewController:(BaseViewController *)theViewController;
- (void)removeViewController:(BaseViewController *)theViewController;
- (void)removeAllViewControllers;
- (void)patchResponderChain;

@end

@interface BaseWindowController ( Config )

+ (void)setDefaultWindowTitle:(NSString *)title;

@end
