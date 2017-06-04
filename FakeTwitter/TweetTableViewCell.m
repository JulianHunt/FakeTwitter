//
//  TweetTableViewCell.m
//  FakeTwitter
//
//  Created by Julian Hunt on 2017-06-03.
//  Copyright © 2017 Julian Hunt. All rights reserved.
//

#import "TweetTableViewCell.h"

@interface TweetTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *accountName;
@property (weak, nonatomic) IBOutlet UILabel *accountHandle;
@property (weak, nonatomic) IBOutlet UITextView *tweetContent;


@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
