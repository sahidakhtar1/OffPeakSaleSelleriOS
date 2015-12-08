//
//  loginVC.h
//  OffPeakSeller
//
//  Created by ImranNew on 08/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "ViewController.h"

@interface loginVC : ViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) IBOutlet UIButton *signInButton;
@property (nonatomic,retain) IBOutlet UIButton *forgotPasswordButton;
@property (nonatomic,retain) IBOutlet UIButton *needHelp;
@property (nonatomic,retain) IBOutlet UITableView *listTableView;


@end
