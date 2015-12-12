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
@synthesize orderIdField,titleLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden=YES;
    
    AAHeaderView *headerView = [[AAHeaderView alloc] initWithFrame:self.menuView.frame];
    [self.menuView addSubview:headerView];
    [headerView setTitle:@"Redeem Voucher"];
    headerView.showCart = false;
    headerView.showBack = true;
    headerView.delegate = self;
    [headerView setMenuIcons];
    
//    UILabel *titleLabel1=[[UILabel alloc]initWithFrame:CGRectMake(3*headerView.frame.size.width/10,20,4*headerView.frame.size.width/10,40)];
//    titleLabel1=titleLabel;
//    [headerView addSubview:titleLabel1];
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

-(void)backButtonTapped{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
