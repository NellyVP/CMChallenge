//
//  CMStopPoint.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMStopPoint : NSObject
@property (nonatomic, strong, readonly) NSString* stopPintID;
@property (nonatomic, strong, readonly) NSArray* stationFacilities;
@property (nonatomic, readonly) double distance;

- (instancetype) initWithStopPointID:(NSString*)stopId facilities:(NSArray*)facilities distance:(double)distance;


@end
