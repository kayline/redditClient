#import <Foundation/Foundation.h>

typedef void (^PopularSubredditsFetchCompletionHandler)(NSArray *);
typedef void (^PostsFetchCompletionHandler)(NSArray *);
@protocol RedditAPIClient;
@class Post;

@interface SubredditRepository : NSObject

- (instancetype)initWithRedditAPIClient:(id <RedditAPIClient>)client;
- (void)fetchPopularSubredditsWithCallback:(PopularSubredditsFetchCompletionHandler)popularSubredditsFetchCompletionHandler;
- (void)fetchPostsForSubreddit:(NSString *)subreddit callback:(PostsFetchCompletionHandler)postsFetchCompletionHandler;
- (void)fetchCommentsForPostIdentifier:(NSString *)postIdentifier;
@end