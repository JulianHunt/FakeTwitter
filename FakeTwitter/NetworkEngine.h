//
//  NetworkEngine.h
//  FakeTwitter
//
//  Created by Julian Hunt on 2017-06-06.
//  Copyright © 2017 Julian Hunt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "TweetModel.h"

@interface NetworkEngine : NSObject

/**
 Retrieves the list of tweets to display from the server
 Note: This actually just makes fake data as there is no server to connect too
 
 @return The list of tweets retrieved from the server.
 */
+ (RLMResults *)getTweetListFromServer;

/**
 Authenticates user login

 @param username NSString* of the users login username
 @param password NSString* of the users login password

 @return if the combination of username and password are valid login credentials
 */
+ (BOOL)authenticateLoginForUser:(NSString *)username withPassword: (NSString *)password;


/**
 Posts a created tweet to the server

 @param tweet The TweetModel representing the tweet to be posted
 */
+ (void)postTweetToServer: (TweetModel *) tweet;

@end
