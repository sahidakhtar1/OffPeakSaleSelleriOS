//
//  AAHeaderView.m
//  AppWiz
//
//  Created by Shahid Akhtar Shaikh on 5/2/15.
//  Copyright (c) 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "AAHeaderView.h"
#import "AppDelegate.h"
@implementation AAHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [self initialize];
        self.frame = frame;
        
    }
    return self;
}
-(void)awakeFromNib{

}
- (UIView*)initialize{
    UIView *childView= [[[NSBundle mainBundle] loadNibNamed:@"AAHeaderView" owner:self options:nil] objectAtIndex:0];
    
    self.lblTitle.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:TITLE_FONTSIZE];
    
    return childView;
}
-(void)setFont{
    self.lblTitle.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:TITLE_FONTSIZE];
    self.lblCartTotal.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:CARTTOTAL_FONTSIZE];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    UIView *childView = [[[NSBundle mainBundle] loadNibNamed:@"AAHeaderView" owner:self options:nil] objectAtIndex:0];
//    [self addSubview:childView];
}
-(void)setTitle:(NSString*)title{
    self.lblTitle.text = title;
}
-(void)setMenuIcons{
    if (self.isShowCart) {
        
    }else{
        self.btnSearch.hidden = false;
        self.vwCart.hidden = true;
        CGRect frame = self.btnSearch.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width - (15+frame.size.width);
        self.btnSearch.frame = frame;
    }
    if (self.isShowBack) {
        self.btnBack.hidden = false;
        self.brnMenu.hidden = true;
        self.btnSearch.hidden = true;
        self.vwCart.hidden = true;
    }else{
        self.btnBack.hidden = true;
        self.brnMenu.hidden = false;
    }
    
//    if ([[AAAppGlobals sharedInstance].retailer.appIconColor isEqualToString:@"White"]) {
//        [self.btnBack setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
//        [self.brnMenu setImage:[UIImage imageNamed:@"menu_button"] forState:UIControlStateNormal];
//        
//    }else{
//        
//        [self.btnBack setImage:[UIImage imageNamed:@"back_button_black"] forState:UIControlStateNormal];
//        [self.brnMenu setImage:[UIImage imageNamed:@"menu_button_black"] forState:UIControlStateNormal];
//    }
//    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                                                  [AAColor sharedInstance].retailerThemeTextColor,NSForegroundColorAttributeName,
//                                                                                                  //[UIColor whiteColor],UITextAttributeTextShadowColor,
//                                                                                                  //[NSValue valueWithUIOffset:UIOffsetMake(0, 1)],UITextAttributeTextShadowOffset,
//                                                                                                  nil]
//                                                                                        forState:UIControlStateNormal];
    
    self.lblTitle.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:TITLE_FONTSIZE];
    self.lblCartTotal.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:CARTTOTAL_FONTSIZE];
   
}
- (IBAction)brnMenuTapped:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    [appDelegate openSideMenu];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(hideKeyBoard)]) {
        [self.delegate hideKeyBoard];
    }
}


- (IBAction)btnSearchTapped:(id)sender {
    [self.mSearchBar setHidden:false];
    [self.btnScan setHidden:false];
    [self.brnMenu setHidden:true];
    [self.mSearchBar becomeFirstResponder];
}

- (IBAction)btnBackTapped:(id)sender {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(backButtonTapped)]) {
        [self.delegate backButtonTapped];
    }
}

- (IBAction)btnCartTapped:(id)sender {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(cartButtonTapped)]) {
        [self.delegate cartButtonTapped];
    }
}

//- (IBAction)btnScanTapped:(id)sender {
//    AAScannerViewController *scannerVC= [[AAScannerViewController alloc] initWithNibName:@"ScannerView" bundle:nil];
//    scannerVC.delegate = self;
//    AAAppDelegate *appDelegate = (AAAppDelegate*) [[UIApplication sharedApplication] delegate];
//    [appDelegate.revealController presentViewController:scannerVC animated:YES completion:nil];
//}
//-(void)scanningResult:(NSString*)result{
//    NSString *trimmedString = [result stringByTrimmingCharactersInSet:
//                               [NSCharacterSet whitespaceCharacterSet]];
//    NSLog(@"trimmedString = %@",trimmedString);
//    AAAppDelegate *appDelegate = (AAAppDelegate*) [[UIApplication sharedApplication] delegate];
//    [appDelegate searchItemWithText:trimmedString];
//    [self.mSearchBar resignFirstResponder];
//    [self.mSearchBar setHidden:true];
//    [self.btnScan setHidden:true];
//    [self.brnMenu setHidden:false];
//    
//}
@end
