#import "SetupViewController.h"

#import "ChromeCastClient.h"
#import "ProgressHUD.h"
#import "SetupView.h"
#import "Strings.h"
#import "UIBarButtonItem+Cast.h"

@interface SetupViewController () <SetupViewDelegate, ChromeCastClientDelegate>

@property (nonatomic, strong) SetupView *setupView;
@property (nonatomic, strong, nullable) NSString *urlText;

@end

@implementation SetupViewController

- (instancetype)initWithCastClient:(ChromeCastClient *)castClient {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _castClient = castClient;
        _castClient.delegate = self;
    }
    return self;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = APP_TITLE;
    [self.view addSubview:self.setupView];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem castButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.setupView.frame = self.view.bounds;
}

#pragma mark - SetupViewDelegate

- (void)setupView:(SetupView *)view textDidChange:(NSString *)text {
    self.urlText = text;
    [self updateSubmitButton];
}

- (void)setupViewDidTapSubmitButton:(SetupView *)view {
    NSURL *url = [NSURL URLWithString:self.urlText];
    if (!url) {
        [self updateErrorLabelWithMessage:INVALID_URL];
        return;
    }

    [ProgressHUD show:STREAM_LOADING];
    [self.castClient streamUrl:url];
}

#pragma mark - View Updates

- (void)updateSubmitButton {
    self.setupView.enableSubmitButton = self.urlText.length > 0 && self.castClient.isSessionActive;
}

- (void)updateErrorLabelWithMessage:(NSString *)errorMessage {
    [self.setupView configureWithErrorMessage:errorMessage];
}

#pragma mark - ChromeCastClientDelegate

- (void)castClientDidFailToInitiateSession:(ChromeCastClient *)castClient {
    [self hideProgressHUD];
    [self updateErrorLabelWithMessage:INVALID_SESSION];
    [self updateSubmitButton];
}

- (void)castClientDidStartSession:(ChromeCastClient *)castClient {
    [self updateSubmitButton];
}

- (void)castClient:(ChromeCastClient *)castClient didFailToStartSessionWithError:(NSError *)error {
    [self updateErrorLabelWithMessage:error.localizedDescription];
}

- (void)castClient:(ChromeCastClient *)castClient didEndSessionWithError:(nullable NSError *)error {
    if (error) {
        [self updateErrorLabelWithMessage:error.localizedDescription];
    }
}

- (void)castClientDidStartPlayingMedia:(ChromeCastClient *)castClient {
    [ProgressHUD showSuccess:STREAM_LOADED];
    [self hideProgressHUD];
}

#pragma mark - Progress

- (void)hideProgressHUD {
    [ProgressHUD dismissWithDelay:1.0];
}

#pragma mark - Views
- (SetupView *)setupView {
    if (!_setupView) {
        _setupView = [[SetupView alloc] init];
        _setupView.delegate = self;
    }
    return _setupView;
}

@end
