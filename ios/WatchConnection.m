#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(WatchConnection, NSObject)

RCT_EXTERN_METHOD(activate)
RCT_EXTERN_METHOD(sendMessage: (NSDictionary *)message)

@end
