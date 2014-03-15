#import "HttpRedditClient.h"
#import "CedarAsync.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(HttpRedditClientSpec)

describe(@"HttpRedditClient", ^{
    __block HttpRedditClient *httpRedditClient;
    __block NSDictionary *receivedData;
    __block SubredditFetchCompletionHandler subredditFetchCompletionBlock;
    __block JSONPostsFetchCompletionHandler jsonPostsFetchCompletionBlock;

    beforeEach(^{
        httpRedditClient = [[HttpRedditClient alloc] init];
    });

    it(@"gets the popular reddits in JSON form", ^{
        subredditFetchCompletionBlock = ^(NSDictionary *jsonData) {
            receivedData = [[[[jsonData objectForKey:@"data"] objectForKey:@"children"][0] objectForKey:@"data"] objectForKey:@"display_name"];
        };
        [httpRedditClient fetchPopularSubredditsWithCallback:subredditFetchCompletionBlock];
        in_time(receivedData) should_not be_nil;
    });

    it(@"gets the subreddit posts in JSON form", ^{
        jsonPostsFetchCompletionBlock = ^(NSDictionary *jsonData) {
            receivedData = [[[[jsonData objectForKey:@"data"] objectForKey:@"children"][0] objectForKey:@"data"] objectForKey:@"score"];
        };
        [httpRedditClient fetchPostsForSubreddit:@"pics" callback:jsonPostsFetchCompletionBlock];
        in_time(receivedData) should_not be_nil;
    });
});

SPEC_END
