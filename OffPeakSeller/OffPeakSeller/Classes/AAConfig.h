//
//  AAConfig.h
//  AppWiz
//
//  Created by Shahid Akhtar Shaikh on 13/1/14.
//  Copyright (c) 2014 Shahid Akhtar Shaikh. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HELVITICAFONT @"Helvetica"
#define HELVITICANEUEBOLDFONT @"HelveticaNeue-Bold"
#define TITLE_FONTSIZE 17
#define BUTTON_FONTSIZE 15
#define MENU_ITEM_FONTSIZE 17
#define CONATCT_FIELD_TEXT_SIZE 13

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define APP_COLOR [UIColor colorWithRed:(0.0 / 255.0) green:(204.0 / 255.0) blue:(190.0 / 255.0) alpha:1.0]


#define SHORTDESC_FONTSIZE 17
#define FONT_SIZE_OLD_PRICE 14
#define FONT_SIZE_NEW_PRICE 16
#define CATEGORY_FONTSIZE 16
#define QTY_INDICATOR_FONT 14
#define QTY_DISCOUNT_LBL_FONT 11
#define QTY_DISCOUNT_VALUE_FONT 25
#define DISTANCE_FONTSIZE 22
#define ADDRESS_FONTSIZE 13

#define PRODUCTDETAIL_SHORTDESC_FONTSIZE 17
#define PRODUCTDETAIL_HEADING_FONTSIZE 17
#define PRODUCTDETAIL_BODY_FONTSIZE 15
#define PRODUCTDETAIL_REWARDS_FONTSIZE 14
#define PRODUCTDETAIL_ITEMTOTAL_FONTSIZE 18
#define PRODUCTDETAIL_QTY_FONTSIZE 18
#define CARTTOTAL_FONTSIZE 11

#define SHOPPINGCART_SHORTDESC_FONTSIZE 14
#define SHOPPINGCART_QTY_FONTSIZE 14
#define SHOPPINGCART_ITEMTOTAL_FONTSIZE 15
#define SHOPPINGCART_TOTAL_FONTSIZE 18
#define SHOPPINGCART_BACK2SHOP_FONTSIZE 17
#define SHOPPINGCART_CHECKOUT_FONTSIZE 15

#define PROFILE_TF_FONTSIZE 14

#define LOTALITY_TNCTITLE_FONTSIZE 15
#define LOTALITY_TNC_FONTSIZE 14
#define LOTALITY_LOGIN_TITLE_FONTSIZE 100 //

#define FEEDBACK_TEXTVIEW_FONTSIZE 14
#define FEEDBACK_OPTIONS_FONTSIZE 14
#define FEEDBACK_REFER_FONTSIZE 15
#define SHOPPING_CART_ITEM_DESC_FONTSIZE 14.0

#define LOOKBOOK_TITLE_SIZE 15.0
#define LOOKBOOK_DESCRIPTION_SIZE 12.0

#define FOOTER_OPTIONS_FONTSIZE 13.0

#define ORDER_HISTORY_FONTSIZE 13.0
#define ORDER_ID_FONTSIZE 13.0

#define TOUR_TITLE_FONT_SIZE 30
#define TOUR_DESC_FONT_SIZE 17

#define BOARDER_COLOR [UIColor colorWithRed:182.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1]


#define PRODUCT_IMAGE_WIDTH 85
#define MARGIN 10
#define RIGHTITEM_WIDTH 30
#define ITEM_GAP 7



@interface AAConfig : NSObject
extern NSString* const PNKEY;
extern NSString* const RETAILER_ID;
extern NSString* const ITUNES_URL;
extern NSString* const BASE_URL;
extern NSString* const DESFAULT_DISCOUNT_TYPE;
extern NSString* const KEY_SELECTED_CURRENCY;
extern NSString* const KEY_EMAIL;
extern NSString* const API_KEY;

typedef enum MenuItem{
    SELLER_ACCOUNT,
    TERMSOFUSE,
    CONTACT,
    LOGOUT,
}MenuItemType;


@end
