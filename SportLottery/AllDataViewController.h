//
//  AllDataViewController.h
//  SportLottery
//
//  Created by Yu-Chung, Yang on 12/12/24.
//  Copyright (c) 2012年 Yu-Chung, Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSDictionary *homeStatus, *awayStatus;
@property (nonatomic, retain) IBOutlet UIView *viewFootball, *viewBasketball;
@property (nonatomic, weak) IBOutlet UITableView *viewRecent;
// basketball
@property (strong, nonatomic) id detailItem;
@property (nonatomic, weak) NSString *type;
@property (nonatomic, weak) IBOutlet UILabel *teamName1, *teamName2;
@property (nonatomic, weak) IBOutlet UILabel *pk1, *pk2;
@property (nonatomic, weak) IBOutlet UILabel *over1, *over2;
@property (nonatomic, weak) IBOutlet UILabel *run1, *run2;
@property (nonatomic, weak) IBOutlet UILabel *a1_5, *h1_5;
@property (nonatomic, weak) IBOutlet UILabel *a6_10, *h6_10;
@property (nonatomic, weak) IBOutlet UILabel *a11_15, *h11_15;
@property (nonatomic, weak) IBOutlet UILabel *a16_20, *h16_20;
@property (nonatomic, weak) IBOutlet UILabel *a21_25, *h21_25;
@property (nonatomic, weak) IBOutlet UILabel *a26, *h26;
@property (nonatomic, weak) IBOutlet UILabel *threshold, *odds;
@property (nonatomic, weak) IBOutlet UILabel *t_average_lost_points1, *t_average_lost_points2;
@property (nonatomic, weak) IBOutlet UILabel *t_away_average_points1, *t_away_average_points2;
@property (nonatomic, weak) IBOutlet UILabel *t_away_win1, *t_away_win2;
@property (nonatomic, weak) IBOutlet UILabel *t_home_average_points1, *t_home_average_points2;
@property (nonatomic, weak) IBOutlet UILabel *t_home_win1, *t_home_win2;
@property (nonatomic, weak) IBOutlet UILabel *t_recent1, *t_recent2;
@property (nonatomic, weak) IBOutlet UILabel *t_win1, *t_win2;

//football
@property (nonatomic, weak) IBOutlet UILabel *homeName, *awayName;
@property (nonatomic, weak) IBOutlet UILabel *home, *away, *draw;
@property (nonatomic, weak) IBOutlet UILabel *large, *t_hold, *little;
@property (nonatomic, weak) IBOutlet UILabel *t11, *t22, *t33, *t00, *t_other;
@property (nonatomic, weak) IBOutlet UILabel *h10, *h20, *h30, *h40, *h50, *h21, *h31, *h41, *h51, *h32, *h42, *h52, *h_other;
@property (nonatomic, weak) IBOutlet UILabel *a10, *a20, *a30, *a40, *a50, *a21, *a31, *a41, *a51, *a32, *a42, *a52, *a_other;
@property (nonatomic, weak) IBOutlet UILabel *t_goal_conceded1, *t_goal_difference1, *t_scored1, *t_played1;
@property (nonatomic, weak) IBOutlet UILabel *t_points1, *t_position1, *t_result1;
@property (nonatomic, weak) IBOutlet UILabel *t_goal_conceded2, *t_goal_difference2, *t_scored2, *t_played2;
@property (nonatomic, weak) IBOutlet UILabel *t_points2, *t_position2, *t_result2;

- (void)setDetailItem:(id)newDetailItem type:(NSString *)type;
- (void)showFootballView;
- (void)showBasketballView;
- (NSDictionary *) getTeamStatus: (NSString *)teamId;


@end
