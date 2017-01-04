//
//  Event.m
//  core
//
//  Created by fallen.ink on 08/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "Event.h"

@implementation Event

- (BOOL)is:(NSString *)eventname {
    return [eventname isEqualToString:self.name];
}

@end
