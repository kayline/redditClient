#import <Foundation/Foundation.h>

typedef void (^SubredditFetchCompletionBlock)(NSDictionary *);
typedef void (^JSONPostsFetchCompletionBlock)(NSDictionary *);

@protocol RedditAPIClient <NSObject>
- (void)fetchPopularSubredditsWithCallback:(SubredditFetchCompletionBlock)callback;
- (void)fetchPostsForSubreddit:(NSString *)subreddit callback:(JSONPostsFetchCompletionBlock)callback;
@end