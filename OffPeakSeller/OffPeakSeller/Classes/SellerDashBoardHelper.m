//
//  SellerDashBoardHelper.m
//  OffPeakSeller
//
//  Created by Shahid Akhtar Shaikh on 12/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "SellerDashBoardHelper.h"

@implementation SellerDashBoardHelper
static NSString* const JSON_RETAILER_ID_KEY = @"retailerId";
static NSString* const JSON_ERROR_CODE_KEY = @"errorCode";
static NSString* const JSON_DATA_KEY = @"data";
+(void)getSellerInfoEmailId:(NSString*)emailId
         withCompletionBlock : (void(^)(NSDictionary *))success
                  andFailure : (void(^)(NSString*)) failure{
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:emailId forKey:@"email"];
    [params setObject:RETAILER_ID forKey:JSON_RETAILER_ID_KEY];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    AANetworkHandler *networkHandler = [[AANetworkHandler alloc] init];
    [networkHandler
     sendJSONRequestToServerWithEndpoint:@"seller_dashboard.php"
     withParams:params
     withSuccessBlock:^(NSDictionary *response) {
         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
         if([response objectForKey:JSON_ERROR_CODE_KEY])
         {
             if([[response objectForKey:JSON_ERROR_CODE_KEY] integerValue]==1)
             {
                 if ([response objectForKey:JSON_DATA_KEY]) {
                     success ([response objectForKey:JSON_DATA_KEY]);
                 }else{
                     failure(@"Invalid input");
                 }
             }
             else
             {
                 
             }
             
         }else
         {
             failure(@"Invalid input");
         }
     } withFailureBlock:^(NSError *error) {
         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
         failure(error.description);
     }];
}

@end
