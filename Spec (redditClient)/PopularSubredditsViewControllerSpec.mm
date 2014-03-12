#import "PopularSubredditsViewController.h"
#import "HttpRedditClient.h"
#import "SubredditRepository.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(PopularSubredditsViewControllerSpec)

describe(@"PopularSubredditViewController", ^{
    __block PopularSubredditsViewController *controller;
    __block SubredditRepository *fakeSubredditRepository;

    beforeEach(^{
        fakeSubredditRepository = fake_for([SubredditRepository class]);
        fakeSubredditRepository stub_method(@selector(fetchPopularSubreddits));
        fakeSubredditRepository stub_method(@selector(setDelegate:));
        controller = [[[PopularSubredditsViewController alloc] initWithSubredditRepository:fakeSubredditRepository] autorelease];
        controller.view should_not be_nil;
        [controller.tableView layoutIfNeeded];
    });

    UITableViewCell *(^cellAtRow)(NSUInteger) = ^(NSUInteger row){
        return [controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    };

    it(@"should display 5 popular subreddits", ^{
        [controller.tableView numberOfRowsInSection:0] should equal(5);
    });

    it(@"should ask the subreddit repository to fetch popular subreddits", ^{
        fakeSubredditRepository should have_received(@selector(fetchPopularSubreddits));
    });

    it(@"should display a list of popular subreddits", ^{
        cellAtRow(0).textLabel.text should equal(@"pics");
        cellAtRow(1).textLabel.text should equal(@"funny");
    });
});

SPEC_END
