//
//  AAOrderHistoryHelper.m
//  AppWiz
//
//  Created by Shahid Akhtar Shaikh on 11/12/15.
//  Copyright © 2015 Shaikh Shahid Akhtar. All rights reserved.
//

#import "AAOrderHistoryHelper.h"
@implementation AAOrderHistoryHelper
static NSString* const JSON_RETAILER_ID_KEY = @"retailerId";
static NSString* const JSON_ERROR_CODE_KEY = @"errorCode";
static NSString* const JSON_DATA_KEY = @"data";
+(void)getOrderDetail : (NSString*)emailID
        merchantEmail : (NSString*)retailerMail
               orderId:(NSString*)orderId
  withCompletionBlock : (void(^)(NSDictionary *))success
           andFailure : (void(^)(NSString*)) failure{
    
    NSDictionary* params = [[NSDictionary alloc]
                            initWithObjectsAndKeys:RETAILER_ID,JSON_RETAILER_ID_KEY,
                            emailID,@"email",
                            emailID,@"sellerId",
                            orderId,@"transactionId", nil];
    AANetworkHandler *networkHandler = [[AANetworkHandler alloc] init];
    [networkHandler
     sendJSONRequestToServerWithEndpoint:@"validateOrder.php"
     withParams:params
     withSuccessBlock:^(NSDictionary *response) {
         success(response);
//         if([response objectForKey:JSON_ERROR_CODE_KEY])
//         {
//             
//             if([[response objectForKey:JSON_ERROR_CODE_KEY] integerValue]==1)
//             {
//                 
//                 if([response objectForKey:JSON_DATA_KEY] )
//                 {
//                     NSDictionary *obj = [response objectForKey:JSON_DATA_KEY];
//                     success(obj);
//                 }
//                 else
//                 {
//                    failure(@"Invalid input");
//                     
//                 }
//             }
//             else
//             {
//                 
//                     failure(@"Invalid input");
//                 
//             }
//             
//         }else
//         {
//             if([[NSUserDefaults standardUserDefaults] objectForKey:orderId])
//             {
//                 NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:orderId];
//                 NSDictionary *obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//                 success(obj);
//             }else{
//                 failure(@"Invalid input");
//             }
//         }
     } withFailureBlock:^(NSError *error) {
         
             failure(error.description);
         
         
     }];
}

@end
