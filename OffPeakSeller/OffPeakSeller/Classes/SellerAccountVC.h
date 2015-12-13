//
//  SellerAccountVC.h
//  OffPeakSeller
//
//  Created by Shahid Akhtar Shaikh on 12/7/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerAccountVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *companyKeyArray;
    NSMutableArray *dictioanaryKeys;
}

@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UIView *menuView;
@property (nonatomic,retain) IBOutlet UITableView *companyDetailsTableView;
@property (nonatomic,retain) IBOutlet UILabel *RedeemedValueLabel;
@property (nonatomic,retain) IBOutlet UILabel *UnitsSoldValueLabel;
@property (nonatomic,retain) IBOutlet UIView *circularProgressView;
@property (nonatomic,retain) IBOutlet UILabel *companyNameValueLabel;
@property (nonatomic,retain) IBOutlet UILabel *contactValueLabel;
@property (nonatomic,retain) IBOutlet UILabel *EmailValueLabel;
@property (nonatomic,retain) IBOutlet UIButton *locationValueButton;
@property (nonatomic,retain) IBOutlet UIButton *startdateValueButton;
@property (nonatomic,retain) IBOutlet UIButton *enddateValueButton;
@property (nonatomic,retain) IBOutlet UILabel *percentageLabel;

- (IBAction)location:(id)sender;
- (IBAction)startDate:(id)sender;
- (IBAction)endDate:(id)sender;

- (IBAction)activateQRCode:(id)sender;

@property (nonatomic, strong) NSString *pageTitle;

@end
