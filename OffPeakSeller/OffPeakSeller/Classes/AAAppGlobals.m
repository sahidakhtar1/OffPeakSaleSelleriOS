//
//  AAAppGlobals.m
//  Swensens
//
//  Created by Shahid Akhtar Shaikh on 16/12/13.
//  Copyright (c) 2013 Shahid Akhtar Shaikh. All rights reserved.
//

#import "AAAppGlobals.h"

#define DEFAULT_ASPECT_RATIO 1.675

@implementation AAAppGlobals

static AAAppGlobals* singleInstance;

NSString* const USER_DEFAULTS_ORDERHISTORY_KEY = @"orderHistory";
NSString* const USER_DEFAULTS_LOOKBOOK_KEY = @"lookbook";
NSString* const USER_DEFAULTS_CONSUMER_KEY = @"consumer";
NSString* const USER_DEFAULTS_RETAILER_KEY = @"retailer";
NSString* const USER_DEFAULTS_VOUCHERS_KEY = @"vouchers";
NSString* const USER_DEFAULTS_FEEDBACK_KEY = @"feedback";
NSString* const USER_DEFAULTS_LOYALTY_KEY = @"loyalty";
NSString* const USER_DEFAULTS_ESHOP_KEY = @"eshop";
NSString* const USER_DEFAULTS_ADD_PUBLISHER_ID_KEY = @"publisherId";
NSString* const GOOGLE_MAPS_API_KEY = @"AIzaSyB3-2-YcL8bw7mqp6PQv4Hr6QsY84oXbpE";



