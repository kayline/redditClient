#import "Post.h"


@interface Post ()
@property(nonatomic, readwrite) NSInteger score;
@end

@implementation Post

- (instancetype)initWithTitle:(NSString *)title score:(NSInteger)score identifier:(NSString *)identifier {
    self = [super init];
    
    if (self) {
        self.title = title;
        self.score = score;
        self.identifier = identifier;
    }
    return self;
}
@end