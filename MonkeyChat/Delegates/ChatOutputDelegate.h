//
//  ChatOutputDelegate.h
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/17/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//


@protocol ChatOutputDelegate

- (void)connectedToSession;
- (void)dataUpdated;
- (void)textReceived:(NSString *)text
         fromManager:(id)manager
            fromNick:(NSString *)nick
              onDate:(NSDate *)date;

@end
