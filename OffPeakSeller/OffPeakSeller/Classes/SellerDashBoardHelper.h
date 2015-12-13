//
//  SellerDashBoardHelper.h
//  OffPeakSeller
//
//  Created by Shahid Akhtar Shaikh on 12/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SellerDashBoardHelper : NSObject
+(void)getSellerInfoEmailId:(NSString*)emailId
                  startDate:(NSString*)startDate
                    endDate:(NSString*)endDate
       withCompletionBlock : (void(^)(NSDictionary *))success
                andFailure : (void(^)(NSString*)) failure;
@end
