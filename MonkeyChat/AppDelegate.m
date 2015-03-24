//
//  AppDelegate.m
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/15/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import "AppDelegate.h"
#import "Server.h"
#import "Channel.h"
#import "SessionManager.h"
#import "ChannelManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self startIRCSession];
    return YES;
}

- (void)startIRCSession
{
    
    Server *server = [[Server alloc] initWithHost:SESSION_HOST_NAME
                                             port:SESSION_HOST_PORT
                                         nickname:SESSION_NICKNAME
                                         username:SESSION_USERNAME
                                         realname:SESSION_REALNAME];
    
    self.sessionManager = [[SessionManager alloc] initWithServer:server];
    
    Channel *channel = [[Channel alloc] initWithChannelName:DEFAULT_CHANNEL_NAME key:@""];
    channel.autoJoin = YES;
    
    [[server channels] addObject:channel];
    
    [self.sessionManager connect];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
