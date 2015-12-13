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
#import "redeemVoucherVC.h"
#import "AAThemeLabel.h"
#import "SellerDashBoardHelper.h"
@interface SellerAccountVC ()
@property (nonatomic, strong) NSDictionary *sellerInfoDict;
@property (nonatomic, strong) DACircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *lblCompany;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyValue;
@property (weak, nonatomic) IBOutlet UILabel *lblContact;
@property (weak, nonatomic) IBOutlet UILabel *lblConatctValue;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblEmailValue;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnLocationValue;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;
@property (weak, nonatomic) IBOutlet UILabel *lblRedeemed;
@property (weak, nonatomic) IBOutlet UILabel *lblSold;
@end

@implementation SellerAccountVC
@synthesize menuView,circularProgressView,RedeemedValueLabel,companyDetailsTableView,UnitsSoldValueLabel,titleLabel,percentageLabel,locationValueButton,startdateValueButton,enddateValueButton,companyNameValueLabel,contactValueLabel,EmailValueLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    companyKeyArray=[[NSMutableArray alloc]initWithObjects:@"Company Name",@"Contact",@"Email",@"Location",@"Start Date",@"End Date", nil];
    dictioanaryKeys=[[NSMutableArray alloc]initWithObjects:@"company_name",@"phone_num",@"email",@"country", nil];
    
    circularProgressView.backgroundColor=[UIColor clearColor];
    
    locationValueButton.titleLabel.textAlignment=NSTextAlignmentRight;
    startdateValueButton.titleLabel.textAlignment=NSTextAlignmentRight;
    enddateValueButton.titleLabel.textAlignment=NSTextAlignmentRight;
    
    
    self.progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(0, 0, circularProgressView.frame.size.width, circularProgressView.frame.size.height)];
    self.progressView.roundedCorners = NO;
    self.progressView.hidden = NO;
    self.progressView.trackTintColor = [UIColor lightGrayColor];
    [self.progressView setProgress:0.0 animated:YES];
    [circularProgressView addSubview:self.progressView];

    
    AAHeaderView *headerView = [[AAHeaderView alloc] initWithFrame:self.menuView.frame];
    [self.menuView addSubview:headerView];
    [headerView setTitle:self.pageTitle];
    headerView.showCart = false;
    headerView.showBack = false;
    [headerView setMenuIcons];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [SellerDashBoardHelper getSellerInfoEmailId:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_EMAIL] withCompletionBlock:^(NSDictionary *dict) {
        self.sellerInfoDict = dict;
//        [self.companyDetailsTableView setDataSource:self];
//        [self.companyDetailsTableView reloadData];
        float redeemed = [[self.sellerInfoDict valueForKey:@"orders_redeemed"] floatValue];
        float sold = [[self.sellerInfoDict valueForKey:@"orders_sold"] floatValue];
        self.RedeemedValueLabel.text = [self.sellerInfoDict valueForKey:@"orders_redeemed"];
        self.UnitsSoldValueLabel.text = [self.sellerInfoDict valueForKey:@"orders_sold"];
        float percentage = redeemed/sold;
        [self.progressView setProgress:percentage animated:YES];
        NSString *percetageSymbol= @"%";
        percentageLabel.text= [NSString stringWithFormat:@"%.0f%@",percentage*100,percetageSymbol];
        
        self.lblCompanyValue.text = [self.sellerInfoDict valueForKey:@"company_name"];
        if ([[self.sellerInfoDict valueForKey:@"phone_num"] isKindOfClass:[NSNull class]]) {
            
        }else{
            self.lblConatctValue.text = [self.sellerInfoDict valueForKey:@"phone_num"];
        }
         
        self.lblEmailValue.text = [self.sellerInfoDict valueForKey:@"email"];
        [self.btnLocationValue setTitle:[self.sellerInfoDict valueForKey:@"country"] forState:UIControlStateNormal] ;
    } andFailure:^(NSString *msg) {
        
    }];
}
-(void)closeButtonAction
{
    
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
    if ([dictioanaryKeys count]>indexPath.row) {
       NSString *key = [dictioanaryKeys objectAtIndex:indexPath.row];
       companyValueLabel.text=[self.sellerInfoDict valueForKey:key];
    }
    
    
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

- (IBAction)location:(id)sender {
}

- (IBAction)startDate:(id)sender {
}

- (IBAction)endDate:(id)sender {
}

- (IBAction)activateQRCode:(id)sender {
   
    //    AAHomeViewController* mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"AAHomeViewController"];
    redeemVoucherVC *redeemVC = [self.storyboard instantiateViewControllerWithIdentifier:@"redeemVoucherVC"];
    [self.navigationController pushViewController:redeemVC animated:YES];
}
@end
