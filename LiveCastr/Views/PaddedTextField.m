#import "PaddedTextField.h"

static CGFloat const inset = 10.0;

@implementation PaddedTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, inset, inset);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, inset, inset);
}

@end
