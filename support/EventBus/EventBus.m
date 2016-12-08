//
//  EventBus.m
//  core
//
//  Created by fallen.ink on 08/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "EventBus.h"

NSString *const MessageEvent = @"message";
NSString *const ErrorEvent = @"error";

@interface EventBus () {
    dispatch_queue_t _messageQueue;
}

@property (nonatomic, strong) NSMapTable *listeners;

@end

@implementation EventBus

- (instancetype)init {
    if (self = [super init]) {
        _messageQueue = dispatch_get_main_queue();
        
        _listeners = [NSMapTable strongToWeakObjectsMapTable]; // retain 'key', weak 'object'
    }
    
    return self;
}

#pragma mark - 

- (void)onMessage:(NSString *)eventName handler:(EventHandler)handler {
    if ([self.listeners objectForKey:eventName] == nil) {
        [self.listeners setObject:[NSHashTable weakObjectsHashTable] forKey:eventName];
    }
    
    [[self.listeners objectForKey:eventName] addObject:handler];
}

- (void)onMessage:(EventHandler)handler {
    [self onMessage:MessageEvent handler:handler];
}

- (void)onError:(EventHandler)handler {
    [self onMessage:ErrorEvent handler:handler];
}


#pragma mark -

- (void)dispatch:(NSString *)eventName {
    [self dispatch:eventName with:nil];
}

- (void)dispatch:(NSString *)eventName with:(NSObject *)data {
    Event *event = [Event new];
    event.id = nil;
    event.event = eventName;
    
    if ([eventName isEqualToString:ErrorEvent]) {
        // is error event
        event.error = (NSError *)data;
    } else {
        // is normal event
        event.data = data;
    }
}

#pragma mark - 

- (void)_dispatchEvent:(Event *)event type:(NSString * const)type {
    NSArray *errorHandlers = [self.listeners objectForKey:type];
    for (EventHandler handler in errorHandlers) {
        dispatch_async(_messageQueue, ^{
            if (handler) {
                handler(event);
            }
        });
    }
}

- (void)_dispatchEvent:(Event *)event {
    [self _dispatchEvent:event type:MessageEvent];
    
    if (event.event != nil) {
        [self _dispatchEvent:event type:event.event];
    }
}


@end
