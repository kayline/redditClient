#import "PopularSubredditsViewController.h"
#import "HttpRedditClient.h"
#import "SubredditRepositoryProvider.h"
#import "UITableViewCell+Spec.h"
#import "SubredditViewController.h"

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

        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];

        UIWindow *window = [[UIWindow alloc] init];
        window.rootViewController = navController;

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

    context(@"when a subreddit cell is tapped", ^{
        beforeEach(^{
            callback(@[@"pics"]);
            UITableViewCell *cell = cellAtRow(0);
            [cell tap];
        });

        it(@"should show hot posts for the subreddit", ^{
            [controller.navigationController topViewController] should be_instance_of([SubredditViewController class]);
        });
    });

    it(@"-viewDidLoad should deselect any selected rows", ^{
        callback(@[@"pics"]);
        UITableViewCell *cell = cellAtRow(0);
        [cell tap];
        [cell isSelected] should be_truthy;
        [controller viewWillAppear:NO];

        [controller.tableView indexPathForSelectedRow] should be_nil ;
    });
});

SPEC_END
