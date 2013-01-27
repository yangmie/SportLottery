//
//  AllDataViewController.m
//  SportLottery
//
//  Created by Yu-Chung, Yang on 12/12/24.
//  Copyright (c) 2012年 Yu-Chung, Yang. All rights reserved.
//

#import "AllDataViewController.h"
#import "Connector.h"
#import "SBJson.h"
#import "BasketballCell.h"

@interface AllDataViewController () {
}

//@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end


@implementation AllDataViewController

@synthesize homeStatus, awayStatus;

@synthesize type;
@synthesize viewBasketball, viewFootball, viewRecent;
@synthesize teamName1, teamName2;
@synthesize pk1, pk2;
@synthesize over1, over2;
@synthesize run1, run2;
@synthesize a1_5, h1_5;
@synthesize a6_10, h6_10;
@synthesize a11_15, h11_15;
@synthesize a16_20, h16_20;
@synthesize a21_25, h21_25;
@synthesize a26, h26;
@synthesize threshold, odds;
@synthesize home, away, draw;
@synthesize t_average_lost_points1, t_average_lost_points2;
@synthesize t_away_average_points1, t_away_average_points2;
@synthesize t_away_win1, t_away_win2;
@synthesize t_home_average_points1, t_home_average_points2;
@synthesize t_home_win1, t_home_win2;
@synthesize t_recent1, t_recent2;
@synthesize t_win1, t_win2;

@synthesize homeName, awayName;
@synthesize large, little, t_hold;
@synthesize t00, t11, t22, t33, t_other;
@synthesize h10, h20, h30, h40, h50, h21, h31, h41, h32, h42, h52, h51, h_other;
@synthesize a10, a20, a30, a40, a50, a21, a31, a41, a32, a42, a52, a51, a_other;
@synthesize t_goal_conceded1, t_goal_difference1, t_scored1, t_played1;
@synthesize t_points1, t_position1, t_result1;
@synthesize t_goal_conceded2, t_goal_difference2, t_scored2, t_played2;
@synthesize t_points2, t_position2, t_result2;

@synthesize detailItem = _detailItem;

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    if ([type isEqualToString:@"bk"])
    {
        [self showBasketballView];        
    }
    else if ([type isEqualToString:@"fb"])
    {
        [self showFootballView];
    }
}

- (void)showFootballView
{
    self.viewBasketball.hidden = YES;
    self.viewFootball.hidden = NO;
    
    self.homeName.text = [[self.detailItem objectForKey:@"home"] objectForKey:@"t_name"];
    self.awayName.text = [[self.detailItem objectForKey:@"away"] objectForKey:@"t_name"];
    self.home.text = [self.detailItem objectForKey:@"g_home_odds"];
    self.away.text = [self.detailItem objectForKey:@"g_away_odds"];
    self.draw.text = [self.detailItem objectForKey:@"g_draw_odds"];
    self.large.text = [self.detailItem objectForKey:@"g_over"];
    self.little.text = [self.detailItem objectForKey:@"g_under"];
    NSString *thres = [self.detailItem objectForKey:@"g_threshold"];
    self.t_hold.text = [[NSString alloc] initWithFormat:@"大 %@ 小", thres];
    NSString *tmp = [self.detailItem objectForKey:@"g_h0a0"];
    self.t00.text = [[NSString alloc] initWithFormat:@"0-0\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h1a1"];
    self.t11.text = [[NSString alloc] initWithFormat:@"1-1\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h2a2"];
    self.t22.text = [[NSString alloc] initWithFormat:@"2-2\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h3a3"];
    self.t33.text = [[NSString alloc] initWithFormat:@"3-3\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_d_other"];
    self.t_other.text = [[NSString alloc] initWithFormat:@"和其他\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h1a0"];
    self.h10.text = [[NSString alloc] initWithFormat:@"1-0\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h2a0"];
    self.h20.text = [[NSString alloc] initWithFormat:@"2-0\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h3a0"];
    self.h30.text = [[NSString alloc] initWithFormat:@"3-0\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h4a0"];
    self.h40.text = [[NSString alloc] initWithFormat:@"4-0\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h5a0"];
    self.h50.text = [[NSString alloc] initWithFormat:@"5-0\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h2a1"];
    self.h21.text = [[NSString alloc] initWithFormat:@"2-1\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h3a1"];
    self.h31.text = [[NSString alloc] initWithFormat:@"3-1\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h4a1"];
    self.h41.text = [[NSString alloc] initWithFormat:@"4-1\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h5a1"];
    self.h51.text = [[NSString alloc] initWithFormat:@"5-1\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h3a2"];
    self.h32.text = [[NSString alloc] initWithFormat:@"3-2\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h4a2"];
    self.h42.text = [[NSString alloc] initWithFormat:@"4-2\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h5a2"];
    self.h52.text = [[NSString alloc] initWithFormat:@"5-2\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h_other"];
    self.h_other.text = [[NSString alloc] initWithFormat:@"主其他\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h0a1"];
    self.a10.text = [[NSString alloc] initWithFormat:@"0-1\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h0a2"];
    self.a20.text = [[NSString alloc] initWithFormat:@"0-2\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h0a3"];
    self.a30.text = [[NSString alloc] initWithFormat:@"0-3\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h0a4"];
    self.a40.text = [[NSString alloc] initWithFormat:@"0-4\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h0a5"];
    self.a50.text = [[NSString alloc] initWithFormat:@"0-5\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h1a2"];
    self.a21.text = [[NSString alloc] initWithFormat:@"1-2\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h1a3"];
    self.a31.text = [[NSString alloc] initWithFormat:@"1-3\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h1a4"];
    self.a41.text = [[NSString alloc] initWithFormat:@"1-4\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h1a5"];
    self.a51.text = [[NSString alloc] initWithFormat:@"1-5\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h2a3"];
    self.a32.text = [[NSString alloc] initWithFormat:@"2-3\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h2a4"];
    self.a42.text = [[NSString alloc] initWithFormat:@"2-4\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_h2a5"];
    self.a52.text = [[NSString alloc] initWithFormat:@"2-5\t\n%@", tmp];
    tmp = [self.detailItem objectForKey:@"g_a_other"];
    self.a_other.text = [[NSString alloc] initWithFormat:@"客其他\t\n%@", tmp];
    
    self.t_goal_conceded1.text = [homeStatus objectForKey:@"t_goal_conceded"];
    self.t_goal_difference1.text = [homeStatus objectForKey:@"t_goal_difference"];
    self.t_scored1.text = [homeStatus objectForKey:@"t_goal_scored"];
    self.t_points1.text = [homeStatus objectForKey:@"t_points"];
    self.t_position1.text = [homeStatus objectForKey:@"t_position"];
    NSString *win_lost = [[NSString alloc] initWithFormat:@"%@ - %@ - %@", [homeStatus objectForKey:@"t_win"], [homeStatus objectForKey:@"t_draw"], [homeStatus objectForKey:@"t_lost"]];
    self.t_result1.text = win_lost;
    self.t_goal_conceded2.text = [awayStatus objectForKey:@"t_goal_conceded"];
    self.t_goal_difference2.text = [awayStatus objectForKey:@"t_goal_difference"];
    self.t_scored2.text = [awayStatus objectForKey:@"t_goal_scored"];
    self.t_points2.text = [awayStatus objectForKey:@"t_points"];
    self.t_position2.text = [awayStatus objectForKey:@"t_position"];
    win_lost = [[NSString alloc] initWithFormat:@"%@ - %@ - %@", [awayStatus objectForKey:@"t_win"], [awayStatus objectForKey:@"t_draw"], [awayStatus objectForKey:@"t_lost"]];
    self.t_result2.text = win_lost;
}

