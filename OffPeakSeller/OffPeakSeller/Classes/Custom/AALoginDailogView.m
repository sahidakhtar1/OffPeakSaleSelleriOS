//
//  AALoginDailogView.m
//  AppWiz
//
//  Created by Shaikh Shahid Akhtar on 24/04/14.
//  Copyright (c) 2014 Shahid Akhtar Shaikh. All rights reserved.
//

#import "AALoginDailogView.h"
#import "AALoginHelper.h"
#import "AACountriesHelper.h"

static NSString* const JSON_RETAILER_ID_KEY = @"retailerId";
static NSString* const COUNTRY_CODE_KEY = @"countryCode";
static NSString* const COUNTRY_NAME_KEY = @"countryName";
@implementation AALoginDailogView

@synthesize delegate;
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:@"AALoginDailogView" bundle:nibBundleOrNil];
    if (self) {
        // Initialization code
        [self refreshView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)viewDidLoad{
    [super viewDidLoad];
    [self refreshView];
    [self populateCountries];
}

-(void)refreshView{
    CGRect rect = [UIScreen mainScreen].bounds;
    self.vwHeaderView.backgroundColor = [AAColor sharedInstance].retailerThemeBackgroundColor;
    self.vwForgotPassordTitleBG.backgroundColor = [AAColor sharedInstance].retailerThemeBackgroundColor;
    self.tfemailaddress.text = @"";
    self.tfPassword.text = @"";
    
    self.tfemailaddress.leftView = [self getLeftImageViewWithImage:@"email_black"];
    self.tfemailaddress.leftViewMode = UITextFieldViewModeAlways;
    self.tfPassword.leftView = [self getLeftImageViewWithImage:@"password_black"];
    self.tfPassword.leftViewMode = UITextFieldViewModeAlways;
    self.tfCountry.leftView = [self getLeftImageViewWithImage:@"country"];
    self.tfCountry.leftViewMode = UITextFieldViewModeAlways;
    
    _btnFBLogin.layer.cornerRadius = 4.0f;
}
-(UIView*)getLeftImageViewWithImage:(NSString*)imageName{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 20, 20)];
    [imgView setImage:[UIImage imageNamed:imageName]];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [leftView addSubview:imgView];
    return leftView;
}

- (IBAction)btnGetPawwordTapped:(id)sender {
    NSString *message = nil;
    if (![self validateEmailId:self.tfemailaddress.text]) {
        message = @"Please Enter Valid Email Address.";
    }
    if (message != nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }else{
        //[self userLoginSucessfully];
        NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:RETAILER_ID,JSON_RETAILER_ID_KEY,self.tfemailaddress.text,@"email", nil];
        [AALoginHelper processForgotPaswordWithCompletionBlock:^(NSString *sucessMsg){
            [[[UIAlertView alloc] initWithTitle:nil message:sucessMsg delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
            self.formType = FormTypeLogin;
        }andFailure:^(NSString *error){
            [[[UIAlertView alloc] initWithTitle:nil message:error delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
        }withParams:params];
    }
}

- (IBAction)btnFbTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fBLoginTapped)]) {
        [self.delegate fBLoginTapped];
    }
}

- (IBAction)btnNeedHelpTapped:(id)sender {
    
}

- (IBAction)btnLogintapped:(id)sender {
    if(self.formType == FormTypeForgotPassword){
        [self btnGetPawwordTapped:nil];
    }else{

            [self.tfPassword resignFirstResponder];
            [self.tfemailaddress resignFirstResponder];
            NSString *message = nil;
            if (![self validateEmailId:self.tfemailaddress.text]) {
                message = @"Please Enter Valid Email Address.";
            }else if ([self.tfPassword.text isEqualToString:@""]){
                message = @"Please Enter Password.";
            }
            if (message != nil) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
            }else{
                NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:RETAILER_ID,JSON_RETAILER_ID_KEY,self.tfemailaddress.text,@"email",self.tfPassword.text,@"password", nil];
                [AALoginHelper processLoginWithCompletionBlock: ^{

                    [self userLoginSucessfully];
                }andFailure:^(NSString *error){
                    [[[UIAlertView alloc] initWithTitle:nil message:error delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
                }withParams:params];
                
            }
    }
}

- (IBAction)btnForgotPasswordTapped:(id)sender {
    [self clearfileds];
    if (self.formType == FormTypeLogin) {
        self.formType = FormTypeForgotPassword;
    }else{
        self.formType = FormTypeLogin;
    }
    
    
}

