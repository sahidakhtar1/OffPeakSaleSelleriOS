//
//  contactVC.h
//  OffPeakSeller
//
//  Created by Admin on 12/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contactVC : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,retain) IBOutlet UITextField *nameTextFiled;
@property (nonatomic,retain) IBOutlet UITextField *emailTextField;
@property (nonatomic,retain) IBOutlet UITextField *subjectTextfield;
@property (nonatomic,retain) IBOutlet UITextView *messageTextView;

@property (nonatomic,retain) IBOutlet UILabel *addressLabel;
@property (nonatomic,retain) IBOutlet UILabel *phoneNumberLabel;
- (IBAction)submitButton:(id)sender;

@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UIView *menuView;

@end
