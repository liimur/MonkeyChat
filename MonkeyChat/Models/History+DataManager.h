//
//  History+DataManager.h
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/21/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import "History.h"

@interface History (DataManager)

+ (History *)new;

- (void)saveWithChannel:(NSString *)channel
                message:(NSString *)message
                   time:(NSDate *)time
               nickname:(NSString *)nickname
                 server:(NSString *)server;
@end
