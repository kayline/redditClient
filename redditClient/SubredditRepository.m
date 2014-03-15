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

- (void)fetchPopularSubredditsWithCallback:(PopularSubredditsFetchCompletionHandler)popularSubredditsFetchCompletionHandler
{
    SubredditFetchCompletionHandler subredditFetchCallback = ^void(NSDictionary *json) {
        NSMutableArray *popularSubreddits = [[NSMutableArray alloc] init];
        NSArray *redditList = [[json objectForKey:@"data"] objectForKey:@"children"];

        for(NSDictionary *item in redditList) {
            [popularSubreddits addObject:[[item objectForKey:@"data"] objectForKey:@"display_name"]];
        }
        popularSubredditsFetchCompletionHandler(popularSubreddits);
    };

    [self.redditAPIClient fetchPopularSubredditsWithCallback:subredditFetchCallback];
}

- (void)fetchPostsForSubreddit:(NSString *)subreddit callback:(PostsFetchCompletionHandler)postsFetchCompletionHandler
{
    JSONPostsFetchCompletionHandler JSONPostsFetchCallback = ^void(NSDictionary *json) {
        NSMutableArray *subredditPosts = [[NSMutableArray alloc] init];
        NSArray *postList = [[json objectForKey:@"data"] objectForKey:@"children"];

        for(NSDictionary *post in postList) {
            NSString *title = [[post objectForKey:@"data"] objectForKey:@"title"];
            NSString *score = [[post objectForKey:@"data"] objectForKey:@"score"];
            NSInteger score_value = [score integerValue];
            Post *post = [[Post alloc] initWithTitle:title score:score_value identifier:nil ];
            [subredditPosts addObject:post];
        }
        postsFetchCompletionHandler(subredditPosts);
    };

    [self.redditAPIClient fetchPostsForSubreddit:subreddit callback:JSONPostsFetchCallback];
}

- (void)fetchCommentsForPostIdentifier:(NSString *)postIdentifier
{

}


@end