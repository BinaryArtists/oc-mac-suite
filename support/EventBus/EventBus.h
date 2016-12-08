//
//  EventBus.h
//  core
//
//  Created by fallen.ink on 08/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Event.h"

typedef void (^EventHandler)(Event *event);

extern NSString *const MessageEvent;
extern NSString *const ErrorEvent;

@interface EventBus : NSObject

#pragma mark - Listener

// Registers an event handler for the Message event named "eventName".
- (void)onMessage:(NSString *)eventName handler:(EventHandler)handler;

// Registers an event handler for the Message event.
- (void)onMessage:(EventHandler)handler;

// Registers an event handler for the Error event.
- (void)onError:(EventHandler)handler;

#pragma mark - Dispatcher

- (void)dispatch:(NSString *)eventName;

- (void)dispatch:(NSString *)eventName with:(NSObject *)data;

@end
