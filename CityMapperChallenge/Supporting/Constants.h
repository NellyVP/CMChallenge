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

//API request strings
static NSString* const kCMRequestInsecureProtocol        = @"http://";
static NSString* const kCMRequestProtocol                = @"https://";
static NSString* const kCMRequestBaseURL                 = @"api.tfl.gov.uk";
static NSString* const kCMRequestNearestStops            = @"/StopPoint?radius=1500&stopTypes=NaptanMetroStation&lat=%@&lon=%@";
static NSString* const kCMRequestLiveData                = @"/StopPoint/%@/Arrivals";

static NSString* const kControllerErrorDomain            = @"Conference Controller Domain";
static NSString* const kRequestRefresh                   = @"RequestRefresh";


//ConnectionHandler string
static NSString* const kCMServiceConnectionChange        = @"CMServiceConnectionChange";


//General
static NSString* const appKey                            = @"ae8272cc41777157cff48db298a5eddf";
static NSString* const appID                             = @"50b45e29";


//Custom UI Idenifiers
static NSString* const ktubeListCustomTableCellNibName   = @"CMTubeListCustomTableCell";
static NSString* const ktubeListCustomTableCellIdentifier= @"CMTubeListCustomTableCellId";


//View Titles
static NSString* const kTubeListViewTitle                = @"Nearest Tube Stations";

#endif /* Constants_h */
