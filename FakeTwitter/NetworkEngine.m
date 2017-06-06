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




- (NSMutableArray *)getTweetListFromServer
{
    NSMutableArray * list;
    
    if([self isFirstLaunch]){
        list = [self createInitialFakeData];
    }else{
        // Get new data from server and append to current stored list, or replace current list if we don't care about keeping the old data locally. Would reduce disk space used by app to only store the last list of displayed tweets and replace the old one.
    }
    
    return list;
}

- (void)postTweetToServer: (TweetModel *) tweet
{
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm beginWriteTransaction];
    [realm addObject:tweet];
    [realm commitWriteTransaction];
}

- (BOOL)authenticateLoginForUser:(NSString *)username withPassword: (NSString *)password
{
    // This is where you would encrypt the username and password before sending it to the server for authentication. Since we don't have a server we are just going to check the strings locally
    
    if([username isEqualToString:@"admin"] && [password isEqualToString:@"admin"]){
        return YES;
    }
    return NO;
}

#pragma mark
#pragma mark - Helper Method

- (BOOL)isFirstLaunch
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    return NO;
}

- (NSMutableArray *)createInitialFakeData
{
    NSMutableArray * initialData;
    
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm beginWriteTransaction];
    for(NSInteger i = 0; i < 20; i++){
        [initialData addObject:[TweetModel createInRealm:realm withValue:@[@"RandomPerson", @"random_person",@"This is a boring tweet.",[NSDate date]]]];
    }
    [realm commitWriteTransaction];
    return initialData;
}



@end
