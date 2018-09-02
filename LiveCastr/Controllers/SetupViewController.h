#import <UIKit/UIKit.h>
@class ChromeCastClient;

NS_ASSUME_NONNULL_BEGIN

@interface SetupViewController : UIViewController

@property (nonatomic, strong, readonly) ChromeCastClient *castClient;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithCastClient:(ChromeCastClient *)castClient NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
