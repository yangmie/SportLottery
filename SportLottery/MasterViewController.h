//
//  MasterViewController.h
//  SportLottery
//
//  Created by Yu-Chung, Yang on 12/12/22.
//  Copyright (c) 2012年 Yu-Chung, Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasketballCell.h"


@class DetailViewController;

@interface MasterViewController : UITableViewController
{
    BOOL networkStatus;
}

@property (strong, nonatomic) DetailViewController *detailViewController;
@property BOOL networkStatus;

-(void)initNewObject: (NSString *)sport;

@end
