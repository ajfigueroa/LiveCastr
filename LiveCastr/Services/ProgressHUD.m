#import "ProgressHUD.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation ProgressHUD

+ (void)show:(NSString *)text {
    [SVProgressHUD showWithStatus:text];
}

+ (void)showSuccess:(NSString *)successText {
    [SVProgressHUD showSuccessWithStatus:successText];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay {
    [SVProgressHUD dismissWithDelay:delay];
}

@end
