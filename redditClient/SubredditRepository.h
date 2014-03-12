#import <Foundation/Foundation.h>

@class PopularSubredditsViewController;


@interface SubredditRepository : NSObject
@property(nonatomic, strong) PopularSubredditsViewController *delegate;

- (NSArray *) fetchPopularSubreddits;
@end