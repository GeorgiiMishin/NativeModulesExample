#import <React/RCTViewManager.h>
 
@interface RCT_EXTERN_MODULE(SimpleTextViewManager, RCTViewManager)
  RCT_EXPORT_VIEW_PROPERTY(content, NSString)
  RCT_EXPORT_SHADOW_PROPERTY(content, NSString)
@end
