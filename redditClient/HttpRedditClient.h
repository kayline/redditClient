#import <Foundation/Foundation.h>


@interface HttpRedditClient : NSObject
- (NSDictionary *) fetchPopularSubreddits;
@end