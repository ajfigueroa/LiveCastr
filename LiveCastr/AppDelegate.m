#import "AppDelegate.h"

#import "Colors.h"
#import "Constants.h"
#import "ChromeCastClient.h"
#import "SetupViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) ChromeCastClient *castClient;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    [self applyGlobalStyling];

    SetupViewController *setupViewController = [[SetupViewController alloc] initWithCastClient:self.castClient];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:setupViewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - Styling

- (void)applyGlobalStyling {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UINavigationBar appearance].tintColor = TINT_COLOR;
    [UINavigationBar appearance].barTintColor = BACKGROUND_COLOR;
    [UINavigationBar appearance].titleTextAttributes = @{ NSForegroundColorAttributeName: TEXT_COLOR };
    if (@available(iOS 11.0, *)) {
        [UINavigationBar appearance].largeTitleTextAttributes = @{ NSForegroundColorAttributeName: TEXT_COLOR };
    }
}

#pragma mark - Properties

- (ChromeCastClient *)castClient {
    if (!_castClient) {
        _castClient = [[ChromeCastClient alloc] initWithApplicationId:APP_ID];
    }
    return _castClient;
}

@end
