//
//  AppDelegate.h
//  OffPeakSeller
//
//  Created by Shahid Akhtar Shaikh on 12/6/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)openSideMenu;
-(void)splashFinished;
-(void)showMainScreen;
@property (nonatomic, strong)SWRevealViewController *revealController;
@end

