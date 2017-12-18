//
//  CMServiceHandler.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "CMServiceHandler.h"
#import <AFNetworking/AFNetworking.h>
#import "AppDelegate.h"
#import "CMServiceHandler.h"
#import "CMRequest.h"
#import "Reachability.h"
#import "ModelFactory.h"

@interface CMServiceHandler()
@property (nonatomic, assign) BOOL active;
@property (nonatomic, strong, readwrite) NSString* adHocNumber;

@property (nonatomic, strong) Reachability* tcpipReachability;
@property (nonatomic, strong) Reachability* hostReachability;

@property (nonatomic, assign) BOOL useOperatorBearer;
@property (nonatomic, assign, readwrite) BOOL networkAccessible;
@property (nonatomic, assign, readwrite) BOOL networkAccessibleLast;

@end

@implementation CMServiceHandler

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype) init {
    if (self = [super init]) {
        _active = NO;
        _useOperatorBearer = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        _tcpipReachability = [Reachability reachabilityForInternetConnection];
        self.networkAccessible = (self.tcpipReachability.currentReachabilityStatus != NotReachable);
    }
    return self;
}


#pragma mark Matrix product services

- (void) activate {
    NSAssert(!_active, @"Attempting to activate when already activated");
    
    [self deactivate];
    [_tcpipReachability startNotifier];
    
    _hostReachability = [Reachability reachabilityWithHostName:[NSString stringWithFormat:@"%@%@", kCMRequestProtocol, kCMRequestBaseURL]];
    [_hostReachability startNotifier];
    
    _active = YES;
}

- (void) deactivate {
    [_tcpipReachability stopNotifier];
    [_hostReachability  stopNotifier];
    
    _hostReachability = nil;
    
    _active = NO;
}
- (CMRequest*) retrieveNearestStationsForLocation:(NSDictionary*)dict completion:(void (^)(NSArray* array, NSError* error))completion {
    NSAssert(_active, @"Attempting requests before activated");
    
    NSURL* baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kCMRequestProtocol, kCMRequestBaseURL]];
    CMRequest* configRequest = [[CMRequest alloc] initWithBaseURL:baseURL];
    
    typeof(self) __weak weakSelf = self;
    
    [configRequest issueGET:[[NSString stringWithFormat:kCMRequestNearestStops, [dict objectForKey:@"latitude"], [dict objectForKey:@"longitude"]]
                             stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
               withJSONBody:@{@"app_id":appID,@"app_key":appKey}
               onCompletion:^(CMRequest* request, NSDictionary* info, NSError* error) {
                   typeof(self) __strong strongSelf = weakSelf;
                   [strongSelf handleRequestResponse:request ignoreAuth:YES];
                   NSArray *arrayOfStations = [[NSArray alloc] init];
                   
                   if (error) {
                   }
                   else if (info){
                       arrayOfStations = [ModelFactory arrayOfNearByStationsFromDict:info];
                   }
                   
                   if (completion) {
                       completion(arrayOfStations, error);
                   }
               }];
    return configRequest;
}
- (CMRequest*) retrieveTrainInfoForStop:(CMStopPoint*)stop completion:(void (^)(NSDictionary* arrivals, NSError* error))completion {
    NSAssert(_active, @"Attempting requests before activated");
    
    NSURL* baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kCMRequestProtocol, kCMRequestBaseURL]];
    CMRequest* configRequest = [[CMRequest alloc] initWithBaseURL:baseURL];
    
    typeof(self) __weak weakSelf = self;
    [configRequest issueGET:[[NSString stringWithFormat:kCMRequestLiveData, stop.stopPointID]
                             stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
               withJSONBody:@{@"app_id":appID,@"app_key":appKey}
               onCompletion:^(CMRequest* request, NSDictionary* info, NSError* error) {
                   NSDictionary *platformArrivals = [[NSDictionary alloc] init];
                   typeof(self) __strong strongSelf = weakSelf;
                   [strongSelf handleRequestResponse:request ignoreAuth:YES];
                   if (error) {
                   }
                   else if (info){
                        platformArrivals = [ModelFactory arrivalsFromResponse:info];
                   }
                   
                   if (completion) {
                       completion(platformArrivals, error);
                   }
               }];
    return configRequest;
}

- (BOOL) hostAccessible {
    if (!_useOperatorBearer) {
        return (_hostReachability.currentReachabilityStatus == ReachableViaWiFi);
    }
    return (_hostReachability.currentReachabilityStatus != NotReachable);
}

- (void) reachabilityChanged:(NSNotification*) notification {
    self.networkAccessibleLast = self.networkAccessible;
    switch (_tcpipReachability.currentReachabilityStatus) {
        case ReachableViaWiFi:
            self.networkAccessible = (self.tcpipReachability.currentReachabilityStatus != NotReachable);
            break;
        case ReachableViaWWAN:
            self.networkAccessible = self.useOperatorBearer;
            break;
            
        case NotReachable:
        default:
            self.networkAccessible = NO;
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kCMServiceConnectionChange object:[NSNumber numberWithInteger:_tcpipReachability.currentReachabilityStatus]];

}

- (void) handleRequestResponse:(CMRequest*)request ignoreAuth:(BOOL)ignore {
    if (request.responseCode / 100 == 5) {
        // Oops. Server error. Mark unreachable.
        
    }
    
}
@end
