//
//  NetworkEngine.m
//  FakeTwitter
//
//  Created by Julian Hunt on 2017-06-06.
//  Copyright © 2017 Julian Hunt. All rights reserved.
//

#import "NetworkEngine.h"
#import "TweetModel.h"

@implementation NetworkEngine




+ (RLMResults *)getTweetListFromServer
{
    RLMResults * list;
    
    if([self isFirstLaunch]){
        [self createInitialFakeData];
        list = [[TweetModel allObjects] sortedResultsUsingKeyPath:@"postDate" ascending:NO];
    }else{
        // Get new data from server and append to current stored list, or replace current list if we don't care about keeping the old data locally. Would reduce disk space used by app to only store the last list of displayed tweets and replace the old one.
        list = [[TweetModel allObjects] sortedResultsUsingKeyPath:@"postDate" ascending:NO];
    }
    
    return list;
}

+ (void)postTweetToServer: (TweetModel *) tweet
{
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm beginWriteTransaction];
    [realm addObject:tweet];
    [realm commitWriteTransaction];
}

+ (BOOL)authenticateLoginForUser:(NSString *)username withPassword: (NSString *)password
{
    // This is where you would encrypt the username and password before sending it to the server for authentication. Since we don't have a server we are just going to check the strings locally
    
    if([username isEqualToString:@"admin"] && [password isEqualToString:@"admin"]){
        return YES;
    }
    return NO;
}

#pragma mark
#pragma mark - Helper Method

+ (BOOL)isFirstLaunch
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    return NO;
}

+ (void)createInitialFakeData
{
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm beginWriteTransaction];
    for(NSInteger i = 0; i < 20; i++){
        [TweetModel createInRealm:realm withValue:@[@"RandomPerson", @"@random_person",@"This is a boring tweet.",[NSDate date]]];
    }
    [realm commitWriteTransaction];
}



@end
