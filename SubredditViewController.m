#import "SubredditViewController.h"
#import "SubredditRepository.h"
#import "Post.h"


@interface SubredditViewController ()
@property(nonatomic, strong) SubredditRepository *subredditRepository;
@property(nonatomic, strong) NSArray *posts;
@property(nonatomic, strong) NSString *subreddit;
@end

@implementation SubredditViewController

- (instancetype)init
{
    [self doesNotRecognizeSelector:@selector(_cmd)];
    return nil;
}

- (instancetype)initWithSubredditRepository:(SubredditRepository *)subredditRepository subreddit:(NSString *)subreddit {
    self = [super init];

    if (self) {
        self.subredditRepository = subredditRepository;
        self.subreddit = subreddit;
        self.title = subreddit;
    }
    
    return self;
}

- (void)viewDidLoad
{
    self.tableView.dataSource = self;

    PostsFetchCompletionBlock postsFetchCompletionBlock = ^void (NSArray *posts){
        self.posts = posts;
        [self.tableView reloadData];
    };

    [self.subredditRepository fetchPostsForSubreddit:self.subreddit callback:postsFetchCompletionBlock];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    Post *post = self.posts[(NSUInteger)indexPath.row];
    cell.textLabel.text = post.title;
    return cell;
}


@end