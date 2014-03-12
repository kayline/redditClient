#import "PopularSubredditsViewController.h"
#import "SubredditRepositoryProvider.h"

@interface PopularSubredditsViewController ()
@property NSArray *subreddits;
@property(nonatomic, strong, readwrite) SubredditRepository *subredditRepository;
@end

@implementation PopularSubredditsViewController

- (id)initWithSubredditRepositoryProvider:(SubredditRepositoryProvider *)subredditRepositoryProvider
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
    self.subredditRepository.delegate = self;
    [self.subredditRepository fetchPopularSubreddits];
    self.tableView.dataSource = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = self.subreddits[(NSUInteger)indexPath.row];
    return cell;
}

@end
