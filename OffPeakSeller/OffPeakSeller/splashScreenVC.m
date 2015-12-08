//
//  splashScreenVC.m
//  OffPeakSeller
//
//  Created by ImranNew on 08/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "splashScreenVC.h"

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
