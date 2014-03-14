#import <Foundation/Foundation.h>

typedef void (^DataFetchCompletionHandler)(NSArray *);
typedef void (^PostsFetchCompletionBlock)(NSArray *);
@protocol RedditAPIClient;

@interface SubredditRepository : NSObject

- (instancetype)initWithRedditAPIClient:(id <RedditAPIClient>)client;
- (void)fetchPopularSubredditsWithCallback:(DataFetchCompletionHandler)callback;
- (void)fetchPostsForSubreddit:(NSString *)subreddit callback:(PostsFetchCompletionBlock)postsFetchCompletionBlock;
@end