-(void)showLoginPopup{
    [self clearfileds];
    [UIView animateWithDuration:1
                     animations:^{
                         [self.veForgotPasswordView removeFromSuperview];
                         [self.view addSubview:self.vwContainerView];
                     }
                     completion:nil];
}
-(void)clearfileds{
    self.tfFPEmailId.text = @"";
    self.tfPassword.text = @"";
    self.tfemailaddress.text = @"";
}
-(BOOL)validateEmailId:(NSString*)emailid{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL myStringMatchesRegEx=[emailTest evaluateWithObject:emailid];

    return myStringMatchesRegEx;
    if (myStringMatchesRegEx) {
     
        return NO;
    }else{
        return YES;
    }
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.tfCountry) {
        [self showCountriesDropDownMenu];
        return false;
    }
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    CGRect rect = [UIScreen mainScreen].bounds;
//    if (textField == self.tfemailaddress || textField == self.tfPassword) {
//        [UIView animateWithDuration:.5 animations:^(void){
//            CGRect frame = self.vwContainerView.frame;
//            
//            float endPoint = frame.origin.y + frame.size.height;
//            if ((rect.size.height - 216)<endPoint) {
//                frame.origin.y -= endPoint - (rect.size.height -216);
//            }
//            self.vwContainerView.frame = frame;
//        }
//                         completion:nil];
//       
//    }else if(textField == self.tfFPEmailId){
//        [UIView animateWithDuration:.5 animations:^(void){
//            CGRect frame = self.veForgotPasswordView.frame;
//            
//            float endPoint = frame.origin.y + frame.size.height;
//            if ((rect.size.height - 216)<endPoint) {
//                frame.origin.y -= endPoint - (rect.size.height -216);
//            }
//            self.veForgotPasswordView.frame = frame;
//        }
//                         completion:nil];
//    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
//    CGRect rect = [UIScreen mainScreen].bounds;
//    if (textField == self.tfemailaddress || textField == self.tfPassword) {
//        self.vwContainerView.center = CGPointMake(self.vwContainerView.center.x, rect.size.height/2);
//    }else if (textField == self.tfFPEmailId){
//        self.veForgotPasswordView.center = CGPointMake(self.vwContainerView.center.x, rect.size.height/2);
//    }
    return YES;
}
-(void)userLoginSucessfully{
//    [AAAppGlobals sharedInstance].customerEmailID = self.tfemailaddress.text;
//    [AAAppGlobals sharedInstance].customerPassword = self.tfPassword.text;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(logionSucessful)]) {
        [self.delegate logionSucessful];
    }
}
-(void)setFormType:(FormType)formType{
    _formType = formType;
    [UIView animateWithDuration:.3
                     animations:^{
                            switch (_formType) {
                                case FormTypeLogin:
                                {
                                    self.lblFormTitle.text = @"Seller Login";
                                    [self.btnLogin setTitle:@"Login" forState:UIControlStateNormal];
                                    self.tfPassword.hidden = false;
                                    self.tfCountry.hidden = false;
                                    [self.btnForgotPassword setTitle:@"Forgot Password" forState:UIControlStateNormal];
                                }
                                    break;
                                case FormTypeForgotPassword:
                                {
                                    self.lblFormTitle.text = @"Forgot Password";
                                    [self.btnLogin setTitle:@"Send Email" forState:UIControlStateNormal];
                                    
                                    self.tfPassword.hidden = true;
                                    self.tfCountry.hidden = true;
                                    [self.btnForgotPassword setTitle:@"Back to login" forState:UIControlStateNormal];;
                                }
                                    break;
                                    
                                default:
                                    break;
                            }
                     }
                     completion:nil];
    [self adjustViewFrame:formType];
}
-(void)adjustViewFrame:(FormType)formType{
    [UIView animateWithDuration:.3
                     animations:^{
                         
                     
                            float yCod = self.tfemailaddress.frame.origin.y+self.tfemailaddress.frame.size.height+8;
                            CGRect frame ;
                            if (formType == FormTypeLogin) {
                               yCod = self.tfCountry.frame.origin.y+self.tfCountry.frame.size.height+8;
                                self.tfCountry.hidden = false;
                            }else{
                                yCod = self.tfemailaddress.frame.origin.y+self.tfemailaddress.frame.size.height+8;
                                self.tfCountry.hidden = true;
                            }
                            frame = self.btnLogin.frame;
                            frame.origin.y = yCod;
                            self.btnLogin.frame = frame;
                            yCod += (frame.size.height+15);
                            
                     }
                     completion:nil];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tfemailaddress resignFirstResponder];
    [self.tfPassword resignFirstResponder];
    [self.dropDownScrollViewCountries removeFromSuperview];
}

-(void)populateCountries
{
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"countries"])
    {
        self.arrCountries = [[NSUserDefaults standardUserDefaults] objectForKey:@"countries"];
    }
    else
    {
        [AACountriesHelper getCountriesFromServerWithCompletionBlock:^(NSMutableArray * countries) {
            self.arrCountries = countries;
            [[NSUserDefaults standardUserDefaults] setObject:self.arrCountries forKey:@"countries"];
        } andFailure:^(NSString * errorMessage) {
            
        }];
    }
    
}
-(void)showCountriesDropDownMenu
{
    if ([self.arrCountries count]==0) {
        return;
    }
    CGRect frame;
    frame = self.tfCountry.frame;
    
    self.dropDownScrollViewCountries = [[AAFilterDropDownScrollView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height + 2,frame.size.width,90)];
    [self.dropDownScrollViewCountries setItemHeight:30];
    self.dropDownScrollViewCountries.dropDownDelegate = self;
    [self.dropDownScrollViewCountries setItems:[self.arrCountries valueForKey:COUNTRY_NAME_KEY]];
    [self.dropDownScrollViewCountries refreshScrollView];
    [self.view addSubview:self.dropDownScrollViewCountries];
    [self.scrollViewFieldsContainter scrollRectToVisible:self.dropDownScrollViewCountries.frame animated:YES];
    [self.dropDownScrollViewCountries.hiddenTexfield becomeFirstResponder];
}
#pragma mark - Scroll view delegate callbacks
-(void)onDropDownMenuItemSelected:(id)dropDownScrollView withItemName:(NSString *)itemName
{
    self.tfCountry.text = itemName;
    [dropDownScrollView removeFromSuperview];
    
}

@end
