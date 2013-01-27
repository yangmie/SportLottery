//
//  Connector.h
//  TestPTT
//
//  Created by 倪 嘉懋 on 12/3/1.
//  Copyright (c) 2012年 woptspencil@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RecommendHost @"http://anchor.csie.org/~woptspencil/SportLottery.php"
#define UserName @"SportLottery"
#define Password @"MIAOLI"
/*
#define RecommendHost @"http://anchor.csie.org/~woptspencil/ios3.php"
#define UserName @"news-recommender"
#define Password @"MESSIRULES"
*/

@interface Connector : NSObject
{
	NSMutableURLRequest *request;
}


//+ (BOOL)login;
+ (NSString *)userId;
//- (id)initForRegister;
- (id)initWithCommand:(NSString *)command
			 andParam:(NSMutableDictionary *)param;
- (NSData *)connect;

@end
