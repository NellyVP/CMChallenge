//
//  CMTubeListViewController.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "CMTubeListViewController.h"
#import "CMTubeListCustomTableCell.h"
#import "CMServiceHandler.h"
#import <CoreLocation/CoreLocation.h>

@interface CMTubeListViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *nearbyStations;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation CMTubeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];

    [self.tableView registerNib:[UINib nibWithNibName:ktubeListCustomTableCellNibName bundle:nil] forCellReuseIdentifier:ktubeListCustomTableCellIdentifier];
    [self.navigationItem setTitle:kTubeListViewTitle];
    self.nearbyStations = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getCurrentLocation];

}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) getCurrentLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    //check if its london, otherwise have a fallback address.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nearbyStations.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CMTubeListCustomTableCell dynamicHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMTubeListCustomTableCell* listViewCell = (CMTubeListCustomTableCell*)[self.tableView dequeueReusableCellWithIdentifier:ktubeListCustomTableCellIdentifier];
    if (!listViewCell) {
        listViewCell = [[[NSBundle mainBundle] loadNibNamed:ktubeListCustomTableCellIdentifier owner:self options:nil] lastObject];
    }
    return listViewCell;
}

-(void)locationManger:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"didUpdateToLocation: %@", [locations lastObject]);
    CLLocation *currentLocation = [locations lastObject];
    float latitude = currentLocation.coordinate.latitude;
    float longitude = currentLocation.coordinate.longitude;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"latitude"] = @(latitude);
    dict[@"longitude"] = @(longitude);
    
    [_serviceHandler retrieveNearestStationsForLocation:dict completion:^(NSDictionary *dict, NSError *error) {
        NSLog(@"info->%@  error->%@", dict, error);
        
        NSDictionary *returnedDict = [dict objectForKey:@"stopPoints"];
        for (NSDictionary *dictionary in returnedDict) {
            CMStopPoint *point = [[CMStopPoint alloc] initWithStopPointID:[dictionary objectForKey:@"naptanId"] facilities:[dictionary objectForKey:@"additionalProperties"] distance:1000];
            [self.nearbyStations addObject:point];
        }
        [self.tableView reloadData];
    }];
    
    [self.locationManager stopUpdatingLocation];
}
@end
