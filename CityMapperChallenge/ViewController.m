//
//  ViewController.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CMServiceHandler.h"

@interface ViewController () {
    CLLocationManager *locationManager;
}

@property (nonatomic, strong) CMServiceHandler* handler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _handler = [[CMServiceHandler alloc] init];
    [_handler activate];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender {
    float latitude = locationManager.location.coordinate.latitude;
    float longitude = locationManager.location.coordinate.longitude;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"latitude"] = @(latitude);
    dict[@"longitude"] = @(longitude);

    [_handler retrieveNearestStationsForLocation:dict completion:^(NSDictionary *dict, NSError *error) {
        NSLog(@"info->%@  error->%@", dict, error);
    }];
    
}
@end
