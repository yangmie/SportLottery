//
//  DataCenterViewController.m
//  SportLottery
//
//  Created by Yu-Chung, Yang on 12/12/27.
//  Copyright (c) 2012年 Yu-Chung, Yang. All rights reserved.
//

#import "DataCenterViewController.h"

@interface DataCenterViewController ()

@end

@implementation DataCenterViewController
@synthesize type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    AllDataViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"AllData"];
    [vc1 setDetailItem:_detailItem type:type];

    AllDataViewController* vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"Recent10"];
    [vc2 setDetailItem:_detailItem type:type];
    
    AllDataViewController* vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"TotalData"];
    [vc3 setDetailItem:_detailItem type:type];
    
    //DataCenterViewController *dataCenterViewController = [DataCenterViewController alloc];
//    self.dataCenterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DataCenter"];
    NSArray* controllers = [NSArray arrayWithObjects:vc1, vc2, vc3, nil];
    self.viewControllers = controllers;
    self.customizableViewControllers = controllers;
    
   // self.view = self.dataCenterViewController;
   // window.rootViewController = tabBarController;
    
   // self.dataCenterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AllData"];
    //傳遞參數
   // [self.dataCenterViewController setDetailItem:_detailItem type:type];	// Do any additional setup after loading the view.
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDetailItem:(id)newDetailItem type:(NSString *)sportType
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
        type = sportType;
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        //   self.detailDescriptionLabel.text = [self.detailItem description];
        //  NSString *t_away = [[self.detailItem objectForKey:@"away"] objectForKey:@"t_name"];
        //  NSString *t_home = [[self.detailItem objectForKey:@"home"] objectForKey:@"t_name"];
        //  NSString *title = [[NSString alloc] initWithFormat:@"%@ @ %@", t_away, t_home];
        //  self.navigationItem.title = title;
    }
}


@end
