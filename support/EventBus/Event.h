//
//  Event.h
//  core
//
//  Created by fallen.ink on 08/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) id id;

@property (nonatomic, strong) NSString *name; // event name

@property (nonatomic, strong) NSObject *data; // event data

- (BOOL)is:(NSString *)eventname;

@end
