#import "Post.h"


@interface Post ()
@property(nonatomic, readwrite) NSString *title;
@property(nonatomic, readwrite) NSInteger score;
@end

@implementation Post

- (instancetype)initWithTitle:(NSString *)title Score:(NSInteger)score
{
    self = [super init];
    
    if (self) {
        self.title = title;
        self.score = score;
    }
    return self;
}
@end