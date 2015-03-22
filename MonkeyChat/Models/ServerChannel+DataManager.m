//
//  ServerChannel+DataManager.m
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/21/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import "ServerChannel+DataManager.h"
#import "CoreDataManager.h"

@implementation ServerChannel (DataManager)

+ (ServerChannel *)new
{
    ServerChannel *newServerChannelObject = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"ServerChannel"
                                 inManagedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]];
    return newServerChannelObject;
}

- (void)addWithName:(NSString *)name
       numberOfUsers:(int)numberOfUsers
               topic:(NSString *)topic
              server:(NSString *)server
{
    self.numberOfUsers = [NSNumber numberWithInt:numberOfUsers];
    self.name = name;
    self.topic = topic;
    self.server = server;
    
//    NSError *error;
//    [self.managedObjectContext save:&error];
//    if (error){
//        DLog(@"Error: %@", [error localizedDescription]);
//    }
}




@end
