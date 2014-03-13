#import <UIKit/UIKit.h>
#import "SubredditRepository.h"

@class SubredditRepositoryProvider;

@interface PopularSubredditsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (instancetype)initWithSubredditRepositoryProvider:(SubredditRepositoryProvider *)subredditRepositoryProvider;
@end
