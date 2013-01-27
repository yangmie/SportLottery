//
//  DataCenterViewController.h
//  SportLottery
//
//  Created by Yu-Chung, Yang on 12/12/27.
//  Copyright (c) 2012年 Yu-Chung, Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllDataViewController.h"


@interface DataCenterViewController : UITabBarController

@property (strong, nonatomic) id detailItem;
@property (nonatomic, weak) NSString *type;

- (void)setDetailItem:(id)newDetailItem type:(NSString *)type;

@end
