#import "PopularSubredditsViewController.h"
#import "SubredditRepositoryProvider.h"
#import "SubredditViewController.h"

@interface PopularSubredditsViewController ()
@property NSArray *subreddits;
@property(nonatomic, strong, readwrite) SubredditRepository *subredditRepository;
@end

@implementation PopularSubredditsViewController

- (instancetype)initWithSubredditRepositoryProvider:(SubredditRepositoryProvider *)subredditRepositoryProvider
{
    self = [super initWithNibName:@"PopularSubredditsViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.subredditRepository = [subredditRepositoryProvider get];
        self.title = @"Popular Subreddits";
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    PopularSubredditsFetchCompletionHandler callback = ^(NSArray *data){
        self.subreddits = data;
        [self.tableView reloadData];
    };
    [self.subredditRepository fetchPopularSubredditsWithCallback:callback];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:path animated:NO];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *subredditCell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *subredditTitle = subredditCell.textLabel.text;
    SubredditViewController *subredditViewController = [[SubredditViewController alloc] initWithSubredditRepository:self.subredditRepository
                                                                                                          subreddit:subredditTitle];
    [self.navigationController pushViewController:subredditViewController animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.subreddits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = self.subreddits[(NSUInteger)indexPath.row];
    return cell;
}

@end
