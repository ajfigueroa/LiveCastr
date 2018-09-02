#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressHUD : NSObject

+ (void)show:(NSString *)text;
+ (void)showSuccess:(NSString *)successText;
+ (void)dismissWithDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
