#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ImagePicker, NSObject)
RCT_EXTERN_METHOD(selectPhoto :(RCTPromiseResolveBlock) resolve
                  rejecter :(RCTPromiseRejectBlock) reject)
@end
