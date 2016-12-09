//
//  BaseViewController.h
//  exam
//
//  Created by fallen.ink on 08/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Controller.h"

@class BaseWindowController;

@interface BaseViewController : NSViewController <KTController> {
@private
    BaseWindowController *		wWindowController;
    NSMutableArray *			mSubcontrollers;
    NSMutableArray *			mTopLevelNibObjects;
    NSMutableArray *			mLayerControllers;
    BOOL						mHidden;
}

@property(nonatomic, assign) BaseWindowController *windowController;
@property(nonatomic, readwrite, assign) BOOL hidden;

+ (id)viewControllerWithWindowController:(BaseWindowController *)theWindowController;
- (id)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle windowController:(BaseWindowController *)windowController;
- (BOOL)loadNibNamed:(NSString *)theNibName bundle:(NSBundle *)theBundle;


#pragma mark View
//- (NSView<KTView>*)view;
//- (void)setView:(NSView<KTView>*)theView;

#pragma mark Subcontrollers
- (void)setSubcontrollers:(NSArray *)theSubcontrollers;
- (NSArray *)subcontrollers;
- (void)addSubcontroller:(BaseViewController *)viewController;
- (void)removeSubcontroller:(BaseViewController *)viewController;
- (void)removeAllSubcontrollers;

@end
