//
//  ChannelManager.m
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/17/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import "ChannelManager.h"

#import <IRCClient/IRCClientSession.h>

@implementation ChannelManager

- (id)init
{
    return self;
}
- (id)initWithChannel:(IRCClientChannel *)channel
{
    if ([self init])
    {
        self.channel = channel;
    }
    return self;
}

#pragma mark - Send Message
- (void)sendText:(NSString *)text
{
    if (self.isPrivateMessage == NO)
    {
        [self.channel message:text];
        [self.delegate textReceived:text
                        fromManager:self
                           fromNick:self.channel.session.nickname
                              onDate:[NSDate date]];
    }
    else
    {
        [self.channel.session message:text to:self.channel.name];
        [self.delegate textReceived:text
                        fromManager:self
                           fromNick:self.channel.session.nickname
                             onDate:[NSDate date]];
    }
}

#pragma mark - IRCClientChannelDelegate methods

- (void)onJoin:(NSString *)nick
{
    DLog(@"onJoin: %@", nick);
    
    [self.delegate textReceived:[NSString stringWithFormat:@"%@ joined the channel", nick]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
}

- (void)onPart:(NSString *)nick reason:(NSString *)reason
{
    DLog(@"onPart, nick %@, reason: %@", nick, reason);
    
    [self.delegate textReceived:[NSString stringWithFormat:@"%@ parted the channel with reason: %@", nick, reason]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
}

- (void)onMode:(NSString *)mode
        params:(NSString *)params
          nick:(NSString *)nick
{
    DLog(@"onMode, mode: %@, params %@, nick: %@", mode, params, nick);
}

- (void)onTopic:(NSString *)aTopic nick:(NSString *)nick
{
    DLog(@"onTopic, aTopic: %@, nick: %@", aTopic, nick);
    
    [self.delegate textReceived:[NSString stringWithFormat:@"%@ changed topic to: %@", nick, aTopic]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
}

- (void)onKick:(NSString *)nick
        reason:(NSString *)reason
        byNick:(NSString *)byNick
{
    DLog(@"onKick, nick: %@, reason %@, byNick: %@", nick, reason, byNick);
    
    [self.delegate textReceived:[NSString stringWithFormat:@"%@ Kicked %@ from the channel with reason: %@", byNick, nick, reason]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
}

- (void)onPrivmsg:(NSString *)message nick:(NSString *)nick
{
    DLog(@"onPrivmsg, message %@, nick: %@", message, nick);
    
    [self.delegate textReceived:message
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
}

- (void)onNotice:(NSString *)notice nick:(NSString *)nick
{
    DLog(@"onNotice, notice %@, nick: %@", notice, nick);
    
    [self.delegate textReceived:[NSString stringWithFormat:@"%@: %@", nick, notice]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
}

- (void)onAction:(NSString *)action nick:(NSString *)nick
{
    DLog(@"onAction, action %@, nick: %@", action, nick);
    
    [self.delegate textReceived:[NSString stringWithFormat:@"%@: %@", nick, action]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
}



@end
