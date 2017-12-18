//
//  TimerTarget.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 18/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "TimerTarget.h"

@interface TimerTarget()
@property (weak, nonatomic) id realTarget;
@property (nonatomic) SEL realSelector;
@end

@implementation TimerTarget

- (id) init {
    NSAssert(NO, @"Wrong TimerTarget init");
    return nil;
}

- (void)timerFired:(NSTimer*)theTimer {
    IMP imp = [self.realTarget methodForSelector:self.realSelector];
    if (!imp) {
        return;
    }
    void (*func)(id, SEL, NSTimer*) = (void *)imp;
    func(self.realTarget, self.realSelector, theTimer);
}

- (id) initWithTarget:(id)target selector:(SEL)selector {
    if (self = [super init]) {
        self.realTarget = target;
        self.realSelector = selector;
    }
    return self;
}
@end