- (void)showBasketballView
{
    self.viewBasketball.hidden = NO;
    self.viewFootball.hidden = YES;
    
    // 所有賠率
    self.teamName1.text = [[self.detailItem objectForKey:@"away"] objectForKey:@"t_name"];
    self.teamName2.text = [[self.detailItem objectForKey:@"home"] objectForKey:@"t_name"];
    self.pk1.text = [self.detailItem objectForKey:@"g_away_odds"];
    self.pk2.text = [self.detailItem objectForKey:@"g_home_odds"];
    self.run1.text = [self.detailItem objectForKey:@"g_away_run_odds"];
    self.run2.text = [self.detailItem objectForKey:@"g_home_run_odds"];
    self.over1.text = [self.detailItem objectForKey:@"g_over"];
    self.over2.text = [self.detailItem objectForKey:@"g_under"];
    self.a1_5.text = [self.detailItem objectForKey:@"g_a5"];
    self.h1_5.text = [self.detailItem objectForKey:@"g_h5"];
    self.a6_10.text = [self.detailItem objectForKey:@"g_a10"];
    self.h6_10.text = [self.detailItem objectForKey:@"g_h10"];
    self.a11_15.text = [self.detailItem objectForKey:@"g_a15"];
    self.h11_15.text = [self.detailItem objectForKey:@"g_h15"];
    self.a16_20.text = [self.detailItem objectForKey:@"g_a20"];
    self.h16_20.text = [self.detailItem objectForKey:@"g_h20"];
    self.a21_25.text = [self.detailItem objectForKey:@"g_a25"];
    self.h21_25.text = [self.detailItem objectForKey:@"g_h25"];
    self.a26.text = [self.detailItem objectForKey:@"g_a_other"];
    self.h26.text = [self.detailItem objectForKey:@"g_h_other"];
    
    NSString *thres = [self.detailItem objectForKey:@"g_threshold"];
    self.threshold.text = [[NSString alloc] initWithFormat:@"大 %@ 小", thres];
    NSString *run = [self.detailItem objectForKey:@"g_run_line"];
    self.odds.text = [[NSString alloc] initWithFormat:@"讓分 (%@)", run];
    
    // 近況
    self.t_average_lost_points1.text = [self.awayStatus objectForKey:@"t_average_lost_points"];
    self.t_average_lost_points2.text = [self.homeStatus objectForKey:@"t_average_lost_points"];
    self.t_away_average_points1.text = [self.awayStatus objectForKey:@"t_away_average_points"];
    self.t_away_average_points2.text = [self.homeStatus objectForKey:@"t_away_average_points"];
    NSString *win_lost = [[NSString alloc] initWithFormat:@"%@ - %@", [self.awayStatus objectForKey:@"t_away_win"], [self.awayStatus objectForKey:@"t_away_lost"]];
    self.t_away_win1.text = win_lost;
    win_lost = [[NSString alloc] initWithFormat:@"%@ - %@", [self.homeStatus objectForKey:@"t_away_win"], [self.homeStatus objectForKey:@"t_away_lost"]];
    self.t_away_win2.text = win_lost;
    self.t_home_average_points1.text = [self.awayStatus objectForKey:@"t_home_average_points"];
    self.t_home_average_points2.text = [self.homeStatus objectForKey:@"t_home_average_points"];
    win_lost = [[NSString alloc] initWithFormat:@"%@ - %@", [self.awayStatus objectForKey:@"t_home_win"], [self.awayStatus objectForKey:@"t_home_lost"]];
    self.t_home_win1.text = win_lost;
    win_lost = [[NSString alloc] initWithFormat:@"%@ - %@", [self.homeStatus objectForKey:@"t_home_win"], [self.homeStatus objectForKey:@"t_home_lost"]];
    self.t_home_win2.text = win_lost;
    self.t_recent1.text = [self.awayStatus objectForKey:@"t_recent"];
    self.t_recent2.text = [self.homeStatus objectForKey:@"t_recent"];
    win_lost = [[NSString alloc] initWithFormat:@"%@ - %@", [self.awayStatus objectForKey:@"t_win"], [self.awayStatus objectForKey:@"t_lost"]];
    self.t_win1.text = win_lost;
    win_lost = [[NSString alloc] initWithFormat:@"%@ - %@", [self.homeStatus objectForKey:@"t_win"], [self.homeStatus objectForKey:@"t_lost"]];
    self.t_win2.text = win_lost;
}

