//
//  TimerTarget.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 18/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface TimerTarget : NSObject
- (id) initWithTarget:(id)target selector:(SEL)selector;
- (void)timerFired:(NSTimer*)theTimer;
@end

