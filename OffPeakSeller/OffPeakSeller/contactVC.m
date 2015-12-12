//
//  contactVC.m
//  OffPeakSeller
//
//  Created by Admin on 12/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "contactVC.h"
#import "AAConfig.h"
#import "AAHeaderView.h"
#import "AAConfig.h"

@interface contactVC ()

@end

@implementation contactVC
@synthesize nameTextFiled,emailTextField,subjectTextfield,messageTextView,addressLabel,phoneNumberLabel,titleLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden=YES;
    
    AAHeaderView *headerView = [[AAHeaderView alloc] initWithFrame:self.menuView.frame];
    [self.menuView addSubview:headerView];
    [headerView setTitle:self.title];
    headerView.showCart = false;
    headerView.showBack = false;
    //  headerView.delegate = self;
    [headerView setMenuIcons];
    
    UILabel *titleLabel1=[[UILabel alloc]initWithFrame:CGRectMake(3*headerView.frame.size.width/10,20,4*headerView.frame.size.width/10,40)];
    titleLabel1=titleLabel;
    [headerView addSubview:titleLabel1];
    
    
     CGSize lblRetailerPoweredBySize = [AAUtils getTextSizeWithFont:self.addressLabel.font andText:@"oi;aSFIOas ajsbfa;NO OIAsfb ;oAFS OIBNFIO;AF O;Ibbo ;IASGS Oa sfgAOS OIKasfglo;AS" andMaxWidth:addressLabel.frame.size.width];
    
     addressLabel.font=[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:lblRetailerPoweredBySize.height];
    

  /*  addressLabel.font=[UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:13];
    
    self.addressLabel.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:CONATCT_FIELD_TEXT_SIZE];
    
    self.phoneNumberLabel.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:CONATCT_FIELD_TEXT_SIZE];
    
    self.nameTextFiled.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:CONATCT_FIELD_TEXT_SIZE];
    
    self.emailTextField.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:CONATCT_FIELD_TEXT_SIZE];
    
     self.subjectTextfield.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:CONATCT_FIELD_TEXT_SIZE];
    
     self.messageTextView.font = [UIFont fontWithName:[AAAppGlobals sharedInstance].normalFont size:CONATCT_FIELD_TEXT_SIZE];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textView

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    [self.view setFrame:CGRectMake(0, -250, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

#pragma mark - textField

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    
    if(textField.tag==300)
    {
        [self.view setFrame:CGRectMake(0, -50, self.view.frame.size.width, self.view.frame.size.height)];
    }
    else if (textField.tag==301)
    {
        [self.view setFrame:CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height)];
    }
    else
    {
        [self.view setFrame:CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height)];
    }

    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitButton:(id)sender {
    
    [nameTextFiled resignFirstResponder];
    [emailTextField resignFirstResponder];
    [subjectTextfield resignFirstResponder];
    
    [messageTextView resignFirstResponder];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
    
    
}
@end
