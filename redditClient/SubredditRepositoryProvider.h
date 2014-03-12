//
// Created by pivotal on 3/11/14.
// Copyright (c) 2014 pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SubredditRepository;


@interface SubredditRepositoryProvider : NSObject
- (SubredditRepository *)get;
- (SubredditRepositoryProvider *)initWithRedditAPIClient:(RedditAPIClient *)redditAPIClient;
@end