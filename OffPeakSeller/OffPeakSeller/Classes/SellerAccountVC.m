//
//  SellerAccountVC.m
//  OffPeakSeller
//
//  Created by Shahid Akhtar Shaikh on 12/7/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "SellerAccountVC.h"
#import "AAHeaderView.h"
#import "DACircularProgressView.h"

@interface SellerAccountVC ()
@end

@implementation SellerAccountVC
@synthesize menuView,circularProgressView,RedeemedValueLabel,companyDetailsTableView,UnitsSoldValueLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    companyKeyArray=[[NSMutableArray alloc]initWithObjects:@"Company Name",@"Contact",@"Email",@"Location",@"Month", nil];
    companyValueArray=[[NSMutableArray alloc]initWithObjects:@"hello cafe",@"84848484",@"contact@gmail.com",@"India",@"Dec,2015", nil];
    
    circularProgressView.backgroundColor=[UIColor clearColor];
    
    DACircularProgressView *progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(0, 0, circularProgressView.frame.size.width, circularProgressView.frame.size.height)];
    progressView.roundedCorners = NO;
    progressView.hidden = NO;
    progressView.trackTintColor = [UIColor lightGrayColor];
    [progressView setProgress:0.6 animated:YES];
    [circularProgressView addSubview:progressView];

    
    companyDetailsTableView.rowHeight=companyDetailsTableView.frame.size.height/5-5;
    companyDetailsTableView.backgroundColor=[UIColor clearColor];
    
    AAHeaderView *headerView = [[AAHeaderView alloc] initWithFrame:self.menuView.frame];
    [self.menuView addSubview:headerView];
    [headerView setTitle:self.title];
    headerView.showCart = false;
    headerView.showBack = false;
  //  headerView.delegate = self;
    [headerView setMenuIcons];
}

#pragma mark - TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *companyKeyLabel = (UILabel *)[cell viewWithTag:200];
    UILabel *companyValueLabel = (UILabel *)[cell viewWithTag:201];
    
    companyKeyLabel.text=[companyKeyArray objectAtIndex:indexPath.row];
    companyValueLabel.text=[companyValueArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return companyKeyArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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

- (IBAction)activateQRCode:(id)sender {
}
@end
