//
//  CMStopPoint.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMStopPoint : NSObject
@property (nonatomic, strong, readonly) NSString* stopPointID;
@property (nonatomic, strong, readonly) NSString* stationName;
@property (nonatomic, strong, readonly) NSArray* stationFacilities;
@property (nonatomic, readonly) double distance;

- (instancetype) initWithStopPointID:(NSString*)stopId name:(NSString*)stationName facilities:(NSArray*)facilities distance:(double)distance;


@end
