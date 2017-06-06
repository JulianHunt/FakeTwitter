//
//  NetworkEngine.h
//  FakeTwitter
//
//  Created by Julian Hunt on 2017-06-06.
//  Copyright © 2017 Julian Hunt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface NetworkEngine : NSObject

// Handle making the network calls to retrieve the list of tweets to display in users feed
-(RLMResults *)getTweetListFromServer;

@end
