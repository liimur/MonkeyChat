//
//  ServerChannel.h
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/21/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ServerChannel : NSManagedObject

@property (nonatomic, retain) NSNumber * numberOfUsers;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * topic;
@property (nonatomic, retain) NSString * server;

@end
