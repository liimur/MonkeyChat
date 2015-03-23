//
//  SessionInitTest.m
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/22/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "AppDelegate.h"
#import "Server.h"
#import "SessionManager.h"
#import "Channel.h"

@interface SessionInitTest : XCTestCase

@end

@implementation SessionInitTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitServer
{
    Server *server = [[Server alloc] initWithHost:SESSION_HOST_NAME
                                             port:SESSION_HOST_PORT
                                         nickname:SESSION_NICKNAME
                                         username:SESSION_USERNAME
                                         realname:SESSION_REALNAME];
    
    XCTAssertEqual(server.hostName, SESSION_HOST_NAME);
    XCTAssertEqual(server.port, SESSION_HOST_PORT);
    XCTAssertEqual(server.nickname, SESSION_NICKNAME);
    XCTAssertEqual(server.username, SESSION_USERNAME);
    XCTAssertEqual(server.realname, SESSION_REALNAME);
    
    SessionManager *sessionManager = [[SessionManager alloc] initWithServer:server];
    
    NSString *testChannelName = @"channelone";
    Channel *channel = [[Channel alloc] initWithChannelName:testChannelName key:@""];
    channel.autoJoin = YES;
    
    [[server channels] addObject:channel];
    
    XCTAssertEqual([[sessionManager.server.channels objectAtIndex:0] valueForKey:@"name"], testChannelName);
}

@end
