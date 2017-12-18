//
//  ModelFactory.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CMStopPoint;


@interface ModelFactory : NSObject

+ (NSArray*) arrayOfNearByStationsFromDict:(NSDictionary*)dict;
//+ (CMStopPoint*) stopPointFromDictionary:(NSDictionary*)dict;
+ (NSArray*) facilitiesForStopPoint:(CMStopPoint*)stopP;
+ (NSDictionary*) arrivalsFromResponse:(NSDictionary*)returnDict;

@end
