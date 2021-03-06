//
//  AAThemeGlossyButton.m
//  AppWiz
//
//  Created by Shahid Akhtar Shaikh on 29/12/13.
//  Copyright (c) 2013 Shahid Akhtar Shaikh. All rights reserved.
//

#import "AAThemeGlossyButton.h"

@implementation AAThemeGlossyButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initValues];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self initValues];
    }
    
    return self;
}

-(void)initValues
{
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTheme) name:NOTIFICATION_THEME_CHANGED object:nil];
    [self updateTheme];
}

-(void)updateTheme
{
//    [self setGlossButtonBackgroundColor:[AAColor sharedInstance].retailerThemeBackgroundColor];
    [self setTitleColor:[AAColor sharedInstance].retailerThemeTextColor forState:UIControlStateNormal];
    [self.layer setCornerRadius:4.0];
    [self setBackgroundColor:[AAColor sharedInstance].buttonBgColor];
    [self.titleLabel setFont:[UIFont fontWithName:[AAAppGlobals sharedInstance].boldFont size:BUTTON_FONTSIZE]];
}

-(void)changeTheme
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateTheme];
    });
}
-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_THEME_CHANGED object:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
