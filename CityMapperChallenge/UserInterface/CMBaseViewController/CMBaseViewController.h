//
//  CMBaseViewController.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMServiceHandler;

@interface CMBaseViewController : UIViewController
@property (nonatomic, strong) CMServiceHandler* serviceHandler;
@property (nonatomic, strong) UIViewController* contentViewController;
@end
