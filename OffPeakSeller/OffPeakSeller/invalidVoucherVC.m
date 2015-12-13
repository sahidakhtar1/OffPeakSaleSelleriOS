//
//  invalidVoucherVC.m
//  OffPeakSeller
//
//  Created by Admin on 11/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "invalidVoucherVC.h"
#import "AAHeaderView.h"

@interface invalidVoucherVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgResult;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblDateMsg;

@end

@implementation invalidVoucherVC
@synthesize menuView,voucherUsedLabel,voucherDateLabel,titleLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationController.navigationBarHidden=YES;
    
    AAHeaderView *headerView = [[AAHeaderView alloc] initWithFrame:self.menuView.frame];
    [self.menuView addSubview:headerView];
    [headerView setTitle:self.pageTitle];
    headerView.showCart = false;
    headerView.showBack = true;
    headerView.delegate = self;
    [headerView setMenuIcons];
    
//    UILabel *titleLabel1=[[UILabel alloc]initWithFrame:CGRectMake(3*headerView.frame.size.width/10,20,4*headerView.frame.size.width/10,40)];
//    titleLabel1=titleLabel;
//    [headerView addSubview:titleLabel1];
    self.lblMsg.text = self.msg;
    if (self.dateMsg) {
        self.lblDateMsg.text = [NSString stringWithFormat:@"%@ On %@",self.msg,self.dateMsg];
    }else{
        self.lblDateMsg.hidden = true;
    }
    if (self.isSucess) {
        self.lblMsg.textColor = [AAColor sharedInstance].retailerThemeBackgroundColor;
        self.imgResult.image = [UIImage imageNamed:@"smily_happy"];
    }else{
        self.lblMsg.textColor = [UIColor colorWithRed:236/255.0f green:110/255.0f blue:38/255.0f alpha:1];
        self.imgResult.image = [UIImage imageNamed:@"smily_sad"];
    }
    [self setFont];
    
}
-(void)setFont{
    [self.lblMsg setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:VOUCHER_MSG_TEXT_SIZE]];
    [self.lblDateMsg setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:VOUCHER__DATE_MSG_TEXT_SIZE]];
}
- (IBAction)Ok:(id)sender {
    if (self.isSucess) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)backButtonTapped{
    if (self.isSucess) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
