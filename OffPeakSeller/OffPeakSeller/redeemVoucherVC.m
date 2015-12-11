//
//  redeemVoucherVC.m
//  OffPeakSeller
//
//  Created by Admin on 11/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "redeemVoucherVC.h"
#import "AAHeaderView.h"

@interface redeemVoucherVC ()

@end

@implementation redeemVoucherVC
@synthesize orderIdField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden=YES;
    
    AAHeaderView *headerView = [[AAHeaderView alloc] initWithFrame:self.menuView.frame];
    [self.menuView addSubview:headerView];
    [headerView setTitle:self.title];
    headerView.showCart = false;
    headerView.showBack = false;
    //  headerView.delegate = self;
    [headerView setMenuIcons];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(2.5*headerView.frame.size.width/10,20,5*headerView.frame.size.width/10,40)];
    titleLabel.text=@"Redeem Voucher";
    titleLabel.font=[UIFont systemFontOfSize:16.0];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [headerView addSubview:titleLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)scanQRCode:(id)sender {
}
- (IBAction)goButton:(id)sender {
}

#pragma mark - textField

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    [self.view setFrame:CGRectMake(0, -200, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
