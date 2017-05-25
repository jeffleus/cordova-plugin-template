#import "MyCordovaPlugin.h"

#import <Cordova/CDVAvailability.h>

@implementation MyCordovaPlugin

- (void)pluginInitialize {
}

- (void)echo:(CDVInvokedUrlCommand *)command {
    NSString* phrase = [command.arguments objectAtIndex:0];
    NSLog(@"%@", phrase);
}

- (void)getDate:(CDVInvokedUrlCommand *)command {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    
    NSDate *now = [NSDate date];
    NSString *iso8601String = [dateFormatter stringFromDate:now];
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:iso8601String];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)init:(CDVInvokedUrlCommand *)command {
    NSLog(@"The init method of the plugin was called");
    AWSRegionType const CognitoIdentityUserPoolRegion = AWSRegionUSWest2;
    
    NSMutableDictionary* options = [command.arguments objectAtIndex:0];
    NSString *username = @"fsdemo-manager";
    NSString *password = @"FuelStation17!";
    
    self.CognitoIdentityUserPoolId = [options objectForKey:@"CognitoIdentityUserPoolId"];
    self.CognitoIdentityUserPoolAppClientId = [options objectForKey:@"CognitoIdentityUserPoolAppClientId"];
    self.CognitoIdentityUserPoolAppClientSecret = nil;
    self.User = nil;
    self.actualAccessToken = nil;
    self.arnIdentityPoolId = [options objectForKey:@"arnIdentityPoolId"];
    self.dataset = nil;
    
    self.credentialsProvider = nil;
    
    AWSServiceConfiguration *serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:CognitoIdentityUserPoolRegion credentialsProvider:nil];
    
    AWSCognitoIdentityUserPoolConfiguration *userPoolConfiguration = [[AWSCognitoIdentityUserPoolConfiguration alloc] initWithClientId:self.CognitoIdentityUserPoolAppClientId clientSecret:self.CognitoIdentityUserPoolAppClientSecret poolId:self.CognitoIdentityUserPoolId];
    
    [AWSCognitoIdentityUserPool registerCognitoIdentityUserPoolWithConfiguration:serviceConfiguration userPoolConfiguration:userPoolConfiguration forKey:@"UserPool"];
    
    self.Pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    
    self.credentialsProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:CognitoIdentityUserPoolRegion identityPoolId:self.arnIdentityPoolId identityProviderManager:self.Pool];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:CognitoIdentityUserPoolRegion credentialsProvider:self.credentialsProvider];
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
    self.User = [self.Pool getUser:username];
    [[self.User getSession:username password:password validationData:nil] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserSession *> * _Nonnull task) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(task.error){
                NSLog(@"error : %@", task.error.userInfo);
                
                CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:task.error.userInfo];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            } else{
                self.actualAccessToken = task.result.accessToken;
                
                CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:task.result.idToken.tokenString];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }
        });
        return nil;
    }];
}
//    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Initialization successful"];
//
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
//}

- (void)login:(CDVInvokedUrlCommand *)command {
    NSString* username = [command.arguments objectAtIndex:0];
    NSString* password = [command.arguments objectAtIndex:1];
    NSLog(@"Login as %@, %@", username, password);
}

@end
