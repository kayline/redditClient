#import "SubredditRepository.h"
#import "PopularSubredditsViewController.h"
#import "HttpRedditClient.h"
#import "Post.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SubredditRepositorySpec)

describe(@"SubredditRepository", ^{
    __block SubredditRepository *repository;
    __block id<RedditAPIClient> redditClient;

    beforeEach(^{
        redditClient = fake_for(@protocol(RedditAPIClient));
        repository = [[SubredditRepository alloc] initWithRedditAPIClient:redditClient];
    });

    context(@"when fetching all popular subreddits", ^{
        __block SubredditFetchCompletionHandler popularSubredditCallBack;

        beforeEach(^{
            redditClient stub_method(@selector(fetchPopularSubredditsWithCallback:)).and_do(^(NSInvocation *invocation) {
                [invocation getArgument:&popularSubredditCallBack atIndex:2];
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
                popularSubredditCallBack(json);
            });

        });

        it(@"invokes the callback with the parsed data", ^{
            __block NSArray *dataReceived;
            PopularSubredditsFetchCompletionHandler dataFetchCompletionHandler = ^(NSArray *data){
                dataReceived = data;
            };
            [repository fetchPopularSubredditsWithCallback:dataFetchCompletionHandler];
            redditClient should have_received(@selector(fetchPopularSubredditsWithCallback:));
            dataReceived should equal(@[@"pics", @"funny", @"news"]);
        });
    });

    context(@"when fetching posts for a subreddit", ^{
        __block void(^subredditPostsCallback)(NSDictionary *);

        beforeEach(^{
            redditClient stub_method(@selector(fetchPostsForSubreddit:callback:)).and_do(^(NSInvocation *invocation) {
                [invocation getArgument:&subredditPostsCallback atIndex:3];
                NSDictionary *json = @{
                        @"data": @{
                                @"children": @[
                                        @{
                                                @"data": @{ @"title": @"pics", @"score": @"4000" }
                                        }
                                ]
                        }
                };
                subredditPostsCallback(json);
            });
        });

        it(@"invokes callback with the post data", ^{
            __block NSArray *dataReceived;
            __block void(^postFetchCompletionHandler)(NSArray *) = ^(NSArray *data){
                dataReceived = data;
            };

            [repository fetchPostsForSubreddit:@"pics" callback:postFetchCompletionHandler];

            ((Post *)dataReceived[0]).title should equal(@"pics");
            ((Post *)dataReceived[0]).score should equal(4000);
        });
        
    });
    
});

SPEC_END
