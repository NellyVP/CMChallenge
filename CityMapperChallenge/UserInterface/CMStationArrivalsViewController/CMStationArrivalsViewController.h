//
//  CMStationArrivalsViewController.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 18/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMStopPoint;
@class CMServiceHandler;

@interface CMStationArrivalsViewController : UIViewController
@property (nonatomic, strong) CMStopPoint* stopPoint;
@property (nonatomic, strong) CMServiceHandler* serviceHandler;

@end
