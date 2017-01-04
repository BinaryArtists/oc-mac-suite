//
//  BaseWindowController.m
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "BaseWindowController.h"
#import "BaseViewController.h"

static NSString * _defaultWindowTitle_ = @"test";

@interface BaseWindowController () <NSWindowDelegate> // 这种方法适用SDK 10.6 以上，因为SDK 10.5 还不支持 NSWindowDelegate 。

@end

@implementation BaseWindowController {
    BOOL _isRelocated;
}

#pragma mark - Initialize

- (id)initWithWindowNibName:(NSString *)theNibName; {
    if (![super initWithWindowNibName:theNibName])
        return nil;
    
    _viewControllers = [[NSMutableArray alloc] init];
    
    _isRelocated = NO;
    
    [self observeNotification:NSWindowWillCloseNotification];
    [self observeNotification:NSWindowDidUpdateNotification];
    
    return self;
}

#pragma mark - Life cycle

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.window.title = _defaultWindowTitle_;
    
    // 禁止拖动
    self.window.movable = NO;
    self.window.movableByWindowBackground = NO;
    
    // 禁止窗口缩放
    self.window.showsResizeIndicator = NO;
    [self.window setIsZoomed:NO];
    
    // 禁止最大化
//    NSWindowCloseButton,
//    NSWindowMiniaturizeButton,
//    NSWindowZoomButton,
//    NSWindowToolbarButton,
//    NSWindowDocumentIconButton
    [[self.window standardWindowButton:NSWindowZoomButton] setHidden:YES];
}

- (void)windowWillClose:(NSNotification *)notification {
    [self onWindowWillClose];
    
    [self unobserveAllNotifications];
}

- (BOOL)windowShouldClose:(id)sender {
    [self showAlertWithTitle:@"考试还没有结束，是否确定离开考试？"
                     message:nil
                    onWindow:self.window
               defaultButton:@"是，直接交卷"
                defaultBlock:^{
                    [self stopApplication];
                }
           alternativeButton:@"否，继续答卷"
            alternativeBlock:^{
                
            }];

    return NO;
}

- (void)onWindowUpdated {
    // nothing
}

- (void)onWindowWillClose {
    // nothing
}

#pragma mark - Custom

- (CGSize)preferredWindowSize {
    return self.window.frame.size;
}

- (LocateType)preferredWindowLocateType {
    return LocateType_CenterCenter;
}

#pragma mark - Notification handler

- (void)handleNotification:(NSNotification *)notification {
    if ([notification is:NSWindowWillCloseNotification]) {
        
    } else if ([notification is:NSWindowDidUpdateNotification]) {
        if (!_isRelocated) {
            LocateType locateType = [self preferredWindowLocateType];
            CGRect screenRect = [[NSScreen mainScreen] frame];
            CGSize selfSize = [self preferredWindowSize];
            NSRect newFrame = NSZeroRect;
            
            switch (locateType) {
                case LocateType_CenterCenter: // 水平居中，垂直居中
                {
                    CGFloat x = (screenRect.size.width - selfSize.width) / 2;
                    CGFloat y = (screenRect.size.height - selfSize.height) / 2;
                    newFrame = NSMakeRect(x, y, selfSize.width, selfSize.height);
                }
                    break;
                    
                default:
                    break;
            }
            
            [self.window setFrame:newFrame display:YES animate:NO];
            
            _isRelocated = YES;
        }
        
        [self onWindowUpdated];
    }
}

#pragma mark - ViewControllers

- (void)setViewControllers:(NSArray *)theViewControllers {
    if(_viewControllers != theViewControllers) {
        NSMutableArray * aNewViewControllers = [theViewControllers mutableCopy];
        
        _viewControllers = aNewViewControllers;
    }
}

- (NSArray *)viewControllers {
    return _viewControllers;
}

