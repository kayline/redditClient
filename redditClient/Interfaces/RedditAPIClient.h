#import <Foundation/Foundation.h>

typedef void (^SubredditFetchCompletionHandler)(NSDictionary *);
typedef void (^JSONPostsFetchCompletionHandler)(NSDictionary *);

@protocol RedditAPIClient <NSObject>
- (void)fetchPopularSubredditsWithCallback:(SubredditFetchCompletionHandler)callback;
- (void)fetchPostsForSubreddit:(NSString *)subreddit callback:(JSONPostsFetchCompletionHandler)callback;
@end