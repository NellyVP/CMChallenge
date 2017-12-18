//
//  CMStationArrival.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 18/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMStationArrival : NSObject
@property (nonatomic, strong, readonly) NSString* stationID;
@property (nonatomic, strong, readonly) NSString* stationName;
@property (nonatomic, strong, readonly) NSString* lineName;
@property (nonatomic, strong, readonly) NSString* lineID;
@property (nonatomic, strong, readonly) NSString* platformName;
@property (nonatomic, strong, readonly) NSString* towards;
@property (nonatomic, strong, readonly) NSString* destination;
@property (nonatomic, strong, readonly) NSDate* expectedArrival;

- (instancetype) initWithID:(NSString*)stationID name:(NSString*)name lineName:(NSString*)lineName platform:(NSString*)platName towards:(NSString*)towards dest:(NSString*)destination arrival:(NSDate*)arrival;

@end
