//
//  ChannelCell.m
//  MonkeyChat
//
//  Created by Elvin Rakhmankulov on 3/21/15.
//  Copyright (c) 2015 Elvin Rakhmankulov. All rights reserved.
//

#import "ChannelCell.h"

@interface ChannelCell()
@property (weak, nonatomic) IBOutlet UILabel *channelOrNickName;

@property (weak, nonatomic) IBOutlet UILabel *numberOfPeople;
@property (weak, nonatomic) IBOutlet UILabel *numberOfMessages;


@end

@implementation ChannelCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end