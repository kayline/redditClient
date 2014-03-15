#import <Foundation/Foundation.h>

@class Post;
@class SubredditRepository;


@interface PostViewController : UIViewController
- (instancetype)initWithPost:(Post *)post subredditRepository:(SubredditRepository *)subredditRepository;
@end

