//
//  ModelFactory.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "ModelFactory.h"
#import "CMStopPoint.h"
#import "CMStationArrival.h"

// create a logic that could extract all info about the station facilities from the big dict
// cretae a logic where you could extract different platform info from the returned dict
// create the stopPoint station - only use the tube stations



@implementation ModelFactory
+ (NSArray*) arrayOfNearByStationsFromDict:(NSDictionary*)dict {
    NSAssert(dict, @"No dictionary supplied");
    
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    NSArray* info = [dict objectForKey:@"stopPoints"];
    if (![info isKindOfClass:[NSArray class]]) info = nil;
    
    for (NSDictionary *dictionary in info) {
        CMStopPoint *point = [self stopPointFromDictionary:dictionary];
        if (point) {
            [returnArray addObject:point];
        }
    }
    return returnArray;
}

+ (CMStopPoint*) stopPointFromDictionary:(NSDictionary*)dict {
    NSAssert(dict, @"No dictionary supplied");
    id value = [dict objectForKey:@"commonName"];
    NSString *name = [value isKindOfClass:[NSString class]] ? value : nil;
    
    value = [dict objectForKey:@"naptanId"];
    NSString *naptanId = [value isKindOfClass:[NSString class]] ? value : nil;
    
    double distance = 0;
    value = [dict objectForKey:@"distance"];
    if ([value isKindOfClass:[NSNumber class]]) {
        distance = [value doubleValue];
    }
    value = [dict objectForKey:@"additionalProperties"];
    NSArray *arrayOfFacilities;
    if ([value isKindOfClass:[NSArray class]]) {
        arrayOfFacilities = [self stationFacilitiesFromArray:value];
    }
    CMStopPoint *point = [[CMStopPoint alloc] initWithStopPointID:naptanId name:name facilities:arrayOfFacilities distance:distance];
    return point;
}

+ (NSArray*) facilitiesForStopPoint:(CMStopPoint*)stopP {
    NSAssert(stopP, @"No stopP supplied");
    NSArray* array;
    return array;
}

+ (NSArray*) stationFacilitiesFromArray:(NSArray*)array {
    NSAssert(array, @"No array supplied");
    NSMutableArray* stationFacilities = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        NSString *facilityName;
        id value = [dict objectForKey:@"category"];
        NSString *categoryName = [value isKindOfClass:[NSString class]] ? value : nil;
        if ([categoryName isEqualToString:@"Facility"]) {
            BOOL available = NO;
            value = [dict objectForKey:@"value"];
            if (![value isEqualToString:@"0"] || ![value isEqualToString:@"no"]) {
                available = YES;
                facilityName =  [[dict objectForKey:@"key"] isKindOfClass:[NSString class]] ? [dict objectForKey:@"key"]  : nil;
                [stationFacilities addObject:facilityName];
            }
        }
    }
    return stationFacilities;
}

+ (NSArray*) arrayOfExistingPlatforms:(NSDictionary*)info {
    NSMutableArray* arrayOfPlatforms = [[NSMutableArray alloc] init];
    for (NSDictionary*dict in info) {
        id value = [dict objectForKey:@"platformName"];
        NSString *platformName = [value isKindOfClass:[NSString class]] ? value : nil;
        if (platformName &&  ![arrayOfPlatforms containsObject: platformName]) {
            [arrayOfPlatforms addObject:platformName];
        }
    }
    return arrayOfPlatforms;
}

+ (NSDictionary*) arrivalsFromResponse:(NSDictionary*)returnDict {
    NSAssert(returnDict, @"No dictionary supplied");
    NSMutableArray *arrayOfArrivals = [[NSMutableArray alloc] init];
    NSMutableDictionary *platformArrivals = [[NSMutableDictionary alloc] init];

    for (NSDictionary*dict in returnDict) {
        id value = [dict objectForKey:@"naptanId"];
        NSString *stationId = [value isKindOfClass:[NSString class]] ? value : nil;

        value = [dict objectForKey:@"stationName"];
        NSString *stationName = [value isKindOfClass:[NSString class]] ? value : nil;
        
        value = [dict objectForKey:@"lineName"];
        NSString *lineName = [value isKindOfClass:[NSString class]] ? value : nil;
        
        value = [dict objectForKey:@"platformName"];
        NSString *platform = [value isKindOfClass:[NSString class]] ? value : nil;
        
        value = [dict objectForKey:@"towards"];
        NSString *towards = [value isKindOfClass:[NSString class]] ? value : nil;
        
        value = [dict objectForKey:@"destination"];
        NSString *destination = [value isKindOfClass:[NSString class]] ? value : nil;
        
        value = [dict objectForKey:@"expectedArrival"];
        NSDate* expectedArrival = nil;
        if ([value isKindOfClass:[NSString class]]) {
            NSString* dateTimeString = (NSString*)value;
            NSAssert([value isKindOfClass:[NSString class]], @"id wrong type");
            expectedArrival = [[self class] dateFromRFC3339String:dateTimeString];
        }
        
        CMStationArrival *arrival = [[CMStationArrival alloc] initWithID:stationId name:stationName lineName:lineName platform:platform towards:towards dest:destination arrival:expectedArrival];

        if (arrival) {
            [arrayOfArrivals addObject:arrival];
        }
        NSArray* arrayOfPlatforms =  [[self class] arrayOfExistingPlatforms:returnDict];
        for (NSString *platName in arrayOfPlatforms) {
            NSMutableArray *arrivals = [[NSMutableArray alloc] init];
            [arrayOfArrivals enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CMStationArrival *arrival = (CMStationArrival*)obj;
                if ([arrival.platformName isEqualToString:platName]) {
                    [arrivals addObject:arrival];
                }
            }];
            
            if (arrivals.count) {
                [platformArrivals setObject:arrivals forKey:platName];
            }
         }
    }
    return platformArrivals;
}
+ (NSDate*) dateFromRFC3339String:(NSString*) rfc3339String {
    if (!rfc3339String.length){
        return nil;
    }
    NSDate* sent = nil;
    
    // Convert delay, if any to NSDate
    NSDateFormatter *rfc3339DateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [rfc3339DateFormatter setLocale:enUSPOSIXLocale];
    [rfc3339DateFormatter setDateFormat:@"yyyy-MM-dd' 'HH':'mm':'ss"];
    [rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // Convert the RFC 3339 date time string to an NSDate.
    sent = [rfc3339DateFormatter dateFromString:rfc3339String];
    return sent;
}


@end
