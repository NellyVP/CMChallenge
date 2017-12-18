//
//  CMStopPointArrivalController.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMServiceHandler.h"
#import "CMStopPoint.h"

extern NSString* const ControllerErrorDomain;


@interface CMStopPointArrivalController : NSObject
@property (nonatomic, strong) CMServiceHandler* serviceHandler;

- (instancetype) initWithServiceHandler:(CMServiceHandler*)serviceHandler;
@end