@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (AAAppGlobals *)sharedInstance
{
    static dispatch_once_t dispatchOnceToken;
    
    dispatch_once(&dispatchOnceToken, ^{
        singleInstance = [[AAAppGlobals alloc] init];
        singleInstance.latitude = 1.3;
        singleInstance.longitude = 103.8;
       // singleInstance.locationHandler = [[AALocationHandler alloc] init];
        singleInstance.paymentTypes = [NSArray arrayWithObjects:@"MasterCard",@"Visa",@"American Express",@"Paypal", nil];
        singleInstance.backgroundQueue = dispatch_queue_create("com.appsauthority.backgroundQueue", NULL);
        singleInstance.addPublisherId = nil;
        singleInstance.deviceToken = @"";
        
        singleInstance.arrCartItems = [[NSMutableArray alloc] init];
        singleInstance.customerEmailID = @"";
        singleInstance.customerPassword = @"";
        singleInstance.isPasswordChanged = YES;
        singleInstance.credit_terms = nil;
        singleInstance.isPayByCredits = NO;
        singleInstance.isCommercialUI = YES;
        singleInstance.currency_code = @"SGD";
        singleInstance.currency_symbol = @"$";
        singleInstance.enableShoppingCart = FALSE;
        singleInstance.enableRating = FALSE;
        singleInstance.enableCreditCode = FALSE;
        singleInstance.isDecimalAllowed = FALSE;
        singleInstance.normalFont = @"ArialMT";
        singleInstance.boldFont = @"Arial-BoldMT";
        singleInstance.disablePayment = FALSE;
        singleInstance.isSSL = @"0";
        singleInstance.discountPercent = @"0.0";
        singleInstance.discountCode = nil;
        singleInstance.cartTotalAfterDiscount = @"0";
        singleInstance.termsConditions = @"";
        singleInstance.discountType = @"Percentage";
        singleInstance.shippingCharge = @"0";
        singleInstance.freeAmount = 0;
        singleInstance.showLocationOffalert = false;
        singleInstance.reward_points = @"0";
        singleInstance.rewardPointsRedeemed = @"0";
        singleInstance.deliveryDays = @"0";
        singleInstance.enableDelivery = @"0";
        singleInstance.appStoreUrl = @"";
        singleInstance.appUpdateAlertShown = false;
        singleInstance.arrCategory = [[NSMutableArray alloc] init];
        //[singleInstance getCurrencySymbol];
        singleInstance.currecyDict = [[NSMutableDictionary alloc] init];
        singleInstance.cod = false;
        singleInstance.products = nil;
        singleInstance.deliveryOptonSelectedIndex = 0;
        
        
    });
    
    return singleInstance;
}
-(void)getCurrencySymbol{
    
    singleInstance.currency_symbol =[singleInstance getCurrencySymbolWithCode:singleInstance.currency_code];
    if (singleInstance.currency_symbol == nil) {
        singleInstance.currency_symbol = @"$";
    }
}
-(NSString*)getCurrencySymbolWithCode:(NSString*)code{
    NSDictionary*  CURRRENCY_DICT = [NSDictionary dictionaryWithObjectsAndKeys:@"$",@"AUD",
                                     @"R$",@"BRL",
                                     @"$",@"CAD",
                                     @"Kc",@"CZK",
                                     @"kr",@"DKK",
                                     @"€",@"EUR",
                                     @"$",@"HKD",
                                     @"Ft",@"HUF",
                                     @"~",@"ILS",
                                     @"Y",@"JPY",
                                     @"RM",@"MYR",
                                     @"$",@"MXN",
                                     @"kr",@"NOK",
                                     @"$",@"NZD",
                                     @"P",@"PHP",
                                     @"zl",@"PLN",
                                     @"£",@"GBP",
                                     @"ру6",@"RUB",
                                     @"$",@"SGD",
                                     @"kr",@"SEK",
                                     @"CHF",@"CHF",
                                     @"NT$",@"TWD",
                                     @"B",@"THB",
                                     @"Tr",@"TRY",
                                     @"₹",@"INR",
                                     @"$", @"USD", nil];
    NSString *symbol = [CURRRENCY_DICT valueForKey:code];
    if (symbol == nil) {
        symbol = code;
    }
    return symbol;
}
-(void)getNormalFont:(NSString*)fontName{
    NSLog(@"fontname  = %@",fontName);
    NSDictionary*  normalFontDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"ArialMT",@"Arial",
                                      @"OpenSans",@"Opensans",
                                      @"Georgia",@"Georgia",
                                      @"TimesNewRomanPSMT",@"Times",
                                      @"TrebuchetMS",@"Trebuchet",
                                     @"Folks-Normal",@"Folks",
                                     @"Aleo-Regular",@"Aleo",
                                     @"MyriadPro-Regular",@"MYRIADPRO",
                                      nil];
    NSDictionary*  boldFontDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"Arial-BoldMT",@"Arial",
                                     @"OpenSans-Semibold",@"Opensans",
                                     @"Georgia-Bold",@"Georgia",
                                     @"TimesNewRomanPS-BoldMT",@"Times",
                                     @"TrebuchetMS-Bold",@"Trebuchet",
                                    @"Aleo-Bold",@"Aleo",
                                    @"Folks-Bold",@"Folks",
                                   @"MyriadPro-Semibold",@"MYRIADPRO",
                                     nil];
    if ([normalFontDict objectForKey:fontName]) {
        singleInstance.normalFont = [normalFontDict objectForKey:fontName];
    }
    if ([boldFontDict objectForKey:fontName]) {
        singleInstance.boldFont = [boldFontDict objectForKey:fontName];
    }
}
-(void)loadDataFromUserDefaults
{
    @try {
   
            if([[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_CONSUMER_KEY])
            {
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_CONSUMER_KEY];
            }
            
            if([[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_RETAILER_KEY])
            {
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_RETAILER_KEY];
            }
            
            if([[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_ESHOP_KEY])
            {
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_ESHOP_KEY];
                self.arrCategory = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
            
            if([[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_VOUCHERS_KEY])
            {
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_VOUCHERS_KEY];
            }
            
            if([[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_FEEDBACK_KEY])
            {
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_FEEDBACK_KEY];
            }
            if([[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_LOYALTY_KEY])
            {
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_LOYALTY_KEY];
            }
            if([[NSUserDefaults standardUserDefaults] stringForKey:USER_DEFAULTS_ADD_PUBLISHER_ID_KEY])
            {
               self.addPublisherId = [[NSUserDefaults standardUserDefaults] stringForKey:USER_DEFAULTS_ADD_PUBLISHER_ID_KEY];
                
            }
            }
    @catch (NSException *exception) {
        
    }
}




#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}








-(float)getImageHeight{
    float height = 200;
    CGRect frame = [UIScreen mainScreen].bounds;
    float scale = [UIScreen mainScreen].scale;
    if (frame.size.width> 320) {
        height = (frame.size.width)/DEFAULT_ASPECT_RATIO;
    }else{
        height = 200;
    }
//    NSLog(@"new height = %fx%f",frame.size.width,height);
    return height;
//    NSString *resolution = [NSString stringWithFormat:@"resolution %.0f x %.0f",frame.size.width*scale,frame.size.height*scale];
//    [[[UIAlertView alloc] initWithTitle:@"Device info" message:[NSString stringWithFormat:@"Model = %@",resolution] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
}
-(float)getImageHeightWithPadding:(CGFloat)padding{
    float height = 200;
    CGRect frame = [UIScreen mainScreen].bounds;
    float scale = [UIScreen mainScreen].scale;
    if (frame.size.width> 320) {
        height = (frame.size.width-2*padding)/DEFAULT_ASPECT_RATIO;
    }else{
        height = 200;
    }
    NSLog(@"new height = %fx%f",frame.size.width-2*padding,height);
    return height;
    //    NSString *resolution = [NSString stringWithFormat:@"resolution %.0f x %.0f",frame.size.width*scale,frame.size.height*scale];
    //    [[[UIAlertView alloc] initWithTitle:@"Device info" message:[NSString stringWithFormat:@"Model = %@",resolution] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
}
-(BOOL)isHavingDecimal:(NSString*)string{
    if (![string isKindOfClass:[NSString class]]) {
        string = [NSString stringWithFormat:@"%@",string];
    }
    BOOL isDecimalAllowed = false;
    NSRange range;
    @try {
        range = [string rangeOfString:@"."];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    if (range.location == NSNotFound){
        //[AAAppGlobals sharedInstance].isDecimalAllowed = false;
    }else{
        isDecimalAllowed = true;
    }
    return isDecimalAllowed;
}

-(void)getDateByAddingDays:(int)days{
    NSDate *today = [NSDate date];
    int onday = 24*60*60;
    NSDate *requiredDate = [today dateByAddingTimeInterval:days*onday];
    singleInstance.scheduledDate = requiredDate;
}

-(NSString*)convertDateToString:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
-(NSString*)getPriceStrfromFromPrice:(float)price{
    NSString* pricestr = [NSString stringWithFormat:@"%.0f",price];
    if ([pricestr length]<7) {
        return [NSString stringWithFormat:@"%.2f",price];
    }else{
        return [NSString stringWithFormat:@"%.0f",price];
    }
}


@end
