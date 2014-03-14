#import <Foundation/Foundation.h>

@class SubredditRepository;


@interface SubredditViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
- (instancetype)initWithSubredditRepository:(SubredditRepository *)subredditRepository subreddit:(NSString *)subreddit;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
