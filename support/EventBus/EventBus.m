//
//  EventBus.m
//  core
//
//  Created by fallen.ink on 08/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "EventBus.h"
#import "../../foundation/extension/NSString+Extension.h"

@interface EventBus () {
    dispatch_queue_t _messageQueue;
}

//@property (nonatomic, strong) NSMapTable *listeners;
@property (nonatomic, strong) NSMutableDictionary *listeners;

@end

@implementation EventBus

- (instancetype)init {
    if (self = [super init]) {
        _messageQueue = dispatch_get_main_queue();
        
//        _listeners = [NSMapTable strongToWeakObjectsMapTable]; // retain 'key', weak 'object'
        _listeners = [NSMutableDictionary new];
    }
    
    return self;
}

#pragma mark - 

- (void)listen:(NSString *)eventName by:(id<EventHandler>)handler {
    if (self.listeners[eventName] == nil) {
        [self.listeners setObject:[NSHashTable weakObjectsHashTable] forKey:eventName];
    }
    
    [self.listeners[eventName] addObject:handler];
}

#pragma mark -

- (void)dispatch:(NSString *)eventName {
    [self dispatch:eventName with:nil];
}

- (void)dispatch:(NSString *)eventName with:(NSObject *)data {
    Event *event = [Event new];
    event.id = [NSString random32];
    event.name = eventName;
    event.data = data;
    
    [self _dispatchEvent:event type:eventName];
}

#pragma mark - 

- (void)_dispatchEvent:(Event *)event type:(NSString * const)type {
    NSHashTable *errorHandlers = self.listeners[type];
    for (id<EventHandler> handler in errorHandlers) {
        dispatch_async(_messageQueue, ^{
            if (handler) {
                [handler onMessage:event];
            }
        });
    }
}

@end