- (void)addViewController:(BaseViewController *)theViewController {
    BaseViewController *topViewController = [_viewControllers lastObject];
    
    [_viewControllers addObject:theViewController];
    
    if (topViewController) {
        [topViewController.view addSubview:theViewController.view];
        theViewController.view.frame = [topViewController.view bounds];
        
        // fallenink
//        BVCNextViewController *viewController = [BVCNextViewController viewController];
//        [self.view.window.contentView replaceSubview:self.view with:viewController.view];
    } else {
        [self.window.contentView addSubview:theViewController.view]; // 会触发 NSViewController's viewDidLoad
        theViewController.view.frame = [self.window.contentView bounds];
    }
    
    [self patchResponderChain];
}

- (void)removeViewController:(BaseViewController *)theViewController {
    if ([_viewControllers containsObject:theViewController]) {
        [theViewController.view removeFromSuperview];
    }
    
    [_viewControllers removeObject:theViewController];
    
    [self patchResponderChain];
}

- (void)removeAllViewControllers {
    [_viewControllers removeAllObjects];
}

- (void)patchResponderChain {
    NSMutableArray * aFlatViewControllersList = [NSMutableArray array];
    for (BaseViewController *aViewController in _viewControllers) { // flatten the view controllers into an array
        if([aViewController hidden] == NO)
        {
            [aFlatViewControllersList addObject:aViewController];
            [aFlatViewControllersList addObjectsFromArray:[aViewController descendants]];
        }
    }
    
    if([aFlatViewControllersList count] > 0) {
        [self setNextResponder:[aFlatViewControllersList objectAtIndex:0]];
        NSUInteger i = 0;
        NSUInteger viewControllerCount = [aFlatViewControllersList count] - 1;
        for (i = 0; i < viewControllerCount ; i++) {
            // set the next responder of each controller to the next, the last in the array has no next responder.
            [[aFlatViewControllersList objectAtIndex:i] setNextResponder:[aFlatViewControllersList objectAtIndex:i + 1]];
        }
        [[aFlatViewControllersList lastObject] setNextResponder:nil];
    }
}


@end

@implementation BaseWindowController ( Config )

+ (void)setDefaultWindowTitle:(NSString *)title {
    _defaultWindowTitle_ = title;
}

@end

// ========================================================  NSWindow 设置
// [_window setMovableByWindowBackground:YES];  //可以拖动
// self.window.styleMask = NSTexturedBackgroundWindowMask;  //窗口的样式；金属
// self.window.styleMask =NSFullScreenWindowMask;
// self.window.styleMask =NSClosableWindowMask; //是否有标题栏
// self.window.styleMask =NSMiniaturizableWindowMask;
// ========================================================  NSWIndow 的大小
// self.window.styleMask =NSFloatingWindowLevel ;
// self.window.styleMask =NSStatusWindowLevel ; // 显示全频按钮
// self.window.styleMask =NSPopUpMenuWindowLevel ; //透明的没有标题栏窗口；
// self.window.styleMask= kCGMinimumWindowLevelKey; //有标题栏但是没有什么东西
// self.window.styleMask= kCGBaseWindowLevelKey;  ////没有有标题栏但输入框不能编辑
// self.window.styleMask= kCGDesktopWindowLevelKey; //没有有标题栏但输入框可以编辑
// self.window.styleMask= kCGBackstopMenuLevelKey;  //有标题栏 但是没有缩小按钮
// self.window.styleMask= kCGFloatingWindowLevelKey;//有标题栏 但是只有缩小按钮
// self.window.styleMask= kCGTornOffMenuWindowLevelKey;//没有标题栏 输入框需要用户去选择
// self.window.styleMask= kCGDockWindowLevelKey;//有标题栏 没有全屏按钮 默认选入第一个输入框；
// self.window.styleMask= kCGMainMenuWindowLevelKey; //没有有标题栏但输入框可以编辑 用户可以自定以大小
// self.window.styleMask= kCGAssistiveTechHighWindowLevelKey;//没有标题栏 运行次数多了 窗口就越来越小 直到没有；
// self.window.styleMask= kCGUtilityWindowLevelKey;//有标题栏，没有编辑按钮
// self.window.styleMask= kCGHelpWindowLevelKey;//没有标题栏，没有编辑按钮
// self.window.backgroundColor =[NSColor colorWithCalibratedRed:0.5f green:0.8f blue:0.9f alpha:1.0];  //背景色
