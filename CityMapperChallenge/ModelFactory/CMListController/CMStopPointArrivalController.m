//
//  CMStopPointArrivalController.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "CMStopPointArrivalController.h"
#import "CMRequest.h"
#import "TimerTarget.h"


@interface CMStopPointArrivalController()
@property (nonatomic, strong) NSTimer* refreshTimer;
@property (nonatomic, weak) CMRequest* outstandingRequest;

@end
@implementation CMStopPointArrivalController

- (void) dealloc {
    // TODO: Cancel any outstanding requests.
    [_refreshTimer invalidate];
    _refreshTimer = nil;
    [self.outstandingRequest cancel];
}

- (instancetype) init {
    NSAssert(NO, @"Use initWithServiceHandler:");
    return nil;
}

- (instancetype) initWithServiceHandler:(CMServiceHandler*)serviceHandler {
    NSAssert(serviceHandler, @"Nil service handler");
    if (self = [super init]) {
        _serviceHandler = serviceHandler;
        [self refreshArrivalTimes];
        TimerTarget* target = [[TimerTarget alloc] initWithTarget:self selector:@selector(refreshArrivalTimes)];
        _refreshTimer = [NSTimer scheduledTimerWithTimeInterval:30.0f
                                                         target:target
                                                       selector:@selector(timerFired:)
                                                       userInfo:nil
                                                        repeats:YES];
    }
    return self;
}

- (void) refreshArrivalTimes {
    NSAssert(_serviceHandler, @"No service handler on refresh");
    if ([self.outstandingRequest.userIdentifier isEqualToString:kRequestRefresh]) {
        return;
    }
    
    typeof(self) __weak weakSelf = self;
    CMStopPoint *point;//todo.
    
    self.outstandingRequest = [_serviceHandler retrieveTrainInfoForStop:point completion:^(NSDictionary *dict, NSError *error) {
        if ([weakSelf.outstandingRequest.userIdentifier isEqualToString:kRequestRefresh]) {
            weakSelf.outstandingRequest = nil;
        }
        if (error) {
            NSLog(@"refresh error received: %@", error);
        }
        else {
            //Do something with the response
        }
    }];
    self.outstandingRequest.userIdentifier = kRequestRefresh;
}


@end


