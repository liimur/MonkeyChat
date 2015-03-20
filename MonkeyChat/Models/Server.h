//
//  Server.h
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/16/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Server : NSObject

@property (strong, nonatomic) NSString *hostName;
@property NSInteger port;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *realname;
@property (strong, nonatomic) NSMutableArray *channels;
@property bool autoConnect;

- (id)init;
- (id)initWithHost:(NSString*)host
              port:(NSInteger)port
          nickname:(NSString*)nick
          username:(NSString*)username
          realname:(NSString*)realname;

@end
