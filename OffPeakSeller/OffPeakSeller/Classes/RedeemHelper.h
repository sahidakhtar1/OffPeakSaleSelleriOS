//
//  RedeemHelper.h
//  OffPeakSeller
//
//  Created by Shahid Akhtar Shaikh on 12/13/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedeemHelper : NSObject
+(void)redeemOrderWithEmailId:(NSString*)emailId
                       qrCode:(NSString*)qrCode
         withCompletionBlock : (void(^)(NSDictionary *))success
                  andFailure : (void(^)(NSString*)) failure;
@end
