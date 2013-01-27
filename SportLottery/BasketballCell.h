//
//  BasketballCell.h
//  SportLottery
//
//  Created by Yu-Chung, Yang on 12/12/24.
//  Copyright (c) 2012年 Yu-Chung, Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasketballCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *sportName;

// basketball cell label
@property (nonatomic, weak) IBOutlet UILabel *teamName1, *teamName2;
@property (nonatomic, weak) IBOutlet UILabel *pk1, *pk2;
@property (nonatomic, weak) IBOutlet UILabel *over1, *over2;
@property (nonatomic, weak) IBOutlet UILabel *odds1, *odds2;
@property (nonatomic, weak) IBOutlet UILabel *pk, *gid, *over, *odds;
@property (nonatomic, weak) IBOutlet UILabel *lotteryDate;
// basketball instant label
@property (nonatomic, weak) IBOutlet UILabel *gameStatus, *away_score, *home_score;

//football cell label
@property (nonatomic, weak) IBOutlet UILabel *home, *tie, *away;
@property (nonatomic, weak) IBOutlet UILabel *large, *little, *threshold;

//recent10 cell label
@property (nonatomic, weak) IBOutlet UILabel *date1, *score1, *team1, *result1, *host1;
@property (nonatomic, weak) IBOutlet UILabel *date2, *score2, *team2, *result2, *host2;


@end
