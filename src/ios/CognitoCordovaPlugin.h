//
//  CognitoCordovaPlugin.h
//  CognitoSample
//
//  Created by Jeff Leininger on 5/31/17.
//  Copyright © 2017 Jeff Leininger. All rights reserved.
//
#import <Cordova/CDVPlugin.h>

#import <Foundation/Foundation.h>
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>
#import <AWSCore/AWSCore.h>

@interface CognitoCordovaPlugin : CDVPlugin {    
}

 	- (void)init:(CDVInvokedUrlCommand*)command;
    - (void)login:(CDVInvokedUrlCommand*)command;
	- (void)getToken:(CDVInvokedUrlCommand*)command;
	- (void)logout:(CDVInvokedUrlCommand*)command;

    - (void)initPlugin:(NSDictionary *)options;

@end
