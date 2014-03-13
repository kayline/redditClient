#import <Foundation/Foundation.h>

typedef void (^DataFetchCompletionHandler)(NSArray *);

@protocol RedditAPIClient;

@interface SubredditRepository : NSObject

- (instancetype)initWithRedditAPIClient:(id <RedditAPIClient>)client;
- (void)fetchPopularSubredditsWithCallback:(DataFetchCompletionHandler)callback;
@end