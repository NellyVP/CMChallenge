//
//  CMRequest.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMCredentials;

typedef NS_ENUM(NSUInteger, CMRequestType) {
    kCMRequestTypeNotIssued = 0,
    kCMRequestTypeGET,
    kCMRequestTypePOST,
    kCMRequestTypePUT,
    kCMRequestTypeDELETE
};

@interface CMRequest : NSObject
@property (nonatomic, strong, readonly) NSString*          relativeURL;
@property (nonatomic, assign, readonly) NSInteger          responseCode;
@property (nonatomic, strong, readonly) NSDictionary*      responseInfo;
@property (nonatomic, strong, readonly) NSError*           responseError;
@property (nonatomic, assign, readonly) CMRequestType  type;
@property (nonatomic, assign)           NSString*          userIdentifier;


- (instancetype) initWithBaseURL:(NSURL*)baseURL;

- (void) issueGET:(NSString*)relativeURL
     withJSONBody:(NSDictionary*)body
     onCompletion:(void (^)(CMRequest* request, NSDictionary* info, NSError* error))completion;

- (void) issuePOST:(NSString*)relativeURL
      withJSONBody:(NSDictionary*)body
      onCompletion:(void (^)(CMRequest* request, NSDictionary* info, NSError* error))completion;

- (void) issuePUT:(NSString*)relativeURL
     withJSONBody:(NSDictionary*)body
     onCompletion:(void (^)(CMRequest* request, NSDictionary* info, NSError* error))completion;

- (void) issueDELETE:(NSString*)relativeURL
        withJSONBody:(NSDictionary*)body
        onCompletion:(void (^)(CMRequest* request, NSDictionary* info, NSError* error))completion;

- (void) cancel;

@end
