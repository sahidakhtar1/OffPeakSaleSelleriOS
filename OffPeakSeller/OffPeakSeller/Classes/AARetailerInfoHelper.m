//
//  AARetailerInfoHelper.m
//  Swensens
//
//  Created by Shahid Akhtar Shaikh on 17/12/13.
//  Copyright (c) 2013 Shahid Akhtar Shaikh. All rights reserved.
//

#import "AARetailerInfoHelper.h"
#import "AARetailer.h"
#import "AANetworkHandler.h"
@implementation AARetailerInfoHelper
static NSString* const JSON_RETAILER_ID_KEY = @"retailerId";
static NSString* const JSON_ERROR_CODE_KEY = @"errorCode";
static NSString* const JSON_DATA_KEY = @"data";
static NSString* const JSON_HEADER_COLOR_KEY = @"headerColor";
static NSString* const JSON_RETAILER_TEXT_COLOR_KEY = @"retailerTextColor";
static NSString* const JSON_RETAILER_NAME_KEY = @"retailerName";
static NSString* const JSON_RETAILER_FILE_TYPE_KEY = @"retailerFileType";
static NSString* const JSON_RETAILER_FILE_KEY = @"retailerFile";
static NSString* const JSON_RETAILER_POWERED_BY_KEY = @"poweredBy";
static NSString* const JSON_RETAILER_STORES_KEY = @"retailerStores";
static NSString* const JSON_RETAILER_HOME_IMAGES_KEY = @"home_imgArray";
static NSString* const JSON_RETAILER_PRODUCTS_KEY = @"products";
static NSString* const JSON_RETAILER_STORE_ADDRESS_KEY = @"storeAddress";
static NSString* const JSON_RETAILER_SPLASH_SCREEN_KEY = @"splashImage";
static NSString* const JSON_RETAILER_STORE_CONTACT_KEY = @"storeContact";
static NSString* const JSON_RETAILER_STORE_LATITUDE_KEY = @"latitude";
static NSString* const JSON_RETAILER_STORE_LONGITUDE_KEY = @"longitude";
static NSString* const JSON_RETAILER_COMPANYLOGO_KEY =@"companyLogo";
static NSString* const JSON_RETAILER_BACKDROPTYPE_KEY =@"backdropType";
static NSString* const JSON_RETAILER_BACKDROPFILE_KEY =@"backdropFile";
static NSString* const JSON_RETAILER_BACKDROPCOLOR1_KEY =@"backdropColor1";
static NSString* const JSON_RETAILER_BACKDROPCOLOR2_KEY =@"backdropColor2";
static NSString* const JSON_ENABLEPASSWORD_KEY =@"enablePassword";
static NSString* const JSON_RETAILAPPTYPE_KEY = @"retailerAppType";
static NSString* const JSON_RETAILFONT_KEY = @"siteFont";
static NSString* const JSON_TERMS_OF_USE = @"termsUrl";
static NSString* const JSON_RETAILER_HOME_IMAGES_FILEPATH_KEY = @"filePath";
static NSString* const JSON_RETAILER_HOME_IMAGES_FILETYPE_KEY = @"fileType";

static NSString* const JSON_PRODUCT_DESCRIPTION_KEY = @"desc";
static NSString* const JSON_PRODUCT_WORKING_INFORMATION_KEY = @"how_it_works";
static NSString* const JSON_PRODUCT_ID_KEY = @"id";
static NSString* const JSON_PRODUCT_NAME_KEY = @"name";
static NSString* const JSON_PRODUCT_OLD_PRICE_KEY = @"old_price";
static NSString* const JSON_PRODUCT_NEW_PRICE_KEY = @"new_price";
static NSString* const JSON_PRODUCT_IMAGE_KEY = @"product_img";
static NSString* const JSON_PRODUCT_SHORT_DESCRIPTION_KEY = @"short_desc";

+(void)processRetailerInformationWithCompletionBlock : (void(^)(void))success andFailure : (void(^)(NSString*)) failure
{
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:RETAILER_ID,JSON_RETAILER_ID_KEY, nil];
    AANetworkHandler *networkHandler = [[AANetworkHandler alloc] init];
    [networkHandler sendJSONRequestToServerWithEndpoint:@"getRetailerInfo.php" withParams:params withSuccessBlock:^(NSDictionary *response) {
        if([response objectForKey:JSON_ERROR_CODE_KEY])
        {
            if([[response objectForKey:JSON_ERROR_CODE_KEY] integerValue]==1)
            {
                
                if([response objectForKey:JSON_DATA_KEY] )
                {
                     [AARetailerInfoHelper populateRetailerInfo:response];
                    success();
                }
                else
                {
                    failure(@"Invalid input");
                }
            }
            else
            {
                failure(@"Invalid input");
            }
        }
        else
        {
            failure(@"Invalid input");
        }
       
        
    } withFailureBlock:^(NSError *error) {
        failure(error.description);
    }];
}

