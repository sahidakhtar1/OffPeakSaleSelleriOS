//
//  AppDelegate.m
//  OffPeakSeller
//
//  Created by Shahid Akhtar Shaikh on 12/6/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "AppDelegate.h"

#import "SellerAccountVC.h"
#import "AASideMenuViewController.h"
#import "splashScreenVC.h"
#import "AALoginDailogView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self showMainScreen];
    //[self showSplashScreen];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)showSplashScreen
{
   // splashScreenID
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    AAHomeViewController* mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"AAHomeViewController"];
    splashScreenVC *splashVC = [storyboard instantiateViewControllerWithIdentifier:@"splashScreenID"];
    UINavigationController *splashController=[[UINavigationController alloc]initWithRootViewController:splashVC];
    [self.window setRootViewController:splashController];
    
}

-(void)showMainScreen
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    AAHomeViewController* mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"AAHomeViewController"];
    SellerAccountVC *eshopVC = [storyboard instantiateViewControllerWithIdentifier:@"SellerAccountVC"];
    
    AASideMenuViewController *sideMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"AASideMenuVC"];
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:eshopVC];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:sideMenuVC];
    
    self.revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    self.revealController.delegate = self;
    
    [frontNavigationController setNavigationBarHidden:YES];
    [rearNavigationController setNavigationBarHidden:YES];
    self.window.rootViewController = self.revealController ;
    [self.window makeKeyAndVisible];
}
-(void)splashFinished{
    AALoginDailogView *loginView = [[AALoginDailogView alloc] initWithNibName:nil bundle:nil];
    [self.window setRootViewController:loginView];
}
-(void)openSideMenu{
    [self.revealController revealToggle:self];
}
@end
