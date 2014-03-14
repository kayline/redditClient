#import "SubredditViewController.h"
#import "SubredditRepository.h"
#import "Post.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SubredditViewControllerSpec)

describe(@"SubredditViewController", ^{
    __block SubredditViewController *controller;
    __block SubredditRepository *subredditRepository;
    __block NSString *subreddit;
    __block PostsFetchCompletionBlock callback;

    UITableViewCell *(^cellAtRow)(NSUInteger) = ^(NSUInteger row){
        return [controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    };

    beforeEach(^{
        subredditRepository = fake_for([SubredditRepository class]);
        subredditRepository stub_method(@selector(fetchPostsForSubreddit:callback:)).and_do(^(NSInvocation *invocation) {
            [invocation getArgument:&callback atIndex:3];
        });
        subreddit = @"pics";
        controller = [[SubredditViewController alloc] initWithSubredditRepository:subredditRepository subreddit:subreddit];
        controller.view should_not be_nil;
    });

    it(@"should tell repository to fetch subreddit information on load", ^{
        subredditRepository should have_received(@selector(fetchPostsForSubreddit:callback:)).with(subreddit).and_with(Arguments::anything);
    });

    it(@"should display subreddit post information", ^{
        Post *post = [[Post alloc] initWithTitle:@"The Greatest Title Ever!" Score:4000];
        NSArray *posts = @[post];
        callback(posts);

        cellAtRow(0).textLabel.text should equal(@"The Greatest Title Ever!");
        //cellAtRow(0).score.value should equal(4000);
    });

});

SPEC_END
