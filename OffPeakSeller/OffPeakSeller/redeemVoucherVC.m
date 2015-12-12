//
//  redeemVoucherVC.m
//  OffPeakSeller
//
//  Created by Admin on 11/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "redeemVoucherVC.h"
#import "AAHeaderView.h"
#import "AAOrderHistoryHelper.h"
#import "AAOrderDetailViewController.h"
#import "invalidVoucherVC.h"

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
    if (self.orderIdField.text ==  nil || [self.orderIdField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter voucher code" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
    }else{
        [self getVoucherDetail:self.orderIdField.text];
    }
}

-(void)getVoucherDetail:(NSString*)voucherCode{
    
    [AAOrderHistoryHelper
     getOrderDetail : [[NSUserDefaults standardUserDefaults] objectForKey:KEY_EMAIL]
                           merchantEmail : @""
                                  orderId:voucherCode
                      withCompletionBlock:^(NSDictionary *orderDetail) {
                          if ([[orderDetail objectForKey:@"errorCode"] isEqualToString:@"1"]) {
                              AAOrderDetailViewController *orderDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AAOrderDetailViewController"];
                              orderDetailVC.pageTitle= @"Valid Voucher";
                              [orderDetailVC setOrderObj:[orderDetail objectForKey:@"data"]];
                              [self.navigationController pushViewController:orderDetailVC animated:YES];
                          }else{
                              NSString *errorMessage = [orderDetail valueForKey:@"errorMessage"];
                              NSString *usedOn = [orderDetail valueForKey:@"usedOn"];
                              invalidVoucherVC *orderDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"invalidVoucherVC"];
                              orderDetailVC.pageTitle= @"Invalid Voucher";
                              orderDetailVC.isSucess = false;
                              orderDetailVC.dateMsg =[orderDetail objectForKey:@"errorMessage"];
                              orderDetailVC.dateMsg =[orderDetail objectForKey:@"usedOn"];
                              [self.navigationController pushViewController:orderDetailVC animated:YES];
                          }
                          
                          
                      } andFailure:^(NSString *error) {
                          
                          
                      }];
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
