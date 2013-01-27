//
//  BasketballCell.m
//  SportLottery
//
//  Created by Yu-Chung, Yang on 12/12/24.
//  Copyright (c) 2012年 Yu-Chung, Yang. All rights reserved.
//

#import "BasketballCell.h"

@implementation BasketballCell

@synthesize sportName = _sportName;

@synthesize teamName1 = _teamName1, teamName2 = _teamName2;
@synthesize pk1 = _pk1, pk2 = _pk2;
@synthesize odds1 = _odds1, odds2 = _odds2;
@synthesize gid = _gid, odds = _odds, pk = _pk, over = _over;
@synthesize away_score = _away_score, home_score = _home_score, gameStatus = _gameStatus;
@synthesize lotteryDate = _lotteryDate;

@synthesize home = _home, away = _away, tie = _tie;
@synthesize large = _large, little = _little, threshold = _threshold;

@synthesize date1 = _date1, team1 = _team1, result1 = _result1, score1 = _score1, host1 = _host1;
@synthesize date2 = _date2, team2 = _team2, result2 = _result2, score2 = _score2, host2 = _host2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
