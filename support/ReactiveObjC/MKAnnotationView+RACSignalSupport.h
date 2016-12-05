//
//  MKAnnotationView+RACSignalSupport.h
//  ReactiveObjC
//
//  Created by Zak Remer on 3/31/15.
//  Copyright (c) 2015 GitHub. All rights reserved.
//

#import <MapKit/MapKit.h>

@class RACSignal<__covariant ValueType>;
@class RACUnit;

@interface MKAnnotationView (RACSignalSupport)

/// A signal which will send a RACUnit whenever -prepareForReuse is invoked upon
/// the receiver.
///
/// Examples
///
///  [[[self.cancelButton
///     rac_signalForControlEvents:UIControlEventTouchUpInside]
///     takeUntil:self.rac_prepareForReuseSignal]
///     subscribeNext:^(UIButton *x) {
///         // do other things
///     }];
@property (nonatomic, strong, readonly) RACSignal<RACUnit *> *rac_prepareForReuseSignal;

@end