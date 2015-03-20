//
//  SessionManager.m
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/16/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import "SessionManager.h"
#import "Channel.h"
#import "ChannelManager.h"

@implementation SessionManager

- (id)init
{
    self.session = [[IRCClientSession alloc] init];
    self.channels = [[NSMutableDictionary alloc] init];
    self.channelManagers = [[NSMutableDictionary alloc] init];
    
    return self;
}

- (id)initWithServer:(Server *)sessionServer
{
    if ([self init])
    {
        self.server = sessionServer;
        
        self.session.server = sessionServer.hostName;
        self.session.port = [NSString stringWithFormat:@"%ld", (long)sessionServer.port];
        self.session.nickname = sessionServer.nickname;
        self.session.delegate = self;
        self.session.username = sessionServer.username;
        self.session.realname = sessionServer.realname;
    }
    return self;
}

- (void)connect
{
    for (int index = 0; index < [[self.server channels] count]; index++)
    {
        Channel *channel = [[self.server channels] objectAtIndex:index];
        [self.channels setObject:channel forKey:channel.name];
        
        ChannelManager *manager = [[ChannelManager alloc] init];
        [self.channelManagers setObject:manager forKey:channel.name];
    }
    
    [self.session connect];
    [self.session run];
}


#pragma mark - IRCClientSessionDelegate methods

- (void)onConnect {
    
    DLog(@"onConnect");
    
    // Autojoin channels with autoJoin == YES
    for (int index = 0; index < [[self.server channels] count]; index++)
    {
        Channel *channel = [[self.server channels] objectAtIndex:index];
        if (channel.autoJoin == YES)
        {
            [self.session join:channel.name key:channel.key];
        }
    }
    
    [self.delegate connectedToSession];
}

- (void)onNick:(NSString *)nick oldNick:(NSString *)oldNick{
    
    DLog(@"onNick: %@ and %@", nick, oldNick);
    
    [self.delegate textReceived:[NSString stringWithFormat:@"%@ changed nick to: %@", oldNick, nick]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
    
}

- (void)onQuit:(NSString *)nick reason:(NSString *)reason{
    
    DLog(@"onQuit: %@", reason);
    
    [self.delegate textReceived:[NSString stringWithFormat:@"%@ quit with reason: %@", nick, reason]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
    
}

- (void)onJoinChannel:(IRCClientChannel *)channel{
    
    DLog(@"onJoinChannel: %@", channel.name);
    
    channel.session = self.session;
    
    ChannelManager *manager = [self.channelManagers objectForKey:channel.name];
    manager.channel = channel;
    manager.delegate = self.delegate;
    channel.delegate = manager;
    
    [self.delegate textReceived:[NSString stringWithFormat:@"Joined channel: %@", channel.name]
                    fromManager:self
                       fromNick:nil
                         onDate:[NSDate date]];
    
}

- (void)onMode:(NSString *)mode{
    
    DLog(@"onMode %@", mode);
    
    
}
- (void)onPrivmsg:(NSData *)message nick:(NSString *)nick{
    
    DLog(@"onPrivmsg, message: %@, nick: %@",  [[NSString alloc] initWithData:message encoding:NSUTF8StringEncoding], nick);
    
    ChannelManager *privManager = [self.channelManagers objectForKey:nick];
    if (privManager == nil)
    {
        privManager = [[ChannelManager alloc] init];
        privManager.delegate = self.delegate;
        privManager.isPrivateMessage = YES;
        privManager.channel = [[IRCClientChannel alloc] init];
        privManager.channel.session = self.session;
        
        NSRange foundIndex = [nick rangeOfString:@"!"];
        privManager.channel.name = [nick substringToIndex:foundIndex.location];
        [self.channelManagers setObject:privManager forKey:privManager.channel.name];
        [self.delegate dataUpdated];
    }
    
    [self.delegate textReceived:[[NSString alloc] initWithData:message encoding:NSUTF8StringEncoding]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
    
}
- (void)onNotice:(NSData *)notice nick:(NSString *)nick{
    
    DLog(@"onNotice, notice: %@, nick: %@",  [[NSString alloc] initWithData:notice encoding:NSUTF8StringEncoding], nick);
    
    [self.delegate textReceived:[[NSString alloc] initWithData:notice encoding:NSUTF8StringEncoding]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
    
}
- (void)onInvite:(NSString *)channel nick:(NSString *)nick{
    
    DLog(@"onInvite, channel: %@, nick: %@", channel, nick);
    
    [self.delegate textReceived:[NSString stringWithFormat:@"%@ invited you to channel: %@", nick, channel]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
    
}

- (void)onCtcpRequest:(NSString *)request type:(NSString *)type nick:(NSString *)nick{
    
    DLog(@"onCtcpRequest, request: %@, type: %@, nick: %@", request, type, nick);
    
}

- (void)onCtcpReply:(NSData *)reply nick:(NSString *)nick{
    
    DLog(@"onCtcpReply, reply: %@, nick: %@", reply, nick);
    
}
- (void)onAction:(NSData *)action nick:(NSString *)nick{
    
    DLog(@"onAction, action: %@, nick: %@", action, nick);
    
    [self.delegate textReceived:[[NSString alloc] initWithData:action encoding:NSUTF8StringEncoding]
                    fromManager:self
                       fromNick:nick
                         onDate:[NSDate date]];
    
    
}
- (void)onUnknownEvent:(NSString *)event origin:(NSString *)origin params:(NSArray *)params{
    
    DLog(@"onUnknownEvent, event: %@, origin: %@, params: %@", event, origin, params);
    
    [self.delegate textReceived:[NSString stringWithFormat:@"%@ | %@: %@ ", origin, event, params]
                    fromManager:self
                       fromNick:nil
                         onDate:[NSDate date]];
    
}

- (void)onNumericEvent:(NSUInteger)event origin:(NSString *)origin params:(NSArray *)params{
    
    DLog(@"onNumericEvent, event: %lu, origin: %@, params: %@", (unsigned long)event, origin, params);

}


@end
