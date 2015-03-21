//
//  History+DataManager.m
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/21/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import "History+DataManager.h"
#import "CoreDataManager.h"

@implementation History (DataManager)

+ (History *)new
{
    History *newHistoryRecord = [NSEntityDescription
                                         insertNewObjectForEntityForName:@"History"
                                         inManagedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]];
    return newHistoryRecord;
}

- (void)saveWithChannel:(NSString *)channel
                message:(NSString *)message
                   time:(NSDate *)time
               nickname:(NSString *)nickname
                 server:(NSString *)server;
{
    self.channel = channel;
    self.message = message;
    self.time = time;
    self.nickname = nickname;
    self.server = server;
    
    NSError *error;
    [self.managedObjectContext save:&error];
    if (error){
        DLog(@"Error: %@", [error localizedDescription]);
    }
}
@end
