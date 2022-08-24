#import "PagPlugin.h"
#if __has_include(<pag/pag-Swift.h>)
#import <pag/pag-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pag-Swift.h"
#endif

@implementation PagPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPagPlugin registerWithRegistrar:registrar];
}
@end
