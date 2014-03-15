#import "SubredditViewController.h"
#import "SubredditRepository.h"
#import "Post.h"
#import "SubredditPostCell.h"
#import "UITableViewCell+Spec.h"
#import "PostViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SubredditViewControllerSpec)

describe(@"SubredditViewController", ^{
    __block SubredditViewController *controller;
    __block SubredditRepository *subredditRepository;
    __block NSString *subreddit;
    __block PostsFetchCompletionHandler callback;

    SubredditPostCell *(^cellAtRow)(NSUInteger) = (SubredditPostCell * (^)(NSUInteger)) ^(NSUInteger row){
            return [controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        };

    beforeEach(^{
        subredditRepository = fake_for([SubredditRepository class]);
        subredditRepository stub_method(@selector(fetchPostsForSubreddit:callback:)).and_do(^(NSInvocation *invocation) {
            [invocation getArgument:&callback atIndex:3];
        });
        subreddit = @"pics";
        controller = [[SubredditViewController alloc] initWithSubredditRepository:subredditRepository subreddit:subreddit];

        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];

        UIWindow *window = [[UIWindow alloc] init];
        window.rootViewController = navController;

        controller.view should_not be_nil;
    });

    it(@"should tell repository to fetch subreddit information on load", ^{
        subredditRepository should have_received(@selector(fetchPostsForSubreddit:callback:)).with(subreddit).and_with(Arguments::anything);
    });

    it(@"should display subreddit post information", ^{
        Post *post = [[Post alloc] initWithTitle:@"The Greatest Title Ever!" score:4000 identifier:nil ];
        NSArray *posts = @[post];
        callback(posts);

        cellAtRow(0).titleLabel.text should equal(@"The Greatest Title Ever!");
        cellAtRow(0).scoreLabel.text should equal(@"4000");
    });

    context(@"when a post cell is tapped", ^{
        beforeEach(^{
            Post *post = [[Post alloc] initWithTitle:@"The Greatest Title Ever!" score:4000 identifier:nil ];
            NSArray *posts = @[post];
            callback(posts);
            UITableViewCell *cell = cellAtRow(0);
            [cell tap];
        });

        it(@"should show comments for the post", ^{
            [controller.navigationController topViewController] should be_instance_of([PostViewController class]);
        });
    });

});

SPEC_END
