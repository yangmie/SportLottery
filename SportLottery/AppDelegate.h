//
//  AppDelegate.h
//  SportLottery
//
//  Created by Yu-Chung, Yang on 12/12/22.
//  Copyright (c) 2012年 Yu-Chung, Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    BOOL networkStatus;
}

- (BOOL) connectedToNetwork;
- (void)updateStatus;
- (void)reachabilityChanged:(NSNotification *)note;

@property (strong, nonatomic) UIWindow *window;
@property BOOL networkStatus;

@end
