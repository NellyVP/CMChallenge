//
//  Constants.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef Constants_h
#define Constants_h


static NSString* const kCMRequestInsecureProtocol    = @"http://";
static NSString* const kCMRequestProtocol            = @"https://";
static NSString* const kCMRequestBaseURL             = @"api.tfl.gov.uk";
static NSString* const kCMRequestNearestStops        = @"/StopPoint?radius=%@&stopTypes=NaptanMetroStation&lat=%@&lon=%@";
static NSString* const kCMRequestLiveData            = @"/StopPoint/%@/Arrivals?mode=tube";
//https://api.tfl.gov.uk/StopPoint?radius=1000&stopTypes=NaptanMetroStation&lat=51.580091&lon=-0.197654


// Notification for server list exhaustion
static NSString* const kCMServiceConnectionChange      = @"MatrixServiceConnectionChange";
static NSString* const appKey                          = @"MatrixServiceConnectionChange";
static NSString* const appID                           = @"MatrixServiceConnectionChange";

#endif /* Constants_h */
