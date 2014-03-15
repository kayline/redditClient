#import "SubredditViewController.h"
#import "SubredditRepository.h"
#import "Post.h"
#import "SubredditPostCell.h"
#import "PostViewController.h"


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
    self.tableView.delegate = self;

    PostsFetchCompletionHandler postsFetchCompletionBlock = ^void (NSArray *posts){
        self.posts = posts;
        [self.tableView reloadData];
    };

    [self.subredditRepository fetchPostsForSubreddit:self.subreddit callback:postsFetchCompletionBlock];

    UINib *nib = [UINib nibWithNibName: @"SubredditPostCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"postCell"];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Post *post = self.posts[(NSUInteger)indexPath.row];
    NSString *title = post.title;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGFloat width = 206;
    CGRect rect = [title boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributes
                                      context:nil];
    CGFloat height = rect.size.height + 20;

    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostViewController *postViewController = [[PostViewController alloc] init];
    [self.navigationController pushViewController:postViewController animated:NO];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubredditPostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell"];
    if (!cell)  {
        cell = [[SubredditPostCell alloc] init];
    }

    Post *post = self.posts[(NSUInteger)indexPath.row];
    cell.titleLabel.text = post.title;
    cell.scoreLabel.text = [NSString stringWithFormat: @"%d", post.score];
    return cell;
}

@end
