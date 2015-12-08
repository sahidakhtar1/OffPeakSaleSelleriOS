//
//  splashScreenVC.m
//  OffPeakSeller
//
//  Created by ImranNew on 08/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "splashScreenVC.h"
#import "loginVC.h"

@interface splashScreenVC ()

@end

@implementation splashScreenVC
@synthesize poweredByLabel,urlLinkLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden=YES;
    
    //Powered by:
    //http://www.smartcommerce.asia
    
    self.poweredByLabel.text=@"Powered by:";
    self.urlLinkLabel.text=@"http://www.smartcommerce.asia";
    
    [self performSelector:@selector(callLoginView) withObject:nil afterDelay:3.0];
}

-(void)callLoginView
{
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    AAHomeViewController* mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"AAHomeViewController"];
    loginVC *splashVC = [storyboard instantiateViewControllerWithIdentifier:@"loginID"];
    [self.navigationController pushViewController:splashVC animated:NO];
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

@end
