#import "PopularSubredditsViewController.h"
#import "HttpRedditClient.h"
#import "SubredditRepositoryProvider.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(PopularSubredditsViewControllerSpec)

describe(@"PopularSubredditViewController", ^{
    __block PopularSubredditsViewController *controller;
    __block SubredditRepositoryProvider *fakeSubredditRepositoryProvider;
    __block SubredditRepository *fakeSubredditRepository;
    __block DataFetchCompletionHandler callback;

    UITableViewCell *(^cellAtRow)(NSUInteger) = ^(NSUInteger row){
        return [controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    };

    beforeEach(^{
        fakeSubredditRepository = fake_for([SubredditRepository class]);
        fakeSubredditRepository stub_method(@selector(fetchPopularSubredditsWithCallback:)).and_do(^(NSInvocation *invocation) {
            [invocation getArgument:&callback atIndex:2];
        });

        fakeSubredditRepositoryProvider = fake_for([SubredditRepositoryProvider class]);
        fakeSubredditRepositoryProvider stub_method(@selector(get)).and_return(fakeSubredditRepository);

        controller = [[PopularSubredditsViewController alloc] initWithSubredditRepositoryProvider:fakeSubredditRepositoryProvider];
        controller.view should_not be_nil;
        [controller.tableView layoutIfNeeded];
    });

    it(@"uses the subreddit repository to fetch popular subreddits", ^{
        fakeSubredditRepository should have_received(@selector(fetchPopularSubredditsWithCallback:));
    });

    it(@"displays the list of popular subreddits", ^{
        callback(@[@"pics"]);
        cellAtRow(0).textLabel.text should equal(@"pics");
    });

    it(@"displays the right number of rows", ^{
        callback(@[@"one", @"two", @"three"]);
        [controller.tableView numberOfRowsInSection:0] should equal(3);
    });
});

SPEC_END
