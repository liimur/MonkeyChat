//
//  ViewController.m
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/15/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#define HOST_NAME                      @"irc.dal.net"
#define HOST_PORT                      6667
#define SESSION_NICKNAME               @"BubblesTheChimp"
#define SESSION_USERNAME               @"bubbles_the_chimp"
#define SESSION_REALNAME               @"Bubbles the Chimp"
#define DEFAULT_CHANNEL_NAME           @"#monkeychat"

#import "ViewController.h"
#import "Server.h"
#import "Channel.h"
#import "SessionManager.h"
#import "ChannelManager.h"
#import "ChatOutputDelegate.h"

@interface ViewController () <ChatOutputDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *chatTextView;
@property (weak, nonatomic) IBOutlet UITextField *chatTextEntry;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@property (strong, nonatomic) NSDateFormatter *formatter;

@property (strong, nonatomic) SessionManager *sessionManager;

@end

@implementation ViewController

- (IBAction)connectButtonPressed:(id)sender
{
    [self startIRCSession];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [self.formatter setDateFormat:@"hh:mm a"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startIRCSession
{
    
    [self.activityIndicator startAnimating];
    [self.connectButton setTitle:@"Connecting.." forState:UIControlStateNormal];
    
    Server *server = [[Server alloc] initWithHost:HOST_NAME
                                             port:HOST_PORT
                                         nickname:SESSION_NICKNAME
                                         username:SESSION_USERNAME
                                         realname:SESSION_REALNAME];
    
    self.sessionManager = [[SessionManager alloc] initWithServer:server];
    
    self.sessionManager.delegate = self;
    
    Channel *channel = [[Channel alloc] initWithChannelName:DEFAULT_CHANNEL_NAME key:@""];
    channel.autoJoin = YES;
    
    [[server channels] addObject:channel];
    
    [self.sessionManager connect];
}

#pragma mark - Helper methods
- (void)updateChatWindow:(NSString *)text withNick:(NSString *)nick withDate:(NSDate *)date
{
    if (nick == nil){
        self.chatTextView.text = [NSString stringWithFormat:@"%@\r%@ %@ ", self.chatTextView.text, [self.formatter stringFromDate:date], text];
    } else {
        self.chatTextView.text = [NSString stringWithFormat:@"%@\r%@ %@: %@", self.chatTextView.text, [self.formatter stringFromDate:date], nick, text];
    }
    
    [self.chatTextView scrollRangeToVisible:NSMakeRange([self.chatTextView.text length]-1, 1)];
}

- (void)updateChatWindow:(NSString *)text withDate:(NSDate *)date
{
    [self updateChatWindow:text withNick:nil withDate:date];
}

#pragma mark - ChatOutputDelegate methods

- (void)connectedToSession
{
    [self.activityIndicator stopAnimating];
    [self.connectButton setTitle:@"Connected" forState:UIControlStateNormal];
    self.chatTextEntry.userInteractionEnabled = YES;
}

- (void)dataUpdated
{
    DLog(@"Data updated");
}

- (void)textReceived:(NSString *)text
         fromManager:(id)manager
            fromNick:(NSString *)nick
              onDate:(NSDate *)date
{
    NSString *cleanNick = nick;
    if ([nick length] > 0)
    {
        NSRange range = [nick rangeOfString:@"!"];
        if (range.location != NSNotFound)
        {
            cleanNick = [NSString stringWithFormat:@"<%@>", [nick substringToIndex:range.location]];
        }
        else
        {
            cleanNick = [NSString stringWithFormat:@"<%@>", nick];
        }
    }

    [self updateChatWindow:text withNick:cleanNick withDate:date];
}

#pragma mark - UITextView delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    ChannelManager *channelManager = [self.sessionManager.channelManagers objectForKey:DEFAULT_CHANNEL_NAME];
    
    NSString *text = [textField text];
    [channelManager sendText:text];
    
    textField.text = @"";
    
    [textField resignFirstResponder];
    return NO;
}

@end
