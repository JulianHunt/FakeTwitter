//
//  PostTweetViewController.m
//  FakeTwitter
//
//  Created by Julian Hunt on 2017-06-06.
//  Copyright © 2017 Julian Hunt. All rights reserved.
//

#import "PostTweetViewController.h"
#import "TweetModel.h"
#import "NetworkEngine.h"


@interface PostTweetViewController ()

@end



@implementation PostTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)downSwipe:(id)sender {
    [[self view] endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)postTweetButtonPressed:(id)sender {
    TweetModel * newTweet = [[TweetModel alloc]init];
    newTweet.tweetContent = [_tweetContentTextField text];
    
    // Ideally here we would grab the username and handle that are stored for the current logged in user but I haven't implemented that yet
    newTweet.account = @"Admin";
    newTweet.handle = @"@admin";
    newTweet.postDate = [NSDate date];
    
    [NetworkEngine postTweetToServer:newTweet];
    
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
