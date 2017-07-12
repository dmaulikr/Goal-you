//
//  AppDelegate.m
//  Goals&you
//
//  Created by Raindrops Infotech on 17/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <GoogleSignIn/GIDAuthentication.h>
#import "ViewController.h"
#import "CategoryviewVC.h"
#import "DashboardVC.h"
//#import "Harpy.h"
#import "Reachability.h"
#import <UserNotifications/UserNotifications.h>
#import "NotificationviewVC.h"



@interface AppDelegate ()<GIDSignInDelegate>//,HarpyDelegate
{
    NSString *savedValueid;
    NSString *savedValueusername;
    NSString *savedValueusernamelocal;
    NSString *savedValueusergoogle;
    NSString *strgoogleid;
    NSString *email;
    NSString *fullName;
    NSString *userId;
    NSDictionary *jsonDictionary;

}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.window makeKeyAndVisible];
    
   // [[Harpy sharedInstance] setPresentingViewController:_window.rootViewController];
    
    // (Optional) Set the Delegate to track what a user clicked on, or to use a custom UI to present your message.
   // [[Harpy sharedInstance] setDelegate:self];
   
    // (Optional) The tintColor for the alertController
   // [[Harpy sharedInstance] setAlertControllerTintColor:[UIColor blueColor]];
    
    // (Optional) Set the App Name for your app
  //  [[Harpy sharedInstance] setAppName:@"Goal&You"];
    
    /* (Optional) Set the Alert Type for your app
     By default, Harpy is configured to use HarpyAlertTypeOption */
   // [[Harpy sharedInstance] setAlertType:HarpyAlertTypeSkip];
    
    /* (Optional) If your application is not available in the U.S. App Store, you must specify the two-letter
     country code for the region in which your applicaiton is available. */
    // [[Harpy sharedInstance] setCountryCode:@"<#country_code#>"];
    
    /* (Optional) Overrides system language to predefined language.
     Please use the HarpyLanguage constants defined in Harpy.h. */
    //   [[Harpy sharedInstance] setForceLanguageLocalization:<#HarpyLanguageConstant#>];
    
    // Perform check for new version of your app
   // [[Harpy sharedInstance] checkVersion];

    [FBLoginView class];
    [FBProfilePictureView class];
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].clientID = @"699952507188-oglp1bcrqgqfllnu6dj4nmg78l8npd5c.apps.googleusercontent.com";
    
    savedValueusername = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceusername"];
    savedValueusernamelocal = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"preferencenamelocal"];
    savedValueusergoogle = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"preferenceuseremailgoogle"];
    if (savedValueusername.length>0 || savedValueusergoogle.length>0 || savedValueusernamelocal.length>0)
    {
        DashboardVC *dashViewc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"dashview"];
        [(UINavigationController *)self.window.rootViewController pushViewController:dashViewc animated:YES];
    }
    else
    {
        ViewController *Viewc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"aboutview"];
        [(UINavigationController *)self.window.rootViewController pushViewController:Viewc animated:YES];
    }
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!error) {
                                  NSLog(@"request authorization succeeded!");
                                  [self showAlert];
                              }
                          }];
    
    
    return YES;
}
-(void)showAlert
{
//    UIAlertController *objAlertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Notification Set!" preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *cancelAction = [UIAlertAction
//                                   actionWithTitle:@"OK"
//                                   style:UIAlertActionStyleCancel
//                                   handler:^(UIAlertAction *action)
//                                   {
                                       NSLog(@"Ok clicked!");
//                                   }];
//    [objAlertController addAction:cancelAction];
//    
//    
//    [[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController] presentViewController:objAlertController animated:YES completion:^{
//        
//    }];
    
}
- (void)harpyDidShowUpdateDialog
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)harpyUserDidLaunchAppStore
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)harpyUserDidSkipVersion
{
    NSLog(@"%s", __FUNCTION__);
    
    
}

- (void)harpyUserDidCancel
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)harpyDidDetectNewVersionWithoutAlert:(NSString *)message
{
    NSLog(@"%@", message);
}


-(void)functionInsideWhichAppIsCrashing
{
    
    @try
    {
        //Your crashing code goes here
    }
    
    @catch ( NSException *e )
    {
        NSLog(@"Crash Reason:%@", [e reason]);
    }
    @finally
    {
        // Do whatever you want to do in crash situation
        
    }
}
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    
//    
//    return [FBAppCall handleOpenURL:url
//                  sourceApplication:sourceApplication];
//    
//}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
   // NSLog(@"url: %@", [url scheme]);
    
    BOOL callBack = false;
    // Facebook Call back checking.
    if ([[url scheme] isEqualToString:@"fb738928452921266"])
    {
        callBack = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    }
    // Instagram call back checking.  com.googleusercontent.apps.699952507188-oglp1bcrqgqfllnu6dj4nmg78l8npd5c
    else if ([[url scheme] isEqualToString:@"com.googleusercontent.apps.699952507188-oglp1bcrqgqfllnu6dj4nmg78l8npd5c"])
    {
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:sourceApplication
                                          annotation:annotation];

    }
    return callBack;
    
}
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    if (notificationSettings.types) {
        NSLog(@"user allowed notifications");
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else{
        NSLog(@"user did not allow notifications");
        // show alert here
    }
}
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    // Perform any operations on signed in user here.
    userId = user.userID;                  // For client-side use only!
   // NSString *idToken = user.authentication.idToken; // Safe to send to the server
    fullName = user.profile.name;
