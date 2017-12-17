//
//  CMServiceHandler.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMRequest.h"

/*
 Offers service-level requests.
 Handles priority list updating and requests.
 Handles connectivity changes. Notifies application of service availability - fatal/temporary.
 */

@interface CMServiceHandler : NSObject
@property (nonatomic, assign, readonly) BOOL active;
@property (nonatomic, assign, readonly) BOOL networkAccessible;
@property (nonatomic, assign, readonly) BOOL networkAccessibleLast;
@property (nonatomic, assign, readonly) BOOL serialisedURLList;


- (void) activate;
- (void) deactivate;
- (BOOL) networkAccessible;
- (BOOL) hostAccessible;


- (CMRequest*) retrieveNearestStationsForLocation:(NSDictionary*)dict completion:(void (^)(NSDictionary* dict, NSError* error))completion;
- (CMRequest*) retrieveTrainInfoForStop:(NSString*)stop completion:(void (^)(NSDictionary*dict, NSError* error))completion;


@end
