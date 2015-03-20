//
//  Channel.m
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/16/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import "Channel.h"

@implementation Channel

-(id)init
{
    return self;
}

-(id)initWithChannelName:(NSString*)channelName key:(NSString*)channelKey
{
    self.name = channelName;
    self.key = channelKey;
    return self;
}

@end
