//
//  CoreDataManager.h
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/21/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedManager;
- (void)saveContext;

@end
