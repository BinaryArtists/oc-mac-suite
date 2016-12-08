//
//  EventBus.h
//  core
//
//  Created by fallen.ink on 08/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Event.h"

@protocol EventHandler <NSObject>

- (void)onMessage:(Event *)event;

@end

@interface EventBus : NSObject

#pragma mark - Listener

// Registers an event handler for the Message event named "eventName".
- (void)listen:(NSString *)eventName by:(id<EventHandler>)handler;

#pragma mark - Dispatcher

- (void)dispatch:(NSString *)eventName;

- (void)dispatch:(NSString *)eventName with:(NSObject *)data;

@end
