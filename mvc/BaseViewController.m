//
//  BaseViewController.m
//  exam
//
//  Created by fallen.ink on 08/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseWindowController.h"

@interface BaseViewController (Private)

- (void)releaseNibObjects;

@end

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - Initialize

//===========================================================
// - initWithNibName
//===========================================================
- (id)initWithNibName:(NSString *)theNibName bundle:(NSBundle *)theBundle windowController:(BaseWindowController *)theWindowController; {
    if (![super initWithNibName:theNibName bundle:theBundle])
        return nil;
    wWindowController = theWindowController;
    mSubcontrollers = [[NSMutableArray alloc] init];
    mTopLevelNibObjects = [[NSMutableArray alloc] init];
    mLayerControllers = [[NSMutableArray alloc] init];
    return self;
}

//===========================================================
// - initWithNibName
//===========================================================
- (id)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle {
    [NSException raise:@"KTViewControllerException" format:@"%@", [NSString stringWithFormat:@"An instance of an KTViewController concrete subclass was initialized using the NSViewController method -initWithNibName:bundle: all view controllers in the enusing tree will have no reference to an KTWindowController object and cannot be automatically added to the responder chain"]];
    return nil;
}

- (BOOL)loadNibNamed:(NSString*)theNibName bundle:(NSBundle*)theBundle {
    BOOL		aSuccess;
    NSArray *	anObjectList = nil;
    NSNib *		aNib = [[NSNib alloc] initWithNibNamed:theNibName bundle:theBundle];
    aSuccess = [aNib instantiateNibWithOwner:self topLevelObjects:&anObjectList];
    if(aSuccess) {
        int i;
        for(i = 0; i < [anObjectList count]; i++)
            [mTopLevelNibObjects addObject:[anObjectList objectAtIndex:i]];
    }
    return aSuccess;
}

+ (id)viewControllerWithWindowController:(BaseWindowController *)theWindowController {
    return [[self alloc] initWithNibName:nil bundle:nil windowController:theWindowController];
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)releaseNibObjects {
    NSInteger i;
    for(i = 0; i < [mTopLevelNibObjects count]; i++) {
        [mTopLevelNibObjects objectAtIndex:i];
    }
}

- (void)setWindowController:(BaseWindowController *)theWindowController {
    wWindowController = theWindowController;
    [[self subcontrollers] makeObjectsPerformSelector:@selector(setWindowController:) withObject:theWindowController];
    [[self windowController] patchResponderChain];
}

- (void)setHidden:(BOOL)theBool {
    mHidden = theBool;
    
    [[self windowController] patchResponderChain];
}

#pragma mark - Subcontrollers

- (void)setSubcontrollers:(NSArray *)theSubcontrollers; {
    if(mSubcontrollers != theSubcontrollers) {
        NSMutableArray * aNewSubcontrollers = [theSubcontrollers mutableCopy];
        mSubcontrollers = aNewSubcontrollers;
        [[self windowController] patchResponderChain];
    }
}

- (NSArray *)subcontrollers {
    return mSubcontrollers;
}

- (void)addSubcontroller:(BaseViewController *)theViewController; {
    [mSubcontrollers addObject:theViewController];
    
    [[self windowController] patchResponderChain];
}

- (void)removeSubcontroller:(BaseViewController *)theViewController; {
    [theViewController removeObservations];
    
    [mSubcontrollers removeObject:theViewController];
    
    [[self windowController] patchResponderChain];
}

- (void)removeAllSubcontrollers {
    [self setSubcontrollers:[NSArray array]];
    [[self windowController] patchResponderChain];
}

- (NSArray *)descendants {
    NSMutableArray *aDescendantsList = [[NSMutableArray alloc] init];
    
    for (BaseViewController * aSubViewController in mSubcontrollers) {
        if([aSubViewController hidden] == NO) {
            [aDescendantsList addObject:aSubViewController];
            if ([[aSubViewController subcontrollers] count] > 0)
                [aDescendantsList addObjectsFromArray:[aSubViewController descendants]];
        }
    }
    
    return aDescendantsList;
}

- (void)removeObservations {
    // subcontrollers
    [mSubcontrollers makeObjectsPerformSelector:@selector(removeObservations)];
    // layer controllers
    [mLayerControllers makeObjectsPerformSelector:@selector(removeObservations)];
}

@end