- (void)setDetailItem:(id)newDetailItem type:(NSString *)sportType
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
        type = sportType;
        [self configureView];

        homeStatus = [self getTeamStatus:[[self.detailItem objectForKey:@"home"] objectForKey:@"t_id"]];
        awayStatus = [self getTeamStatus:[[self.detailItem objectForKey:@"away"] objectForKey:@"t_id"]];
        
        
    }
}

- (NSArray *)getTeamStatus:(NSString *)teamId
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys: type, @"SportType", teamId, @"TeamId", nil];
    
	Connector *connector = [[Connector alloc] initWithCommand:@"STAT"
													 andParam:param];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSData *response = [connector connect];
    //  NSLog(@"%@", response);
    if (response == nil) return NULL;
    
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    // parse the JSON response into an object
    // Here we're using NSArray since we're parsing an array of JSON status objects
    NSArray *statuses = [parser objectWithString:json_string error:nil];
    NSLog(@"%@", statuses);
    return statuses;

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *recentAway = [[awayStatus objectForKey:@"recents"] objectAtIndex:indexPath.row];
    NSDictionary *recentHome = [[homeStatus objectForKey:@"recents"] objectAtIndex:indexPath.row];
    if ([type isEqualToString:@"bk"])
    {
        static NSString *CellIdentifier = @"RecentBasketballCell";
        BasketballCell *cell = (BasketballCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[BasketballCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
           
        }
      //  NSLog(@"%@", recentAway);
        
        cell.team1.text = [recentAway objectForKey:@"op_name"];
        cell.team2.text = [recentHome objectForKey:@"op_name"];
        cell.host1.text = [[recentAway objectForKey:@"t_position"] isEqualToString:@"A"] ? @"客" : @"主";
        cell.host2.text = [[recentHome objectForKey:@"t_position"] isEqualToString:@"A"] ? @"客" : @"主";
        cell.result1.text = [recentAway objectForKey:@"g_result"];
        cell.result2.text = [recentHome objectForKey:@"g_result"];
        cell.date1.text = [[recentAway objectForKey:@"g_datetime"] substringToIndex:10];
        cell.date2.text = [[recentHome objectForKey:@"g_datetime"] substringToIndex:10];
        NSString *score = [[NSString alloc] initWithFormat:@"%@ : %@", [recentAway objectForKey:@"g_a_score"], [recentAway objectForKey:@"g_h_score"]];
        cell.score1.text = score;
        score = [[NSString alloc] initWithFormat:@"%@ : %@", [recentHome objectForKey:@"g_a_score"], [recentHome objectForKey:@"g_h_score"]];
        cell.score2.text = score;
        
        return cell;
    }
    else if ([type isEqualToString:@"fb"])
    {
        static NSString *CellIdentifier = @"RecentFootballCell";
        BasketballCell *cell = (BasketballCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[BasketballCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSLog (@"%@", recentAway);
        
        return cell;
    }
    return NULL;
}



@end
