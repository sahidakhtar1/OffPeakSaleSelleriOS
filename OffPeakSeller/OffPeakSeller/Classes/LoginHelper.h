//
//  LoginHelper.h
//  OffPeakSeller
//
//  Created by Shahid Akhtar Shaikh on 12/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginHelper : NSObject
+(void)loginWithEmailid:(NSString*)email
               password:(NSString*)password
             andCountry:(NSString*)country
    withCompletionBlock:(void (^)(NSMutableArray *))success
             andFailure:(void (^)(NSString *))failure;
@end
