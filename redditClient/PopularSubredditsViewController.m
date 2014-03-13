#import "PopularSubredditsViewController.h"
#import "SubredditRepositoryProvider.h"

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
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DataFetchCompletionHandler callback = ^(NSArray *data){
        self.subreddits = data;
        [self.tableView reloadData];
    };
    [self.subredditRepository fetchPopularSubredditsWithCallback:callback];
    self.tableView.dataSource = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.subreddits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = self.subreddits[(NSUInteger)indexPath.row];
    return cell;
}

@end
