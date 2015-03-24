//
//  AppDelegate.h
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/15/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#define SESSION_HOST_NAME                       @"irc.dal.net"
#define SESSION_HOST_PORT                       6667
#define SESSION_NICKNAME                        @"BubblesTheChimp"
#define SESSION_USERNAME                        @"bubbles_the_chimp"
#define SESSION_REALNAME                        @"Bubbles the Chimp"
#define DEFAULT_CHANNEL_NAME                    @"#monkeychat"

#import <UIKit/UIKit.h>

#import "SessionManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SessionManager *sessionManager;

@end

