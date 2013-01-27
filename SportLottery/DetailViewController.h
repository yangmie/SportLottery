//
//  DetailViewController.h
//  SportLottery
//
//  Created by Yu-Chung, Yang on 12/12/22.
//  Copyright (c) 2012年 Yu-Chung, Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasketballCell.h"
#import "EGORefreshTableHeaderView.h"

@class DataCenterViewController;
//@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UITableViewDelegate>
@interface DetailViewController : UITableViewController <EGORefreshTableHeaderDelegate>


@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) DataCenterViewController *dataCenterViewController;
@property NSTimer *timer;
@property (strong, nonatomic) EGORefreshTableHeaderView *refreshHeaderView;
@property (assign, nonatomic)BOOL reloading;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

//-(void)initNewObject: (NSDictionary *)status;
-(void)getGameInfo;
-(NSString *)sportType;
- (void)showDetailBK:(BasketballCell *)cell at:(int)row;
- (void)showDetailFB:(BasketballCell *)cell at:(int)row;
- (void)showDetailBB:(BasketballCell *)cell at:(int)row;

@end
