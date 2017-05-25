#import <Cordova/CDVPlugin.h>
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>
#import <AWSCognito/AWSCognito.h>


@interface MyCordovaPlugin : CDVPlugin {
}
@property NSString *CognitoIdentityUserPoolId;
@property NSString *CognitoIdentityUserPoolAppClientId;
@property NSString *CognitoIdentityUserPoolAppClientSecret;
@property AWSCognitoIdentityUserPool *Pool;
@property AWSCognitoIdentityUser *User;
@property AWSCognitoIdentityUserSessionToken *actualAccessToken;
@property NSString *arnIdentityPoolId;
@property AWSCognito *syncClient;
@property AWSCognitoDataset *dataset;
@property AWSCognitoCredentialsProvider *credentialsProvider;

// The hooks for our plugin commands
- (void)echo:(CDVInvokedUrlCommand *)command;
- (void)getDate:(CDVInvokedUrlCommand *)command;
- (void)init:(CDVInvokedUrlCommand *)command;
- (void)login:(CDVInvokedUrlCommand *)command;

@end
