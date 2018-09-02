#import "UIBarButtonItem+Cast.h"
@import GoogleCast;

@implementation UIBarButtonItem (Cast)

+ (instancetype)castButton {
    GCKUICastButton *castButton = [[GCKUICastButton alloc] init];
    return [[UIBarButtonItem alloc] initWithCustomView:castButton];
}

@end
