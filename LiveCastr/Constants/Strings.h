#ifndef Strings_h
#define Strings_h

#pragma mark - General

#define APP_TITLE           @"LiveCastr"

#pragma mark - Streaming

#define STREAM_LOADING      NSLocalizedString(@"Loading...", @"Title for HUD that indicates the stream is loading")
#define STREAM_LOADED       NSLocalizedString(@"Your stream has started!", @"Title for HUD that indicates stream has started")

#pragma mark - Error Messages

#define INVALID_URL         NSLocalizedString(@"Oops, that doesn't look like a valid url", "Error message for when the url is invalid")
#define INVALID_SESSION     NSLocalizedString(@"It looks like there is no active session 🤔. Tap the Cast button or setup your Chromecast before streaming", "Error message for when Cast hasn't been setup")

#pragma mark - SetupView

#define URL_TITLE           NSLocalizedString(@"Live Stream Url", @"Title that appears above url text field")
#define URL_PLACEHOLDER     NSLocalizedString(@"Enter your live stream url here", @"Placeholder for url text field")
#define SUBMIT_BUTTON       NSLocalizedString(@"Start", @"Title for button that starts live stream load")

#endif /* Strings_h */
