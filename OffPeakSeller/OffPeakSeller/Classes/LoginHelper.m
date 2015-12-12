//
//  LoginHelper.m
//  OffPeakSeller
//
//  Created by Shahid Akhtar Shaikh on 12/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "LoginHelper.h"

@implementation LoginHelper
static NSString* const JSON_RETAILER_ID_KEY = @"retailerId";

+(void)loginWithEmailid:(NSString*)email
               password:(NSString*)password
             andCountry:(NSString*)country
    withCompletionBlock:(void (^)(NSMutableArray *))success
             andFailure:(void (^)(NSString *))failure
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:RETAILER_ID forKey:JSON_RETAILER_ID_KEY];
    [param setObject:email forKey:@"email"];
    [param setObject:password  forKey:@"password"];
    [param setObject:country forKey:@"country"];
    
    AANetworkHandler *networkHandler = [[AANetworkHandler alloc] init];
    [networkHandler sendJSONRequestToServerWithEndpoint:@"seller_login.php" withParams:nil withSuccessBlock:^(NSArray *response) {
        success(response.mutableCopy);
    } withFailureBlock:^(NSError *error) {
        failure(@"Unable to connect to network. Please try again");
    }];
}
@end
