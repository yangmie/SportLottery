//
//  DetailViewController.h
//  SportLottery
//
//  Created by Yu-Chung, Yang on 12/12/22.
//  Copyright (c) 2012年 Yu-Chung, Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
