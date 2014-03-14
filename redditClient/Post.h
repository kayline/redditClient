#import <Foundation/Foundation.h>


@interface Post : NSObject
@property(nonatomic, readonly) NSString *title;

@property(nonatomic, readonly) NSInteger score;

- (instancetype)initWithTitle:(NSString *)title Score:(NSInteger)score;
@end