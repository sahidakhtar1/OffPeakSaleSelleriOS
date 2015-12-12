//
//  loginVC.m
//  OffPeakSeller
//
//  Created by ImranNew on 08/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "loginVC.h"

@interface loginVC ()

@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signIn:(id)sender {
  
}


- (IBAction)forgotPassword:(id)sender {
}


- (IBAction)needHelp:(id)sender {
}

#pragma mark - TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.backgroundColor=[UIColor redColor];
    
    UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:101];
    
    if(indexPath.row==0)
    {
        recipeNameLabel.text = @"Seller ID";
    }
    else if (indexPath.row==1)
    {
        recipeNameLabel.text = @"Password";
    }
    else
    {
        recipeNameLabel.text = @"Country";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
