//
//  RedeemHelper.m
//  OffPeakSeller
//
//  Created by Shahid Akhtar Shaikh on 12/13/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "RedeemHelper.h"

@implementation RedeemHelper
static NSString* const JSON_RETAILER_ID_KEY = @"retailerId";
static NSString* const JSON_ERROR_CODE_KEY = @"errorCode";
static NSString* const JSON_DATA_KEY = @"data";
+(void)redeemOrderWithEmailId:(NSString*)emailId
                  qrCode:(NSString*)qrCode
       withCompletionBlock : (void(^)(NSDictionary *))success
                andFailure : (void(^)(NSString*)) failure{
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:emailId forKey:@"email"];
    [params setValue:qrCode forKey:@"transactionId"];
    [params setObject:RETAILER_ID forKey:JSON_RETAILER_ID_KEY];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    AANetworkHandler *networkHandler = [[AANetworkHandler alloc] init];
    [networkHandler
     sendJSONRequestToServerWithEndpoint:@"redeemOrder.php"
     withParams:params
     withSuccessBlock:^(NSDictionary *response) {
         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
         success (response);
         
     } withFailureBlock:^(NSError *error) {
         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
         failure(error.description);
     }];
}

@end
