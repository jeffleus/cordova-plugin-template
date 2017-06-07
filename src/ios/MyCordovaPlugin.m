#import "MyCordovaPlugin.h"
#import "CognitoPoolIdentityProvider.h"
#import "CognitoCordovaPlugin.h"

#import <Cordova/CDVAvailability.h>

@implementation MyCordovaPlugin
    CognitoCordovaPlugin *plugin;

- (void)pluginInitialize {

}

- (void)init:(CDVInvokedUrlCommand *)command {
    // Do any additional setup after loading the view, typically from a nib.
    plugin = [[CognitoCordovaPlugin alloc] init];
    
    NSDictionary *options = [[NSDictionary alloc] initWithObjectsAndKeys:
                             @"us-west-2:28695927-b308-4073-acd6-fedc4e1cd40b", @"arnIdentityPoolId",
                             @"49f7iepq786236nea8t33m1kje", @"CognitoIdentityUserPoolAppClientId",
                             @"us-west-2_KMI3gTfQw", @"CognitoIdentityUserPoolId", nil];
    [plugin initPlugin:options];

    //create a pluginResult to report back the init results and return to the command delegate
    CDVPluginResult *pluginResult = [CDVPluginResult
                                     resultWithStatus:CDVCommandStatus_OK
                                     messageAsString:@"Initialization successful"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)login:(CDVInvokedUrlCommand *)command {
    NSMutableDictionary* options = [command.arguments objectAtIndex:0];
    
    NSString *username = [options objectForKey:@"username"];
    NSString *password = [options objectForKey:@"password"];
    NSLog(@"Login as %@, %@", username, password);
    [plugin loginUser:username withPassword:password];
    
    //create a pluginResult to report back the init results and return to the command delegate
    CDVPluginResult *pluginResult = [CDVPluginResult
                                     resultWithStatus:CDVCommandStatus_OK
                                     messageAsString:@"Login successful"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)refresh:(CDVInvokedUrlCommand *)command {
    [plugin refreshSession];
    
    //create a pluginResult to report back the init results and return to the command delegate
    CDVPluginResult *pluginResult = [CDVPluginResult
                                     resultWithStatus:CDVCommandStatus_OK
                                     messageAsString:@"Refresh successful"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

@end
