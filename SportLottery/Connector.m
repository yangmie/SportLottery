//
//  Connector.m
//  TestPTT
//
//  Created by 倪 嘉懋 on 12/3/1.
//  Copyright (c) 2012年 woptspencil@gmail.com. All rights reserved.
//

#import "Connector.h"

#define UserIdKey	@"UserIdForSportLottery"

@implementation Connector

static NSString *_userId;

/*
+ (BOOL)login
{
	_userId = [[NSUserDefaults standardUserDefaults] stringForKey:UserIdKey];
	
	if (_userId)
	{
		Connector *connector = [[Connector alloc] initWithCommand:@"LOGIN"
														 andParam:nil];
		[connector connect];
	}
	else
	{
		Connector *connector = [[Connector alloc] initForRegister];
		_userId = [connector connect];
		if (_userId == nil) return NO;
		if ([_userId isEqualToString:@"FAILED"]) return NO;
		[[NSUserDefaults standardUserDefaults] setObject:_userId forKey:UserIdKey];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	return YES;
}
 
- (id)initForRegister
{
	if (self = [super init]) {
		// Set connection string
		NSString *string = [[NSString alloc]
							initWithFormat:@"username=%@&password=%@&req=REGISTER",
							UserName, Password];
        
		// Transform to string
        NSMutableString *httpBodyString = [[NSMutableString alloc]
										   initWithString:string];
		// HTTP request
        request = [[NSMutableURLRequest alloc] init];
		NSURL *connection = [[NSURL alloc] initWithString:RecommendHost];
        [request setURL:connection];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
	}
	return self;
}
*/


+ (NSString *)userId
{
	return _userId;
}

- (id)initWithCommand:(NSString *)command
			 andParam:(NSMutableDictionary *)param
{
	if (self = [super init]) {
		// Set connection string
		NSString *string = [[NSString alloc] 
							initWithFormat:@"username=%@&password=%@&req=%@&userId=UserIdForSportLottery",
							UserName, Password, command];
        
		// Add other parameter
		for (NSString *key in param) {
			string = [string stringByAppendingFormat:@"&%@=%@",
					  key, [param objectForKey:key]];
		}
		
		// Transform to string
        NSMutableString *httpBodyString = [[NSMutableString alloc]
										   initWithString:string];
		// HTTP request
        request = [[NSMutableURLRequest alloc] init];
		NSURL *connection = [[NSURL alloc] initWithString:RecommendHost];
        [request setURL:connection];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
	}
	return self;
}


- (NSData *)connect {
	NSError *error;
	NSData *response = [NSURLConnection sendSynchronousRequest:request
											 returningResponse:nil
														 error:&error];
	if (error)
	{
		return nil;
	}
	
	return response;
}

@end
