//
//  TweetModel.h
//  FakeTwitter
//
//  Created by Julian Hunt on 2017-06-04.
//  Copyright © 2017 Julian Hunt. All rights reserved.
//

#import <Realm/Realm.h>

@interface TweetModel : RLMObject



@property NSString *account;
@property NSString *handle;
@property NSString *tweetContent;
@property NSDate *postDate;


@end

// This protocol enables typed collections. i.e.:
// RLMArray<TweetModel *><TweetModel>
RLM_ARRAY_TYPE(TweetModel)
