//
//  CMStationArrival.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 18/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "CMStationArrival.h"
@interface CMStationArrival ()

@property (nonatomic, strong, readwrite) NSString* stationID;
@property (nonatomic, strong, readwrite) NSString* stationName;
@property (nonatomic, strong, readwrite) NSString* lineName;
@property (nonatomic, strong, readwrite) NSString* lineID;
@property (nonatomic, strong, readwrite) NSString* platformName;
@property (nonatomic, strong, readwrite) NSString* towards;
@property (nonatomic, strong, readwrite) NSString* destination;
@property (nonatomic, strong, readwrite) NSDate* expectedArrival;
@end

@implementation CMStationArrival


- (instancetype) init {
    NSAssert(NO, @"Use initWithStopPointID:stopId:");
    return nil;
}

- (instancetype) initWithID:(NSString*)stationID name:(NSString*)name lineName:(NSString*)lineName platform:(NSString*)platName towards:(NSString*)towards dest:(NSString*)destination arrival:(NSDate*)arrival {
    if (self = [super init]) {
        _stationID = stationID;
        _stationName = name;
        _lineName = lineName;
        _platformName = platName;
        _towards = towards;
        _destination = destination;
        _expectedArrival = arrival;
    }
    return self;
}
@end
