//
//  BaseWindowController.h
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum : NSUInteger {
    LocateType_placeholder = 10,
    
    LocateType_LeftCenter,      // 水平居左，垂直居中
    LocateType_LeftTop,         // 水平居左，垂直居上
    LocateType_LeftBottom,      // 水平居左，垂直居下
    
    LocateType_CenterCenter,    // 水平居中，垂直居中
    LocateType_CenterTop,       // 水平居中，垂直居上
    LocateType_CenterBottom,    // 水平居中，垂直居下
    
    LocateType_RightCenter,     // 水平居右，垂直居中
    LocateType_RightTop,        // 水平居右，垂直居上
    LocateType_RightBottom      // 水平居右，垂直居下
} LocateType;

@class BaseViewController;

@interface BaseWindowController : NSWindowController {
    @private
    NSMutableArray *_viewControllers;
}

// ----------------------------------
// Supply some life cycle method
// ----------------------------------

- (void)onWindowUpdated;

- (void)onWindowWillClose;

// ----------------------------------
// Custom
// ----------------------------------

- (CGSize)preferredWindowSize;

- (LocateType)preferredWindowLocateType;

- (BOOL)windowCanMove;

- (BOOL)windowShouldFullScreen;

// ----------------------------------
// View controller manage
// ----------------------------------

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

// fallenink
// [self resizeWithNewFrame:CGRectMake(0, 0, 500, 500)];

@interface BaseWindowController (Extension)

- (void)loseFocus;

@end
