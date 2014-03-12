#import <UIKit/UIKit.h>
#import "SubredditRepository.h"

@interface PopularSubredditsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (id)initWithSubredditRepository:(SubredditRepository *)subredditRepository;
@end
