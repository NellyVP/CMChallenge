//
//  CMStopPoint.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "CMStopPoint.h"
@interface CMStopPoint()
@property (nonatomic, strong, readwrite) NSString* stopPintID;
@property (nonatomic, strong, readwrite) NSArray* stationFacilities;
@property (nonatomic, readwrite) double distance;

@end
@implementation CMStopPoint



- (instancetype) init {
    NSAssert(NO, @"Use initWithUserContact:userUUID:");
    return nil;
}

- (instancetype) initWithStopPointID:(NSString*)stopId facilities:(NSArray*)facilities distance:(double)distance {
    
    if (self = [super init]) {
        _stopPintID = stopId;
        _stationFacilities = facilities;
        _distance = distance;
    }
    return self;
}


@end
