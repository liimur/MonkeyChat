//
//  ChannelManager.h
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/17/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatOutputDelegate.h"

#import <IRCClient/IRCClientChannel.h>

@interface ChannelManager : NSObject

@property (nonatomic, strong) IRCClientChannel *channel;
@property (nonatomic, strong) id<ChatOutputDelegate> delegate;
@property bool isPrivateMessage;

- (id)init;
- (id)initWithChannel:(IRCClientChannel *)channel;
- (void)sendText:(NSString *)text;

#pragma mark - IRCClientChannelDelegate methods

/** When a client joins this channel, the onJoin event is fired. Note that
 *  the nickname is most likely in nick!user\@host format, but may simply be a
 *  nickname, depending on the server implementation.
 *
 *  You should also expect to see this event when the client first joins a channel,
 *	with a parameter of the client's nickname.
 *
 *  @param nick The nickname of the user that joined the channel.
 */

- (void)onJoin:(NSString *)nick;

/** When an IRC client parts a channel you are connect to, you will see
 *  an onPart event. You will also see this event when you part a channel.
 *
 *  @param nick (required) The nickname of the user that left the channel.
 *  @param reason (optional) The reason, if any, that the user gave for leaving.
 */

- (void)onPart:(NSString *)nick reason:(NSString *)reason;

/** Received when an IRC client changes the channel mode. What modes are available
 *  for a given channel is an implementation detail for each server.
 *
 *  @param mode the new channel mode.
 *  @param params any parameters with the mode (such as channel key).
 *  @param nick the nickname of the IRC client that changed the mode.
 */

- (void)onMode:(NSString *)mode params:(NSString *)params nick:(NSString *)nick;

/** Received when the topic is changed for the channel.
 *
 *  @param aTopic The new topic of the channel.
 *  @param nick Nickname of the IRC client that changed the topic.
 */

- (void)onTopic:(NSString *)aTopic nick:(NSString *)nick;

/** Received when an IRC client is kicked from a channel.
 *
 *  @param nick nickname of the client that was kicked
 *  @param reason reason message given for the kick
 *  @param byNick nickname of the client that performed the kick command
 */

- (void)onKick:(NSString *)nick reason:(NSString *)reason byNick:(NSString *)byNick;

/** Received when an IRC client sends a public PRIVMSG to the channel. Note that the
 *  user may not necessarily be required to be on the channel to send a message
 *	to it.
 *
 *  @param message the message sent to the channel.
 *  @param nick the nickname of the IRC client that sent the message.
 */

- (void)onPrivmsg:(NSString *)message nick:(NSString *)nick;

/** Received when an IRC client sends a public NOTICE to the channel. Note that
 *	the user may not necessarily be required to be on the channel to send a notice to
 *	it. Furthermore, the RFC states that the only difference between PRIVMSG and
 *  NOTICE is that a NOTICE may never be responded to automatically.
 *
 *  @param notice the notice sent to the channel.
 *  @param nick the nickname of the IRC client that sent the notice.
 */

- (void)onNotice:(NSString *)notice nick:(NSString *)nick;

/** Received when an IRC client sends a CTCP ACTION message to the channel.
 *  used by lamers with no life to pretend that they are playing some form of
 *  MMORPG.
 *
 *  @param action the action message sent to the channel.
 *  @param nick the nickname of the IRC client that sent the message.
 */

- (void)onAction:(NSString *)action nick:(NSString *)nick;


@end
