//
//  ServerChannel+DataManager.h
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/21/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import "ServerChannel.h"

@interface ServerChannel (DataManager)

+ (ServerChannel *)new;

- (void)addWithName:(NSString *)name
       numberOfUsers:(int)numberOfUsers
               topic:(NSString *)topic
              server:(NSString *)server;

@end
