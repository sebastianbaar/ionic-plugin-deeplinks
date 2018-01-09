#import "AppDelegate.h"
#import "IonicDeeplinkPlugin.h"

static NSString *const PLUGIN_NAME = @"IonicDeeplinkPlugin";

@interface AppDelegate (IonicDeeplinkPlugin)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

@end

@implementation AppDelegate (IonicDeeplinkPlugin)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    IonicDeeplinkPlugin *plugin = [self.viewController getCommandInstance:PLUGIN_NAME];

    if(plugin == nil) {
      NSLog(@"Unable to get instance of command plugin");
      return NO;
    }

    BOOL handled = [plugin handleLink:url];

    if(!handled) {
      // Pass event through to Cordova
      [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginHandleOpenURLNotification object:url]];

      // Send notice to the rest of our plugin that we didn't handle this URL
      [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"IonicLinksUnhandledURL" object:[url absoluteString]]];
    }

    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Pass the push notification to the plugin

}

@end
