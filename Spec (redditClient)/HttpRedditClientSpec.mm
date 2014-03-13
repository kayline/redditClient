#import "HttpRedditClient.h"
#import "CedarAsync.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(HttpRedditClientSpec)

describe(@"HttpRedditClient", ^{
    __block HttpRedditClient *httpRedditClient;
    __block NSDictionary *receivedData;
    __block SubredditFetchCompletionBlock callback;

    it(@"gets the popular reddits in JSON form", ^{
        httpRedditClient = [[HttpRedditClient alloc] init];
        callback = ^(NSDictionary *jsonData) {
            receivedData = [[[[jsonData objectForKey:@"data"] objectForKey:@"children"][0] objectForKey:@"data"] objectForKey:@"display_name"];
        };
        [httpRedditClient fetchPopularSubredditsWithCallback:callback];
        in_time(receivedData) should_not be_nil;
    });
});

SPEC_END
