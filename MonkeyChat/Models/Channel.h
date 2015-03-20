//
//  Channel.h
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/16/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *key;
@property bool autoJoin;

-(id)init;

/**
 *  Inits the Channel using channel name and optional key
 *
 *  @param channelName Name of the Channel
 *  @param channelKey  Optional key
 *
 *  @return returns instance of iteself
 */
-(id)initWithChannelName:(NSString*)channelName
                     key:(NSString*)channelKey;

@end
