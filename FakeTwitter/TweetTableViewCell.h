//
//  TweetTableViewCell.h
//  FakeTwitter
//
//  Created by Julian Hunt on 2017-06-03.
//  Copyright © 2017 Julian Hunt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *accountName;
@property (weak, nonatomic) IBOutlet UILabel *accountHandle;
@property (weak, nonatomic) IBOutlet UITextView *tweetContent;

@end
