//
//  AASideMenuViewController.m
//  AppWiz
//
//  Created by Shahid Akhtar Shaikh on 4/23/15.
//  Copyright (c) 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "AASideMenuViewController.h"
#import "AASideMenuCell.h"
#import "SWRevealViewController.h"

#import "AAMenuItem.h"
#import "SellerAccountVC.h"
#import "contactVC.h"
#import "AAMenuWebViewController.h"
#import "AppDelegate.h"
@interface AASideMenuViewController ()

@end

@implementation AASideMenuViewController
@synthesize arrMenuItems;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrMenuItems = [[NSMutableArray alloc] init];
    
    [self becomeFirstResponder];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self populateMenuItems];
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

#pragma mark -
#pragma mark TableView Delegate & Data Sources
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrMenuItems count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AASideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SideMenuCellInditifier"];
    AAMenuItem *menuIem = [self.arrMenuItems objectAtIndex:indexPath.row];
    cell.lblItemName.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:MENU_ITEM_FONTSIZE];
    cell.lblItemName.text = menuIem.itemName;
    cell.imgArraow.hidden = !menuIem.showArrow;
    cell.imgIcon.image = [UIImage imageNamed:menuIem.iconName];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AAMenuItem *menuItem = [self.arrMenuItems objectAtIndex:indexPath.row];
    SWRevealViewController *revealController = self.revealViewController;
    UINavigationController *frontVC = (id)revealController.frontViewController;
    switch (menuItem.itemType) {
        case SELLER_ACCOUNT:
            {
                if ( ![frontVC.topViewController isKindOfClass:[SellerAccountVC class]] )
                {
                    SellerAccountVC *activity = [self.storyboard instantiateViewControllerWithIdentifier:@"SellerAccountVC"];
                    activity.pageTitle = menuItem.itemName;
                    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:activity];
                    navigationController.navigationBarHidden=YES;
                    [self.revealViewController pushFrontViewController:navigationController     animated:YES];
                }else{
                    [revealController revealToggle:self];
                }

            }
            break;
        case TERMSOFUSE:
            {
                AAMenuWebViewController* vcRetailerStore = [self.storyboard instantiateViewControllerWithIdentifier:@"AAMenuWebViewController"];
                [vcRetailerStore setWebPageUrl:[AAAppGlobals sharedInstance].retailer.termsUrl];
                [vcRetailerStore setWebPageTitle:menuItem.itemName];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vcRetailerStore];
                navigationController.navigationBarHidden=YES;
                [self.revealViewController pushFrontViewController:navigationController     animated:YES];
            }
            break;
        case CONTACT:
                {
                    if ( ![frontVC.topViewController isKindOfClass:[contactVC class]] )
                    {
                        contactVC *activity = [self.storyboard instantiateViewControllerWithIdentifier:@"contactVC"];
                        activity.pageTitle = menuItem.itemName;
                        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:activity];
                        navigationController.navigationBarHidden=YES;
                        [self.revealViewController pushFrontViewController:navigationController     animated:YES];
                    }else{
                        [revealController revealToggle:self];
                    }
                }
            break;
        case LOGOUT:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Do you want to logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
            [alertView show];
        }
        
            break;
        default:
            break;
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==  1) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_EMAIL];
        [[NSUserDefaults standardUserDefaults] synchronize];
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate splashFinished];
    }
}
-(void)populateMenuItems{
    
    [arrMenuItems removeAllObjects];
    AAMenuItem *eshop = [[AAMenuItem alloc] init];
    eshop.itemName = @"Seller Account";
    eshop.itemType = SELLER_ACCOUNT;
    eshop.showArrow = NO;
    eshop.iconName = @"home-1";
    [arrMenuItems addObject:eshop];
    
    AAMenuItem *voucher = [[AAMenuItem alloc] init];
    voucher.itemName = @"Terms of Use";
    voucher.itemType = TERMSOFUSE;
    voucher.showArrow = NO;
    voucher.iconName = @"termsofuse";
    [arrMenuItems addObject:voucher];
    
    
    AAMenuItem *myOrder = [[AAMenuItem alloc] init];
    myOrder.itemName = @"Contact";
    myOrder.itemType = CONTACT;
    myOrder.showArrow = NO;
    myOrder.iconName = @"about_us";
    [arrMenuItems addObject:myOrder];
    
    
    AAMenuItem *profile = [[AAMenuItem alloc] init];
    profile.itemName = @"Logout";
    profile.itemType = LOGOUT;
    profile.showArrow = NO;
    profile.iconName = @"logout";
    [arrMenuItems addObject:profile];

    [self.tbMenu reloadData];
    
    
    
}
//#pragma mark -
//#pragma mark Hamdle Shake Gesture
//- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    if ( event.subtype == UIEventSubtypeMotionShake )
//    {
//        // Put in code here to handle shake
//    }
//    
//    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
//        [super motionEnded:motion withEvent:event];
//}
//
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}
@end
