//
//  Server.m
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/16/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import "Server.h"

@implementation Server

- (id)init
{
    self.channels = [[NSMutableArray alloc] init];
    return self;
}

- (id)initWithHost:(NSString*)host
              port:(NSInteger)port
          nickname:(NSString*)nick
          username:(NSString*)username
          realname:(NSString*)realname
{
    if ([self init])
    {
        self.hostName = host;
        self.port = port;
        self.nickname = nick;
        self.username = username;
        self.realname = realname;
    }
    return self;
}

@end
