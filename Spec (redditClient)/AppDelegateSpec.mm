#import "AppDelegate.h"
#import "PopularSubredditsViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *appDelegate;

    beforeEach(^{
        appDelegate = [[[AppDelegate alloc] init] autorelease];
        [appDelegate application:nil didFinishLaunchingWithOptions:nil];
    });
    
    it(@"should use the correct view controller", ^{
        (PopularSubredditsViewController *) appDelegate.window.rootViewController should be_instance_of([PopularSubredditsViewController class]);
    });
});

SPEC_END
