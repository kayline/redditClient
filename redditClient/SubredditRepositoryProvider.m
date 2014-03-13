#import "SubredditRepositoryProvider.h"
#import "SubredditRepository.h"
#import "HttpRedditClient.h"

@interface SubredditRepositoryProvider ()
@property(nonatomic, strong) id<RedditAPIClient>redditAPIClient;
@end

@implementation SubredditRepositoryProvider
- (SubredditRepositoryProvider *)init {
    self = [super init];

    if (self) {
        self.redditAPIClient = [[HttpRedditClient alloc] init];
    }

    return self;
}

- (SubredditRepository *)get {
    return [[SubredditRepository alloc] initWithRedditAPIClient:self.redditAPIClient];
}

@end