#import "ChromeCastClient.h"
@import GoogleCast;

@interface ChromeCastClient () <GCKLoggerDelegate, GCKSessionManagerListener, GCKRemoteMediaClientListener>

@property (nonatomic, strong) GCKSessionManager *sessionManager;

@end

@implementation ChromeCastClient

#pragma mark - Init
- (instancetype)initWithApplicationId:(NSString *)appId {
    self = [super init];
    if (self) {
        _appId = appId;
        [self setupClient];
        _sessionManager = [GCKCastContext sharedInstance].sessionManager;
        [_sessionManager addListener:self];
    }
    return self;
}

#pragma mark - Public

- (BOOL)isSessionActive {
    return [self.sessionManager hasConnectedCastSession];
}

- (void)streamUrl:(NSURL *)url {
    GCKMediaInformation *const info = [[GCKMediaInformation alloc] initWithContentID:url.absoluteString
                                                                          streamType:GCKMediaStreamTypeLive
                                                                         contentType:@"application/x-mpegurl"
                                                                            metadata:nil
                                                                            adBreaks:nil
                                                                        adBreakClips:nil
                                                                      streamDuration:INFINITY
                                                                         mediaTracks:nil
                                                                      textTrackStyle:nil
                                                                          customData:nil];
    if (self.currentCastSession) {
        [self logFormat:@"Starting up session with info: %@", info];
        [self.currentCastSession.remoteMediaClient addListener:self];
        [self.currentCastSession.remoteMediaClient loadMedia:info];
    } else {
        [self.delegate castClientDidFailToInitiateSession:self];
    }
}

- (void)stopStreaming {
    [self.sessionManager endSessionAndStopCasting:YES];
}

#pragma mark - Private

- (nullable GCKCastSession *)currentCastSession {
    return self.sessionManager.currentCastSession;
}

- (void)setupClient {
    GCKDiscoveryCriteria *const criteria = [[GCKDiscoveryCriteria alloc] initWithApplicationID:self.appId];
    GCKCastOptions *const options = [[GCKCastOptions alloc] initWithDiscoveryCriteria:criteria];
    [GCKCastContext setSharedInstanceWithOptions:options];
    [GCKLogger sharedInstance].delegate = self;
}

#pragma mark - GCKLoggerDelegate
- (void)logMessage:(NSString *)message
           atLevel:(GCKLoggerLevel)level
      fromFunction:(NSString *)function
          location:(NSString *)location {
    [self logFormat:@"ChromeCastClient: %@  %@", function, message];
}

#pragma mark - GCKSessionManagerListener
- (void)sessionManager:(GCKSessionManager *)sessionManager didStartCastSession:(GCKCastSession *)session {
    [self.delegate castClientDidStartSession:self];
}

- (void)sessionManager:(GCKSessionManager *)sessionManager
didFailToStartCastSession:(GCKCastSession *)session
             withError:(NSError *)error {
    [self.delegate castClient:self didFailToStartSessionWithError:error];
}

- (void)sessionManager:(GCKSessionManager *)sessionManager
     didEndCastSession:(GCKCastSession *)session
             withError:(NSError *)error {
    [self.delegate castClient:self didEndSessionWithError:error];
}

#pragma mark - GCKRemoteMediaClientListener

- (void)remoteMediaClient:(GCKRemoteMediaClient *)client didStartMediaSessionWithID:(NSInteger)sessionID {
    [self.delegate castClientDidStartPlayingMedia:self];
}

#pragma mark - Logging
- (void)logFormat:(NSString *)format, ... {
    if (!self.loggingEnabled) {
        return;
    }

    NSString *contents;
    va_list args;
    va_start(args, format);
    contents = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    NSLog(@"%@", contents);
}

@end
