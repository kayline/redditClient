#import <Foundation/Foundation.h>
#import "RedditAPIClient.h"

@interface HttpRedditClient : NSObject<RedditAPIClient>
- (void)fetchPopularSubredditsWithCallback:(SubredditFetchCompletionHandler)callback;
@end
