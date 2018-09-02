#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SetupView;

@protocol SetupViewDelegate <NSObject>

- (void)setupView:(SetupView *)view textDidChange:(nullable NSString *)text;
- (void)setupViewDidTapSubmitButton:(SetupView *)view;

@end

@interface SetupView : UIView

@property (nonatomic, weak) id<SetupViewDelegate> delegate;
/// Enables the submit button. Defaults to NO
@property (nonatomic) BOOL enableSubmitButton;

/// Configures the view with an error message if available
- (void)configureWithErrorMessage:(nullable NSString *)errorMessage;

@end

NS_ASSUME_NONNULL_END
