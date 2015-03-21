//
//  ChannelCell.h
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/21/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *channelOrNickName;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPeople;
@property (weak, nonatomic) IBOutlet UILabel *numberOfMessages;
@property (weak, nonatomic) IBOutlet UILabel *topic;

@end
