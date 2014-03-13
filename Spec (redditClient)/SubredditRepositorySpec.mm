#import "SubredditRepository.h"
#import "PopularSubredditsViewController.h"
#import "HttpRedditClient.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SubredditRepositorySpec)

describe(@"SubredditRepository", ^{
    __block SubredditRepository *repository;
    __block id<RedditAPIClient> redditClient;
    __block SubredditFetchCompletionBlock callback;

    beforeEach(^{
        redditClient = fake_for(@protocol(RedditAPIClient));
        redditClient stub_method(@selector(fetchPopularSubredditsWithCallback:)).and_do(^(NSInvocation *invocation) {
            [invocation getArgument:&callback atIndex:2];
            NSDictionary *json = @{
                @"data": @{
                    @"children": @[
                        @{
                            @"data": @{ @"display_name": @"pics" }
                        },
                        @{
                            @"data": @{ @"display_name": @"funny" }
                        },
                        @{
                            @"data": @{ @"display_name": @"news" }
                        }
                    ]
                }
            };
            callback(json);
        });

        repository = [[SubredditRepository alloc] initWithRedditAPIClient:redditClient];
    });

    it(@"invokes the callback with the parsed data", ^{
        __block NSArray *dataReceived;
        DataFetchCompletionHandler callback = ^(NSArray *data){
          dataReceived = data;
        };
        [repository fetchPopularSubredditsWithCallback:callback];
        redditClient should have_received(@selector(fetchPopularSubredditsWithCallback:));
        dataReceived should equal(@[@"pics", @"funny", @"news"]);
    });
});

SPEC_END
