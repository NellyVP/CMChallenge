//
//  CMStationArrivalsViewController.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 18/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "CMStationArrivalsViewController.h"
#import "CMServiceHandler.h"

@interface CMStationArrivalsViewController ()

@end

@implementation CMStationArrivalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationItem setTitle:@"Live arrivals"];
    
    [self.serviceHandler retrieveTrainInfoForStop:self.stopPoint completion:^(NSDictionary *dict, NSError *error) {
        NSLog(@"info->%@  error->%@", dict, error);

    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
