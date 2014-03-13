#import <Foundation/Foundation.h>

typedef void (^SubredditFetchCompletionBlock)(NSDictionary *);

@protocol RedditAPIClient <NSObject>
- (void)fetchPopularSubredditsWithCallback:(SubredditFetchCompletionBlock)callback;
@end