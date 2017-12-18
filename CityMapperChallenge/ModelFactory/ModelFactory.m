//
//  ModelFactory.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "ModelFactory.h"
#import "CMStopPoint.h"

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

@end