+(void)populateRetailerInfo : (NSDictionary*)response
{
  
                NSDictionary* dictRetailer = [response objectForKey:JSON_DATA_KEY];
                
                AARetailer* retailer = [[AARetailer alloc] init];
                if([dictRetailer objectForKey:JSON_HEADER_COLOR_KEY])
                {
                    retailer.retailerHeaderColorHexString = [dictRetailer objectForKey:JSON_HEADER_COLOR_KEY];
                   
                }
                if([dictRetailer objectForKey:JSON_RETAILER_TEXT_COLOR_KEY])
                {
                    retailer.retailerTextColorHexString = [dictRetailer objectForKey:JSON_RETAILER_TEXT_COLOR_KEY];
                  
                   
                }
                if([dictRetailer objectForKey:@"appStoreUrl"])
                {
                    [AAAppGlobals sharedInstance].appStoreUrl = [dictRetailer objectForKey:@"appStoreUrl"];
                    
                    
                }
    
                if([dictRetailer objectForKey:@"iosVersion"])
                {
                    retailer.iosVersion = [dictRetailer objectForKey:@"iosVersion"];
                    
                    
                }
                if ([dictRetailer objectForKey:JSON_RETAILFONT_KEY]) {
                    [[AAAppGlobals sharedInstance] getNormalFont:[dictRetailer objectForKey:JSON_RETAILFONT_KEY]];
                }
                if ([dictRetailer objectForKey:JSON_TERMS_OF_USE]) {
                    [AAAppGlobals sharedInstance].termsConditions = [dictRetailer objectForKey:JSON_TERMS_OF_USE];
                    retailer.termsUrl = [dictRetailer objectForKey:JSON_TERMS_OF_USE];
                }
                if ([dictRetailer objectForKey:@"aboutUrl"]) {
                    retailer.aboutUrl = [dictRetailer objectForKey:@"aboutUrl"];
                }

    
                if ([response objectForKey:@"isSSL"]) {
                    [AAAppGlobals sharedInstance].isSSL = [NSString stringWithFormat:@"%@",[response objectForKey:@"isSSL"]];
                }
                if([dictRetailer objectForKey:JSON_RETAILER_NAME_KEY])
                {
                    retailer.retailerName = [dictRetailer objectForKey:JSON_RETAILER_NAME_KEY];
                }
                if ([dictRetailer objectForKey:JSON_RETAILER_COMPANYLOGO_KEY]) {
                    retailer.companyLogo = [dictRetailer objectForKey:JSON_RETAILER_COMPANYLOGO_KEY];
                }
                if ([dictRetailer objectForKey:JSON_RETAILER_BACKDROPTYPE_KEY]) {
                    retailer.backdropType = [dictRetailer objectForKey:JSON_RETAILER_BACKDROPTYPE_KEY];
                }
                if ([dictRetailer objectForKey:JSON_RETAILER_BACKDROPFILE_KEY]) {
                    retailer.backdropFile = [dictRetailer objectForKey:JSON_RETAILER_BACKDROPFILE_KEY];
                }
                if ([dictRetailer objectForKey:JSON_RETAILER_BACKDROPCOLOR1_KEY]) {
                    retailer.backdropColor1 = [dictRetailer objectForKey:JSON_RETAILER_BACKDROPCOLOR1_KEY];
                }
                if ([dictRetailer objectForKey:JSON_RETAILER_BACKDROPCOLOR2_KEY]) {
                    retailer.backdropColor2 = [dictRetailer objectForKey:JSON_RETAILER_BACKDROPCOLOR2_KEY];
                }
                if([dictRetailer objectForKey:JSON_RETAILER_POWERED_BY_KEY])
                {
                    retailer.retailerPoweredBy = [dictRetailer objectForKey:JSON_RETAILER_POWERED_BY_KEY];
                }
    
                if([dictRetailer objectForKey:@"menuList"])
                {
                    retailer.menuList = [dictRetailer objectForKey:@"menuList"];
                }
                if([dictRetailer objectForKey:@"calendarUrl"])
                {
                    retailer.calendarUrl = [dictRetailer objectForKey:@"calendarUrl"];
                }

//                if ([dictRetailer objectForKey:JSON_ENABLEPASSWORD_KEY]) {
//                    retailer.enablePassword = [dictRetailer objectForKey:JSON_ENABLEPASSWORD_KEY];
//                }
                if([dictRetailer objectForKey:JSON_RETAILAPPTYPE_KEY])
                {
                    retailer.retailerAppType = [dictRetailer objectForKey:JSON_RETAILAPPTYPE_KEY];
                }
    //added new fields
                if([dictRetailer objectForKey:@"enableRewards"])
                {
                    retailer.enableRewards = [dictRetailer objectForKey:@"enableRewards"];
                }
                if([dictRetailer objectForKey:@"enableRating"])
                {
                    retailer.enableRating = [dictRetailer objectForKey:@"enableRating"];
                }
    
                if([dictRetailer objectForKey:@"instagramUrl"])
                {
                    retailer.instagramUrl = [dictRetailer objectForKey:@"instagramUrl"];
                }
                if([dictRetailer objectForKey:@"instagramDisplay"])
                {
                    retailer.instagramDisplay = [NSString stringWithFormat:@"%@",[dictRetailer objectForKey:@"instagramDisplay"]];
                }
                if([dictRetailer objectForKey:@"fbIconDisplay"])
                {
                    retailer.fbIconDisplay = [NSString stringWithFormat:@"%@",[dictRetailer objectForKey:@"fbIconDisplay"]];
                }
                if([dictRetailer objectForKey:@"fbUrl"])
                {
                    retailer.fbUrl = [dictRetailer objectForKey:@"fbUrl"];
                }

                if([dictRetailer objectForKey:@"defaultCurrency"])
                {
                    retailer.defaultCurrency = [dictRetailer objectForKey:@"defaultCurrency"];
                    NSString *selectedCurrency = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_SELECTED_CURRENCY];
                    if (selectedCurrency == nil || [selectedCurrency length] == 0) {
                        [[NSUserDefaults standardUserDefaults] setObject:retailer.defaultCurrency forKey:KEY_SELECTED_CURRENCY];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                }
                if([dictRetailer objectForKey:@"allowedCurrencies"])
                {
                    retailer.allowedCurrencies = [dictRetailer objectForKey:@"allowedCurrencies"];
                }
                if([dictRetailer objectForKey:@"enableCreditCode"])
                {
                    NSString *enableShoppingCart =[dictRetailer objectForKey:@"enableCreditCode"];
                    if ([enableShoppingCart isEqualToString:@"1"]) {
                        [AAAppGlobals sharedInstance].enableCreditCode = TRUE;
                    }else{
                        [AAAppGlobals sharedInstance].enableCreditCode = FALSE;
                    }
                }
                if([dictRetailer objectForKey:@"enablePay"])
                {
                    retailer.enablePay = [dictRetailer objectForKey:@"enablePay"];
                }
                if([dictRetailer objectForKey:@"enableVerit"])
                {
                    retailer.enableVerit = [dictRetailer objectForKey:@"enableVerit"];
                }
                if([dictRetailer objectForKey:@"enableCOD"])
                {
                    retailer.enableCOD = [dictRetailer objectForKey:@"enableCOD"];
                }
                if([dictRetailer objectForKey:@"appIconColor"])
                {
                    retailer.appIconColor = [dictRetailer objectForKey:@"appIconColor"];
                }
                if([dictRetailer objectForKey:@"enableFeatured"])
                {
                    retailer.enableFeatured = [dictRetailer objectForKey:@"enableFeatured"];
                }
                if([dictRetailer objectForKey:@"enableRating"])
                {
                    [AAAppGlobals sharedInstance].enableRating = [dictRetailer objectForKey:@"enableRating"];
                }
                if([dictRetailer objectForKey:@"enableShoppingCart"])
                {
                    [AAAppGlobals sharedInstance].enableShoppingCart = [dictRetailer objectForKey:@"enableShoppingCart"];
                }
    
                if([dictRetailer objectForKey:@"enableDelivery"])
                {
                    [AAAppGlobals sharedInstance].enableDelivery = [dictRetailer objectForKey:@"enableDelivery"];
                }
                if([dictRetailer objectForKey:@"deliveryDays"])
                {
                    retailer.deliveryDays = [dictRetailer objectForKey:@"deliveryDays"];
                }
                if([dictRetailer objectForKey:@"deliveryHours"])
                {
                    retailer.deliveryHours = [dictRetailer objectForKey:@"deliveryHours"];
                }
    
    
    //added new fields
                if([dictRetailer objectForKey:JSON_RETAILER_SPLASH_SCREEN_KEY])
                {
                    retailer.splashScreenURLString = [dictRetailer objectForKey:JSON_RETAILER_SPLASH_SCREEN_KEY];
                }
                if([dictRetailer objectForKey:JSON_RETAILER_FILE_KEY])
                {
                     retailer.retailerFile = [dictRetailer objectForKey:JSON_RETAILER_FILE_KEY];
                }
                if([dictRetailer objectForKey:JSON_RETAILER_FILE_TYPE_KEY])
                {
                     retailer.retailerFileType = [dictRetailer objectForKey:JSON_RETAILER_FILE_TYPE_KEY];
                }
    
                if ([dictRetailer objectForKey:@"enableDiscovery"]) {
                    retailer.enableDiscovery = [dictRetailer objectForKey:@"enableDiscovery"];
                }
    
                [AAAppGlobals sharedInstance].retailer = retailer;
                NSData *dataRetailer = [NSKeyedArchiver archivedDataWithRootObject:retailer];
    
                [[NSUserDefaults standardUserDefaults] setObject:dataRetailer forKey:USER_DEFAULTS_RETAILER_KEY];
               
                [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    
}

@end