//    NSString *givenName = user.profile.givenName;
//    NSString *familyName = user.profile.familyName;
   email = user.profile.email;
    NSLog(@"email address%@",email);
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"preferenceuseremailgoogle"];
    savedValueid = [[NSUserDefaults standardUserDefaults]
                    stringForKey:@"preferenceuseremailgoogle"];
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"preferenceuseridgoogle"];
    savedValueid = [[NSUserDefaults standardUserDefaults]
                    stringForKey:@"preferenceuseridgoogle"];
    [[NSUserDefaults standardUserDefaults] setObject:fullName forKey:@"preferenceusernamegoogle"];
    savedValueid = [[NSUserDefaults standardUserDefaults]
                    stringForKey:@"preferenceusernamegoogle"];
//    savedValueshowid=savedValueid;
    [[NSUserDefaults standardUserDefaults] synchronize];
    // [START_EXCLUDE]
    NSDictionary *statusText = @{@"statusText":
                                     [NSString stringWithFormat:@"Signed in user: %@",
                                      fullName]};
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ToggleAuthUINotification"
     object:nil
     userInfo:statusText];
    [self googlelogin];
    // [END_EXCLUDE]
}
-(void)googlelogin
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status==ReachableViaWiFi || status==ReachableViaWWAN)
    {
        NSArray *keys = [NSArray arrayWithObjects:@"op",@"email",@"userid",@"username", nil];
        NSArray *objects = [NSArray arrayWithObjects:@"LoginGmail",email,userId,userId,nil];// need array of more than one string or data posted
        NSError *error;
        
        jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];// for array or more than string values
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.33/pro/Webservice/habbits/index.php"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:3.0f];
        
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [request setHTTPMethod:@"POST"];
        
        NSData *postData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:&error];
        [request setHTTPBody:postData];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                              {
                                                  NSError *jsonError;
                                                  if(data.length>0)
                                                  {
                                                      NSDictionary *jsonidstore = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                  options:NSJSONReadingMutableContainers
                                                                                                                    error:&jsonError];
                                                      NSLog(@"google: %@",jsonidstore);
                                                      dispatch_async(dispatch_get_main_queue(),
                                                                     ^{
                                                                         //arracategory=[jsonidstore valueForKey:@"message"];
                                                                         DashboardVC *dashViewc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"dashview"];
                                                                         [(UINavigationController *)self.window.rootViewController pushViewController:dashViewc animated:YES];
                                                                         
                                                                     });
                                                      
                                                  }
                                                  else
                                                  {
                                                      
                                                  }
                                                  
                                                  
                                              }];
        
        [postDataTask resume];
    }
    else
    {
        
    }
    
}



// [END signin_handler]

// This callback is triggered after the disconnect call that revokes data
// access to the user's resources has completed.
// [START disconnect_handler]
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // [START_EXCLUDE]
    NSDictionary *statusText = @{@"statusText": @"Disconnected user" };
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ToggleAuthUINotification"
     object:nil
     userInfo:statusText];
    // [END_EXCLUDE]
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //As we are going into the background, I want to start a background task to clean up the disk caches
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) { //Check if our iOS version supports multitasking I.E iOS 4
        if ([[UIDevice currentDevice] isMultitaskingSupported]) { //Check if device supports mulitasking
            UIApplication *application = [UIApplication sharedApplication]; //Get the shared application instance
            
            __block UIBackgroundTaskIdentifier background_task; //Create a task object
            
            background_task = [application beginBackgroundTaskWithExpirationHandler: ^{
                [application endBackgroundTask:background_task]; //Tell the system that we are done with the tasks
                background_task = UIBackgroundTaskInvalid; //Set the task to be invalid
                //System will be shutting down the app at any point in time now
            }];
            
            //Background tasks require you to use asyncrous tasks
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //Perform your tasks that your application requires
                
                //I do what i need to do here.... synchronously...
                
                [application endBackgroundTask: background_task]; //End the task so the system knows that you are done with what you need to perform
                background_task = UIBackgroundTaskInvalid; //Invalidate the background_task
            });
        }
        
        
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    application.applicationIconBadgeNumber = 0;
    
  }
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
