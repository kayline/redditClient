#import "AppDelegate.h"
#import "PopularSubredditsViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *appDelegate;

    beforeEach(^{
        appDelegate = [[AppDelegate alloc] init];
        [appDelegate application:nil didFinishLaunchingWithOptions:nil];
    });
    
    it(@"should use the navigation controller as root view controller", ^{
        appDelegate.window.rootViewController should be_instance_of([UINavigationController class]);
    });

    it(@"should push the popular subreddit view controller as root for navigation controller", ^{
        [(UINavigationController *)appDelegate.window.rootViewController topViewController] should be_instance_of([PopularSubredditsViewController class]);
    });
});

SPEC_END
