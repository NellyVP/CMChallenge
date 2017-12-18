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
#import "CMStationArrivalsViewController.h"

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
    
    self.tableView.estimatedRowHeight = [CMTubeListCustomTableCell dynamicHeight];
    self.tableView.rowHeight = UITableViewAutomaticDimension;

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

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [CMTubeListCustomTableCell dynamicHeight];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMTubeListCustomTableCell* listViewCell = (CMTubeListCustomTableCell*)[self.tableView dequeueReusableCellWithIdentifier:ktubeListCustomTableCellIdentifier];
    if (!listViewCell) {
        listViewCell = [[[NSBundle mainBundle] loadNibNamed:ktubeListCustomTableCellIdentifier owner:self options:nil] lastObject];
    }
    CMStopPoint *point = [self.nearbyStations objectAtIndex:indexPath.row];
    listViewCell.stationName.text = point.stationName;
    
    return listViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CMStationArrivalsViewController *arrivalsVC = [[CMStationArrivalsViewController alloc] initWithNibName:@"CMStationArrivalsViewController" bundle:nil];
    arrivalsVC.stopPoint = [self.nearbyStations objectAtIndex:indexPath.row];
    arrivalsVC.serviceHandler = self.serviceHandler;
    [self.navigationController pushViewController:arrivalsVC animated:YES];
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
    
    typeof(self) __weak weakSelf = self;

    [_serviceHandler retrieveNearestStationsForLocation:dict completion:^(NSArray *array, NSError *error) {
        NSLog(@"info->%@  error->%@", array, error);
        weakSelf.nearbyStations = array.mutableCopy;
        [weakSelf.tableView reloadData];
    }];
    
    [self.locationManager stopUpdatingLocation];
}
@end
