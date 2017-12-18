//
//  CMStopPoint.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "CMStopPoint.h"
@interface CMStopPoint()
@property (nonatomic, strong, readwrite) NSString* stopPointID;
@property (nonatomic, strong, readwrite) NSArray* stationFacilities;
@property (nonatomic, readwrite) double distance;

@end
@implementation CMStopPoint



- (instancetype) init {
    NSAssert(NO, @"Use initWithStopPointID:stopId:");
    return nil;
}

- (instancetype) initWithStopPointID:(NSString*)stopId name:(NSString*)stationName facilities:(NSArray*)facilities distance:(double)distance {
    
    if (self = [super init]) {
        _stopPointID         = stopId;
        _stationName        = stationName;
        _stationFacilities  = facilities;
        _distance           = distance;
    }
    return self;
}


@end
