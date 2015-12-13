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
#import "AADatePickerView.h"
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

@property (nonatomic,strong) AADatePickerView* datePickerView;

@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@end
static NSString* const DATE_FORMAT = @"dd-MM-yyyy";
@implementation SellerAccountVC
@synthesize menuView,circularProgressView,RedeemedValueLabel,companyDetailsTableView,UnitsSoldValueLabel,titleLabel,percentageLabel,locationValueButton,startdateValueButton,enddateValueButton,companyNameValueLabel,contactValueLabel,EmailValueLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.endDate = [NSDate date];
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
//    NSString *scheduledDate =[[AAAppGlobals sharedInstance] convertDateToString:self.endDate];
//    [self.btnEndDate setTitle:scheduledDate forState:UIControlStateNormal];
    
}
-(void)setStartDate:(NSDate *)startDate{
    _startDate = startDate;
    NSString *scheduledDate =[[AAAppGlobals sharedInstance] convertDateToString:startDate];
    [self.btnStartDate setTitle:scheduledDate forState:UIControlStateNormal];
    [self refreshData];
}
-(void)setEndDate:(NSDate *)endDate{
    _endDate = endDate;
    NSString *scheduledDate =[[AAAppGlobals sharedInstance] convertDateToString:endDate];
    [self.btnEndDate setTitle:scheduledDate forState:UIControlStateNormal];
    [self refreshData];
}
-(void)refreshData{
    NSString *endDate =[[AAAppGlobals sharedInstance] convertDateToString:self.endDate];
    NSString *startDate =[[AAAppGlobals sharedInstance] convertDateToString:self.startDate];
    [SellerDashBoardHelper
     getSellerInfoEmailId:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_EMAIL]
     startDate:startDate
     endDate:endDate
     withCompletionBlock:^(NSDictionary *dict) {
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
-(void)viewWillAppear:(BOOL)animated{
    [self refreshData];
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
    self.datePickerView = [AADatePickerView createDatePickerViewWithBackgroundFrameRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    ;
    self.datePickerView.tag =100;
    
    [self.datePickerView.datePicker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATE_FORMAT];
    if (self.startDate) {
        [self.datePickerView setDatepickerDate:self.startDate];
    }
    self.datePickerView.datePickerDelegate = self;
    [self.view addSubview:self.datePickerView];
}

- (IBAction)endDate:(id)sender {
    self.datePickerView = [AADatePickerView createDatePickerViewWithBackgroundFrameRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    ;
     self.datePickerView.tag =101;
    if (self.startDate) {
        [self.datePickerView.datePicker setMinimumDate:self.startDate];
    }
    
    [self.datePickerView.datePicker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATE_FORMAT];
    
    [self.datePickerView setDatepickerDate:self.endDate];
    
    self.datePickerView.datePickerDelegate = self;
    [self.view addSubview:self.datePickerView];
}
#pragma mark - Date Picker Callbacks
-(void)onDateCancelled
{
    
}
-(void)onDateSelected:(NSDate *)date
{
    if (self.datePickerView.tag == 101) {
        if ([date compare:self.startDate] == NSOrderedAscending) {
            
        }else{
            self.endDate = date;
            
        }
    }else{
        if ([date compare:self.endDate] == NSOrderedAscending) {
            self.startDate = date;
        }else{
            
        }
    }
}

- (IBAction)activateQRCode:(id)sender {
   
    //    AAHomeViewController* mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"AAHomeViewController"];
    redeemVoucherVC *redeemVC = [self.storyboard instantiateViewControllerWithIdentifier:@"redeemVoucherVC"];
    [self.navigationController pushViewController:redeemVC animated:YES];
}
@end
