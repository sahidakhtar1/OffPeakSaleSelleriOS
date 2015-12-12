//
//  redeemVoucherVC.h
//  OffPeakSeller
//
//  Created by Admin on 11/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface redeemVoucherVC : UIViewController<UITextFieldDelegate>

@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UITextField *orderIdField;
@property (nonatomic,retain) IBOutlet UIView *menuView;

@end
