//
//  invalidVoucherVC.h
//  OffPeakSeller
//
//  Created by Admin on 11/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface invalidVoucherVC : UIViewController

@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UIView *menuView;
@property (nonatomic,retain) IBOutlet UILabel *voucherUsedLabel;
@property (nonatomic,retain) IBOutlet UILabel *voucherDateLabel;
@property (nonatomic) BOOL isSucess;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *dateMsg;
@property (nonatomic, strong) NSString *pageTitle;

@end
