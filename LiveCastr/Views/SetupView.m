#import "SetupView.h"

#import "Colors.h"
#import "PaddedTextField.h"
#import "Strings.h"

@interface SetupView ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) PaddedTextField *urlTextField;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic) BOOL didLayoutConstraints;

@end

@implementation SetupView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
        [self registerForNotifications];
    }

    return self;
}

#pragma mark - Setup
- (void)configureView {
    self.backgroundColor = BACKGROUND_COLOR;
    self.errorLabel.hidden = YES;
    self.submitButton.enabled = self.enableSubmitButton;
    [self.submitButton addTarget:self
                          action:@selector(didTapSubmitButton:)
                forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.stackView];
}

- (void)registerForNotifications {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(didReceiveTextFieldDidChangeNotification:)
                   name:UITextFieldTextDidChangeNotification
                 object:self.urlTextField];
}

#pragma mark - Setters
- (void)setEnableSubmitButton:(BOOL)enableSubmitButton {
    _enableSubmitButton = enableSubmitButton;
    self.submitButton.enabled = enableSubmitButton;
}

#pragma mark - Observers
- (void)didReceiveTextFieldDidChangeNotification:(NSNotification *)notification {
    [self resetErrorStylingIfNeeded];
    [self.delegate setupView:self textDidChange:self.urlTextField.text];
}

#pragma mark - Target Action
- (void)didTapSubmitButton:(UIButton *)submitButton {
    [self.delegate setupViewDidTapSubmitButton:self];
}

#pragma mark - Layout
- (void)updateConstraints {
    [super updateConstraints];
    if (self.didLayoutConstraints) {
        return;
    }

    [NSLayoutConstraint activateConstraints:@[
        [self.stackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.stackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.stackView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.8],
    ]];

    self.didLayoutConstraints = YES;
}

#pragma mark - Configuration

- (void)configureWithErrorMessage:(nullable NSString *)errorMessage {
    const BOOL hasError = errorMessage != nil;
    self.urlTextField.textColor = ERROR_COLOR;
    self.errorLabel.text = errorMessage;
    self.errorLabel.hidden = !hasError;
}

- (void)resetErrorStylingIfNeeded {
    if (self.errorLabel.hidden) {
        return;
    }
    self.errorLabel.hidden = YES;
    self.errorLabel.text = nil;
    self.urlTextField.textColor = TEXT_COLOR;
}

#pragma mark - Views

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[
            self.titleLabel,
            self.urlTextField,
            self.errorLabel,
            self.submitButton,
         ]];
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 20.0;
    }
    return _stackView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = URL_TITLE;
        _titleLabel.textColor = TEXT_COLOR;
    }
    return _titleLabel;
}

- (PaddedTextField *)urlTextField {
    if (!_urlTextField) {
        _urlTextField = [[PaddedTextField alloc] init];
        _urlTextField.layer.borderWidth = 0.5;
        _urlTextField.layer.borderColor = BORDER_COLOR.CGColor;
        _urlTextField.layer.cornerRadius = 6.0;
        _urlTextField.textColor = TEXT_COLOR;
        _urlTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _urlTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _urlTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:URL_PLACEHOLDER
                                                                              attributes:@{NSForegroundColorAttributeName: PLACEHOLDER_COLOR}];;
    }
    return _urlTextField;
}

- (UILabel *)errorLabel {
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc] init];
        _errorLabel.textColor = ERROR_COLOR;
        _errorLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        _errorLabel.numberOfLines = 0;
    }
    return _errorLabel;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_submitButton setTitle:SUBMIT_BUTTON forState:UIControlStateNormal];
        [_submitButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
        [_submitButton setTitleColor:DISABLED_COLOR forState:UIControlStateDisabled];
    }
    return _submitButton;
}

@end
