#import <Foundation/Foundation.h>


@interface Post : NSObject
@property(nonatomic, readwrite, copy) NSString *title;
@property(nonatomic, readonly) NSInteger score;
@property(nonatomic, readwrite, copy) NSString *identifier;
- (instancetype)initWithTitle:(NSString *)title score:(NSInteger)score identifier:(NSString *)identifier;
@end