//
//  splashScreenVC.m
//  OffPeakSeller
//
//  Created by ImranNew on 08/12/15.
//  Copyright © 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "splashScreenVC.h"
#import "loginVC.h"
#import "AppDelegate.h"
#include "ImageDownloader.h"
@interface splashScreenVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgSplash;
@property (nonatomic, strong) NSString *splashScreenImageURL;

@end

@implementation splashScreenVC
@synthesize poweredByLabel,urlLinkLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden=YES;
    
    //Powered by:
    //http://www.smartcommerce.asia
    
    self.imageDownloadsInProgress = [[NSMutableDictionary alloc] init];
    self.poweredByLabel.text=@"Powered by:";
    self.urlLinkLabel.text=[AAAppGlobals sharedInstance].retailer.retailerPoweredBy;
    self.urlLinkLabel.textColor=[UIColor blueColor];
    self.splashScreenImageURL = [AAAppGlobals sharedInstance].retailer.splashScreenURLString;
    
    if(self.splashScreenImageURL)
    {
//        [self adjustLabels];
        NSString *compLogoName = [self.splashScreenImageURL lastPathComponent];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        path = [NSString stringWithFormat:@"%@/%@",path,compLogoName];
        NSFileManager* filemanager = [NSFileManager defaultManager];
        UIImage *logoImage;
        if ([filemanager fileExistsAtPath:path]) {
            logoImage = [UIImage imageWithContentsOfFile:path];
            [self.urlLinkLabel setHidden:NO];
            [self.poweredByLabel setHidden:NO];
            [self setUpTimer];
        }else{
            [self startImageDownload:[AAAppGlobals sharedInstance].retailer.splashScreenURLString forIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            
        }
        self.imgSplash.image = logoImage;
    }
    else
    {
        [self setUpTimer];
    }
}
//initiate download of image for a row
- (void)startImageDownload:(NSString *)imageUrl forIndexPath:(NSIndexPath *)indexPath {
    ImageDownloader *imageLoader = [self.imageDownloadsInProgress objectForKey:indexPath];
    if (imageLoader == nil) {
        imageLoader = [[ImageDownloader alloc] init];
        imageLoader.indexPathCurrentRow = indexPath;
        imageLoader.delegate = self;
        [self.imageDownloadsInProgress setObject:imageLoader forKey:indexPath];
        [imageLoader startImageDownload:imageUrl];
    }
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)imageDownloadComplete:(UIImage*)prodImage forIndex:(NSIndexPath*)indexPath{
    NSLog(@"imageDownloadComplete");
    ImageDownloader *imageLoader = [self.imageDownloadsInProgress objectForKey:indexPath];
    
    if (imageLoader != nil) {
        if(indexPath.row == 1){
            
            NSString *compLogoName = [self.splashScreenImageURL lastPathComponent];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *path = [paths objectAtIndex:0];
            path = [NSString stringWithFormat:@"%@/%@",path,compLogoName];
            NSFileManager* filemanager = [NSFileManager defaultManager];
            if ([filemanager fileExistsAtPath:path]) {
                
            }else{
                NSData *imageData = UIImagePNGRepresentation(prodImage);
                [filemanager createFileAtPath:path contents:imageData attributes:nil];
            }
            self.imgSplash.image = prodImage;
            [self.urlLinkLabel setHidden:NO];
            [self.poweredByLabel setHidden:NO];
            [self setUpTimer];
        }
    }
    [self.imageDownloadsInProgress removeObjectForKey:indexPath];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpTimer
{
    NSLog(@"setUpTimer splash screen");
    [NSTimer scheduledTimerWithTimeInterval:3
                                     target:self
                                   selector:@selector(closeSplashScreen:)
                                   userInfo:nil
                                    repeats:NO];}

-(void)closeSplashScreen:(NSTimer*)timer
{
    NSLog(@"closeSplashScreen splash screen");
    NSArray *allKeys = [self.imageDownloadsInProgress allKeys];
    for (int i= 0; i< [allKeys count]; i++) {
        ImageDownloader *imgDownloader = [self.imageDownloadsInProgress objectForKey:[allKeys objectAtIndex:i]];
        [imgDownloader cancelImageDownload];
    }
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate splashFinished];
}
-(void)adjustLabels
{
    CGFloat labelWidth = self.poweredByLabel.frame.size.width;
    
    CGSize lblRetailerPoweredBySize = [AAUtils getTextSizeWithFont:self.urlLinkLabel.font andText:[AAAppGlobals sharedInstance].retailer.retailerPoweredBy andMaxWidth:self.view.frame.size.width];
    CGFloat totalWidth = labelWidth + lblRetailerPoweredBySize.width;
    
    CGFloat originX = ceilf((self.view.frame.size.width - totalWidth)/2);
    
    CGRect framePoweredBy = self.poweredByLabel.frame;
    framePoweredBy.origin.x = originX;
    self.poweredByLabel.frame = framePoweredBy;
    CGRect frameRetailerPoweredBy = self.urlLinkLabel.frame;
    frameRetailerPoweredBy.size.width = lblRetailerPoweredBySize.width;
    frameRetailerPoweredBy.origin.x = framePoweredBy.origin.x + framePoweredBy.size.width;
    self.urlLinkLabel.frame = frameRetailerPoweredBy;
    [self.urlLinkLabel setText:[AAAppGlobals sharedInstance].retailer.retailerPoweredBy];
}
@end
