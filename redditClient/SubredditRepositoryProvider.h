#import <Foundation/Foundation.h>

@protocol DisplayListener;
@class SubredditRepository;
@class RedditAPIClient;


@interface SubredditRepositoryProvider : NSObject
- (SubredditRepositoryProvider *)init;
- (SubredditRepository *)get;
@end