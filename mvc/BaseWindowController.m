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

@implementation BaseWindowController

#pragma mark - Initialize

- (id)initWithWindowNibName:(NSString *)theNibName; {
    if (![super initWithWindowNibName:theNibName])
        return nil;
    
    _viewControllers = [[NSMutableArray alloc] init];
    return self;
}

#pragma mark - Life cycle

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.window.title = _defaultWindowTitle_;
}

- (void)windowWillClose:(NSNotification *)notification { // http://blog.csdn.net/perry_xiao/article/details/8738184
//    [NSApp stop:nil];
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
