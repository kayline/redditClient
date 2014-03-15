#import "PostViewController.h"
#import "Post.h"
#import "SubredditRepository.h"


@interface PostViewController ()
@property(nonatomic, strong) Post *post;
@property(nonatomic, strong) SubredditRepository *subredditRepository;
@end

@implementation PostViewController

- (id)init
{
    [self doesNotRecognizeSelector:@selector(_cmd)];
    return nil;
}

- (instancetype)initWithPost:(Post *)post subredditRepository:(SubredditRepository *)subredditRepository
{
    self = [super init];

    if (self) {
        self.post = post;
        self.subredditRepository = subredditRepository;
    }

    return self;
}

- (void)viewDidLoad
{
    [self.subredditRepository fetchCommentsForPostIdentifier:self.post.identifier];
}

@end