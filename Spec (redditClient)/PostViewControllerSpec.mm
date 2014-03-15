#import "PostViewController.h"
#import "Post.h"
#import "SubredditRepository.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(PostViewControllerSpec)

fdescribe(@"PostViewController", ^{
    __block PostViewController *controller;
    __block SubredditRepository *fakeSubredditRepository;
    __block NSString *identifier;

    beforeEach(^{
        identifier = @"batman";
        Post *post = [[Post alloc] initWithTitle:@"yay" score:9000 identifier:identifier];
        fakeSubredditRepository = fake_for([SubredditRepository class]);
        fakeSubredditRepository stub_method(@selector(fetchCommentsForPostIdentifier:));
        controller = [[PostViewController alloc] initWithPost:post subredditRepository:fakeSubredditRepository];

        controller.view should_not be_nil;
    });
    
    it(@"tells the subreddit respository to fetch the comments for a post", ^{
        fakeSubredditRepository should have_received(@selector(fetchCommentsForPostIdentifier:)).with(identifier);
    });
});

SPEC_END
