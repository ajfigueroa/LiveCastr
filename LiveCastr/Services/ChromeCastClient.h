#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ChromeCastClient;

@protocol ChromeCastClientDelegate <NSObject>

- (void)castClientDidFailToInitiateSession:(ChromeCastClient *)castClient;
- (void)castClientDidStartSession:(ChromeCastClient *)castClient;
- (void)castClient:(ChromeCastClient *)castClient didFailToStartSessionWithError:(NSError *)error;
- (void)castClient:(ChromeCastClient *)castClient didEndSessionWithError:(nullable NSError *)error;
- (void)castClientDidStartPlayingMedia:(ChromeCastClient *)castClient;

@end

@interface ChromeCastClient : NSObject

@property (nonatomic, copy, readonly) NSString *appId;
/// Determines if there is currently a Cast session connected and managed
@property (nonatomic, readonly) BOOL isSessionActive;
/// Enable Chrome Cast logging
@property (nonatomic) BOOL loggingEnabled;
@property (nonatomic, weak) id<ChromeCastClientDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithApplicationId:(NSString *)appId NS_DESIGNATED_INITIALIZER;

- (void)streamUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
