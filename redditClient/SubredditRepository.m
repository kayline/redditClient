#import "SubredditRepository.h"
#import "PopularSubredditsViewController.h"
#import "HttpRedditClient.h"
#import "Post.h"

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

- (void)fetchPostsForSubreddit:(NSString *)subreddit callback:(PostsFetchCompletionBlock)postsFetchCompletionBlock
{
    JSONPostsFetchCompletionBlock JSONPostsFetchCallback = ^void(NSDictionary *json) {
        NSMutableArray *subredditPosts = [[NSMutableArray alloc] init];
        NSArray *postList = [[json objectForKey:@"data"] objectForKey:@"children"];

        for(NSDictionary *post in postList) {
            NSString *title = [[post objectForKey:@"data"] objectForKey:@"title"];
            NSString *score = [[post objectForKey:@"data"] objectForKey:@"score"];
            NSInteger score_value = [score integerValue];
            Post *post = [[Post alloc] initWithTitle:title Score:score_value];
            [subredditPosts addObject:post];
        }
        postsFetchCompletionBlock(subredditPosts);
    };

    [self.redditAPIClient fetchPostsForSubreddit:subreddit callback:JSONPostsFetchCallback];
}

@end