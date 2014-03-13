#import "SubredditRepository.h"
#import "PopularSubredditsViewController.h"
#import "HttpRedditClient.h"

@interface SubredditRepository ()
@property(nonatomic, strong) id<RedditAPIClient> redditAPIClient;
@end

@implementation SubredditRepository

- (instancetype)initWithRedditAPIClient:(id <RedditAPIClient>)client {
    self = [super init];
    
    if (self) {
        self.redditAPIClient = client;
    }
    return self;
}

- (void)fetchPopularSubredditsWithCallback:(DataFetchCompletionHandler)callback
{
    SubredditFetchCompletionBlock subredditFetchCallback = ^void(NSDictionary *json) {
        NSMutableArray *popularSubreddits = [[NSMutableArray alloc] init];
        NSArray *redditList = [[json objectForKey:@"data"] objectForKey:@"children"];

        for(NSDictionary *item in redditList) {
            [popularSubreddits addObject:[[item objectForKey:@"data"] objectForKey:@"display_name"]];
        }
        callback(popularSubreddits);
    };

    [self.redditAPIClient fetchPopularSubredditsWithCallback:subredditFetchCallback];
}

@end