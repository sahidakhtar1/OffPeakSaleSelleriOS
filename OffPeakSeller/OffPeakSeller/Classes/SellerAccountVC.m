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
#import "AAThemeGlossyButton.h"

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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *vwDetailContainer;
@property (weak, nonatomic) IBOutlet UIView *vwStats;
@property (weak, nonatomic) IBOutlet AAThemeGlossyButton *btnShowHideDetails;

@property (weak, nonatomic) IBOutlet UILabel *lblListPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblListPriceValue;
@property (weak, nonatomic) IBOutlet UILabel *lblDiscount;
@property (weak, nonatomic) IBOutlet UILabel *lblDiscountValue;
@property (weak, nonatomic) IBOutlet UILabel *lblGateway;
@property (weak, nonatomic) IBOutlet UILabel *lblGateWayValue;
@property (weak, nonatomic) IBOutlet UILabel *lblSalesComission;
@property (weak, nonatomic) IBOutlet UILabel *lblSalesComisstionValue;
@property (weak, nonatomic) IBOutlet UILabel *lblUnitProceed;
@property (weak, nonatomic) IBOutlet UILabel *lblUnitProceedValue;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalProceed;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalProceedValue;


- (IBAction)btnShowHideTapped:(id)sender;

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
    
    [self setFont];
}
-(void)setFont{
    [self.lblCompany setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblCompanyValue setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblContact setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblConatctValue setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblEmail setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblEmailValue setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblLocation setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.btnLocationValue.titleLabel setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblStartDate setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.btnStartDate.titleLabel setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblEndDate setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.btnEndDate.titleLabel setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    
    [self.lblListPrice setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblListPriceValue setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    
    [self.lblDiscount setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblDiscountValue setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    
    [self.lblGateway setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblGateWayValue setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    
    [self.lblSalesComission setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblSalesComisstionValue setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    
    [self.lblUnitProceed setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblUnitProceedValue setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    
    [self.lblTotalProceed setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblTotalProceedValue setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    
    [self.lblRedeemed setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    [self.lblSold setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_FIELD_TEXT_SIZE]];
    
    [self.RedeemedValueLabel setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_STATS_TEXT_SIZE]];
    [self.UnitsSoldValueLabel setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_STATS_TEXT_SIZE]];
    
    [self.percentageLabel setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:DASHBOARD_PERCENTAGE_TEXT_SIZE]];
    
    [self.lblRedeemed setTextColor:[AAColor sharedInstance].retailerThemeBackgroundColor];
    [self.lblSold setTextColor:[AAColor sharedInstance].retailerThemeBackgroundColor];
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
         @try {
             
             float redeemed = [[self.sellerInfoDict valueForKey:@"orders_redeemed"] floatValue];
             float sold = [[self.sellerInfoDict valueForKey:@"orders_sold"] floatValue];
             self.RedeemedValueLabel.text = [self.sellerInfoDict valueForKey:@"orders_redeemed"];
             self.UnitsSoldValueLabel.text = [self.sellerInfoDict valueForKey:@"orders_sold"];
             float percentage = redeemed/sold;
             [self.progressView setProgress:percentage animated:YES];
             NSString *percetageSymbol= @"%";
             percentageLabel.text= [NSString stringWithFormat:@"%.0f",percentage*100];
             
             self.lblCompanyValue.text = [self.sellerInfoDict valueForKey:@"company_name"];
             if ([[self.sellerInfoDict valueForKey:@"phone"] isKindOfClass:[NSNull class]]) {
                 
             }else{
                 self.lblConatctValue.text = [self.sellerInfoDict valueForKey:@"phone"];
             }
             
             self.lblEmailValue.text = [self.sellerInfoDict valueForKey:@"email"];
             [self.btnLocationValue setTitle:[self.sellerInfoDict valueForKey:@"country"] forState:UIControlStateNormal] ;
             
             
             self.lblListPriceValue.text = [NSString stringWithFormat:@"$%@",[self.sellerInfoDict valueForKey:@"listPrice"]];
             self.lblDiscountValue.text = [NSString stringWithFormat:@"%@%@",[self.sellerInfoDict valueForKey:@"discount"],percetageSymbol];
             self.lblGateWayValue.text = [NSString stringWithFormat:@"%@%@",[self.sellerInfoDict valueForKey:@"payComm"],percetageSymbol];
             self.lblSalesComisstionValue.text = [NSString stringWithFormat:@"%@%@",[self.sellerInfoDict valueForKey:@"saleComm"],percetageSymbol];
             self.lblUnitProceedValue.text = [NSString stringWithFormat:@"$%@",[self.sellerInfoDict valueForKey:@"unitPrice"]];
             self.lblTotalProceedValue.text = [NSString stringWithFormat:@"$%@",[self.sellerInfoDict valueForKey:@"totalAmtSold"]];
         }
         @catch (NSException *exception) {
             
             
         }
         @finally {
             
             
         }
         
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
            NSString *selectedDate = [[AAAppGlobals sharedInstance] convertDateToString:date];
            NSString *startDateStr = [[AAAppGlobals sharedInstance] convertDateToString:self.startDate];
            if ([selectedDate isEqualToString:startDateStr]) {
                self.endDate = date;
            }else{
                
            }
        }else{
            self.endDate = date;
        }
    }else{
        if ([date compare:self.endDate] == NSOrderedAscending) {
            self.startDate = date;
            self.btnStartDate.selected = false;
        }else{
            NSString *selectedDate = [[AAAppGlobals sharedInstance] convertDateToString:date];
            NSString *endDateStr = [[AAAppGlobals sharedInstance] convertDateToString:self.endDate];

            if ([selectedDate isEqualToString:endDateStr]) {
                self.startDate = date;
                self.btnStartDate.selected = false;
            }else{
                
            }
        }
    }
}

- (IBAction)activateQRCode:(id)sender {
   
    //    AAHomeViewController* mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"AAHomeViewController"];
    redeemVoucherVC *redeemVC = [self.storyboard instantiateViewControllerWithIdentifier:@"redeemVoucherVC"];
    [self.navigationController pushViewController:redeemVC animated:YES];
}
- (IBAction)btnShowHideTapped:(id)sender {
    float yCod;
    if (self.btnShowHideDetails.selected) {
        self.btnShowHideDetails.selected = NO;
        self.vwDetailContainer.hidden = YES;
        yCod = self.btnShowHideDetails.frame.origin.y + self.btnShowHideDetails.frame.size.height + 20;
    }else{
        self.btnShowHideDetails.selected = YES;
        self.vwDetailContainer.hidden = NO;
        yCod = self.vwDetailContainer.frame.origin.y + self.vwDetailContainer.frame.size.height + 8;
    }
    CGRect frame = self.vwStats.frame;
    frame.origin.y = yCod;
    self.vwStats.frame = frame;
    CGSize contentSize = self.scrollView.contentSize;
    contentSize.height = yCod + frame.size.height + 10;
    self.scrollView.contentSize = contentSize;
    
}
@end
