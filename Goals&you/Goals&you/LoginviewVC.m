//
//  LoginviewVC.m
//  Goals&you
//
//  Created by Raindrops Infotech on 18/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "LoginviewVC.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import <FacebookSDK/FacebookSDK.h>
#import <QuartzCore/QuartzCore.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LoginviewVC ()
{
    NSString *stremail;
    NSString *strusername;
    NSString *savedValue;
    NSString *savedValueemail;
    NSString *savedValueid;
    NSString *savedValueshowid;
    NSMutableArray  *arraregister;
    NSDictionary *json1id;
    NSDictionary *jsonDictionary;
    NSString *strsavename;
    NSString *strsaveemail;
    NSString *strsaveid;
    NSString *savedValueusername;
    NSString *savedValueusernamelocal;
    NSString *savedValueusergoogle;
    NSString *fbgender;
    NSString * fbuser_id;
    NSString *strshowgoogleuserid;
    NSString *strshowgoogleusername;




}
-(void)toggleHiddenState:(BOOL)shouldHide;

@end

@implementation LoginviewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testInternetConnection];
    [GIDSignIn sharedInstance].uiDelegate = self;
    [self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    self.lblLoginStatus.hidden=YES;
    _disconnectButton.hidden=YES;
    _signOutButton.hidden=YES;
    _googleloginstatus.hidden=YES;
    _txtusername.userInteractionEnabled=YES;
    _txtpassword.userInteractionEnabled=YES;
//    self.lblUsername.hidden=YES;
    self.lblEmail.hidden=YES;
    _signoutview.hidden=YES;
    self.loginButton.delegate = self;
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    savedValueusername = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceusername"];
    savedValueusernamelocal = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"preferencenamelocal"];
    savedValueusergoogle = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"preferenceuseremailgoogle"];
    strshowgoogleuserid=[[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceuseridgoogle"];
    strshowgoogleusername=[[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceusernamegoogle"];
    _usernameview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _usernameview.layer.borderWidth = 1.0f;
    _passwordview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _passwordview.layer.borderWidth = 1.0f;
    if (savedValueusernamelocal.length>0)
    {
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:@"Message"
//                                     message:@"You are already Login! You need to First Logout for Login"
//                                     preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
//        
//        UIAlertAction* yesButton = [UIAlertAction
//                                    actionWithTitle:@"Ok"
//                                    style:UIAlertActionStyleDefault
//                                    handler:^(UIAlertAction * action)
//                                    {
//                                        //Handle your yes please button action here
//                                    }];
//        
//        [alert addAction:yesButton];
       // [self presentViewController:alert animated:YES completion:nil];
        _loginbtn.userInteractionEnabled=NO;

    }
    if (savedValueusername.length>0)
    {
        _txtusername.userInteractionEnabled=NO;
        _txtpassword.userInteractionEnabled=NO;
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:@"Message"
//                                     message:@"You are already Login! You Need to First Logout for Login"
//                                     preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
//        UIAlertAction* yesButton = [UIAlertAction
//                                    actionWithTitle:@"Ok"
//                                    style:UIAlertActionStyleDefault
//                                    handler:^(UIAlertAction * action)
//                                    {
//                                        //Handle your yes please button action here
//                                    }];
//        
//        [alert addAction:yesButton];
//        [self presentViewController:alert animated:YES completion:nil];
//        _loginButton.userInteractionEnabled=NO;
        _loginbtn.userInteractionEnabled=NO;
    }
    if (savedValueusergoogle.length>0)
    {
        _loginbtn.userInteractionEnabled=NO;
        _googleloginstatus.hidden=NO;
        _googleloginbtn.hidden=NO;
        _signOutButton.hidden=NO;
        _disconnectButton.hidden=NO;
        _loginButton.userInteractionEnabled=NO;
        _signInButton.hidden=YES;
        _signoutview.hidden=NO;
        _txtusername.userInteractionEnabled=NO;
        _txtpassword.userInteractionEnabled=NO;
        
    }
  
    // Do any additional setup after loading the view.
}
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController
{
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController
{
//    if (savedValueusergoogle.length>0)
//    {
        _loginButton.userInteractionEnabled=NO;
        _disconnectButton.hidden=NO;
        _signOutButton.hidden=NO;
        _googleloginstatus.hidden=NO;
        _loginbtn.userInteractionEnabled=NO;
        _googleloginbtn.hidden=YES;
    _txtusername.userInteractionEnabled=NO;
    _txtpassword.userInteractionEnabled=NO;
    [self dismissViewControllerAnimated:YES completion:nil];
   // [self googlelogin];
  //  [self performSegueWithIdentifier:@"googletodashboard-id" sender:self];

//    }
//    else
//    {
//        [self dismissViewControllerAnimated:YES completion:nil];
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:@"Message"
//                                     message:@"You are Not Login Please Allow first While you Login in Google"
//                                     preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
//        UIAlertAction* yesButton = [UIAlertAction
//                                    actionWithTitle:@"Ok"
//                                    style:UIAlertActionStyleDefault
//                                    handler:^(UIAlertAction * action)
//                                    {
//                                        //Handle your yes please button action here
//                                    }];
//        
//        [alert addAction:yesButton];
//        [self presentViewController:alert animated:YES completion:nil];
//    }
}

- (IBAction)didTapSignOut:(id)sender
{
    _loginButton.userInteractionEnabled=YES;
    _loginbtn.userInteractionEnabled=YES;
    [[GIDSignIn sharedInstance] signOut];
    _disconnectButton.hidden=YES;
    _signOutButton.hidden=YES;
    _googleloginstatus.hidden=YES;
    _googleloginbtn.hidden=NO;
    _signoutview.hidden=YES;
    _txtusername.userInteractionEnabled=YES;
    _txtpassword.userInteractionEnabled=YES;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"preferenceuseremailgoogle"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"preferenceuseridgoogle"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"preferenceusernamegoogle"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    savedValueusergoogle = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"preferenceuseremailgoogle"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private method implementation

-(void)toggleHiddenState:(BOOL)shouldHide
{
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
}

#pragma mark - FBLoginView Delegate method implementation

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    self.lblLoginStatus.text = @"You are logged in.";
    [self toggleHiddenState:NO];
    self.lblLoginStatus.hidden=YES;
//    self.lblUsername.hidden=YES;
    self.lblEmail.hidden=YES;
    self.lblloginas.hidden=NO;
    _googleloginbtn.hidden=YES;
    _disconnectButton.hidden=YES;
    _signOutButton.hidden=YES;
    _txtusername.userInteractionEnabled=NO;
    _txtpassword.userInteractionEnabled=NO;
    if ([_logoutstr containsString:@"time to logout"])
    {
        
    }
    else
    {
        [self performSegueWithIdentifier:@"basicdetails-id" sender:self];
//        [self performSegueWithIdentifier:@"googletodashboard-id" sender:self];
    }
   
}
-(void)loginuser
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status==ReachableViaWiFi || status==ReachableViaWWAN)
    {

    [_txtusername resignFirstResponder];
    [_txtpassword resignFirstResponder];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"";
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.0];
    hud.bezelView.backgroundColor = [UIColor clearColor];
    NSArray *keys = [NSArray arrayWithObjects:@"op",@"username",@"password", nil];
    NSArray *objects = [NSArray arrayWithObjects:@"Login",_txtusername.text,_txtpassword.text,nil];// need array of more than one string or data posted
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
                                             // NSString *strnsuserid;
                                             // NSString *strnsuseremailid;
                                              // NSLog(@"data printed:%@",data);
                                              if (data.length>0)
                                              {
                                              NSDictionary *jsonid = [NSJSONSerialization JSONObjectWithData:data
                                                                                                     options:NSJSONReadingMutableContainers
                                                                                                       error:&jsonError];
                                              NSString *strmessage=[NSString stringWithFormat:@"%@",[jsonid valueForKey:@"message"]];
//                                              arraylogin=[jsonid valueForKey:@"Logindetails"];
                                              if ([strmessage containsString:@"fail"])
                                              {
                                                  UIAlertController * alert = [UIAlertController
                                                                               alertControllerWithTitle:@"ERROR"
                                                                               message:@"Username OR Password is Incorrect!"
                                                                               preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
                                                  
                                                  UIAlertAction* yesButton = [UIAlertAction
                                                                              actionWithTitle:@"Ok"
                                                                              style:UIAlertActionStyleDefault
                                                                              handler:^(UIAlertAction * action)
                                                  {
                                                                                  //Handle your yes please button action here
                                                                              }];
                                                  
                                                  [alert addAction:yesButton];
                                                  [self presentViewController:alert animated:YES completion:nil];
                                                 // [hud hideAnimated:YES];
                                                  //                                                      [postDataTask suspend];
                                                  
                                              }
                                              else
                                              {
                                                  strsaveid=[NSString stringWithFormat:@"%@",[[jsonid valueForKey:@"message"] valueForKey:@"id"]];
                                                  strsaveemail=[NSString stringWithFormat:@"%@",[[jsonid valueForKey:@"message"] valueForKey:@"email"]];
                                                   strsavename=[NSString stringWithFormat:@"%@",[[jsonid valueForKey:@"message"] valueForKey:@"username"]];
                                                  [[NSUserDefaults standardUserDefaults] setObject:strsaveid forKey:@"preferenceidlocal"];
                                                  [[NSUserDefaults standardUserDefaults] synchronize];
                                                 // NSString *savedValue1 = [[NSUserDefaults standardUserDefaults]
                                                                         // stringForKey:@"preferenceidlocal"]; //for retrive values of user
                                                  //savedValueid=savedValue;
                                                  //  NSLog(@"saved userdefaults string:%@",savedValue);
                                                  [[NSUserDefaults standardUserDefaults] setObject:strsaveemail forKey:@"preferenceemaillocal"];
                                                   [[NSUserDefaults standardUserDefaults] setObject:strsavename forKey:@"preferencenamelocal"];
                                                  [[NSUserDefaults standardUserDefaults] synchronize];
                                                  // NSLog(@"saved userdefaults stringemail:%@",strnsuserid);
                                                  dispatch_async(dispatch_get_main_queue(),
                                                                 ^{
                                                                     [self performSegueWithIdentifier:@"categoryback-id" sender:self];

                                                                 });
                                              }
                                            }
                                              else
                                              {
                                                  UIAlertController * alert = [UIAlertController
                                                                             alertControllerWithTitle:@"ERROR"
                                                                             message:@"Retry Please connection lost!"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                                                  UIAlertAction* yesButton = [UIAlertAction
                                                                              actionWithTitle:@"Ok"
                                                                              style:UIAlertActionStyleDefault
                                                                              handler:^(UIAlertAction * action) {
                                                                                  //Handle your yes please button action here
                                                                              }];
                                                  
                                                  [alert addAction:yesButton];
                                                  [self presentViewController:alert animated:YES completion:nil];
                                              }
                                          }];
    
    [postDataTask resume];
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"ERROR"
                                     message:@"No internet connectivity "
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
//save user details facebook
-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    [FBRequestConnection startWithGraphPath:@"me"
                                 parameters:@{@"fields": @"first_name, last_name,birthday,gender, picture.type(normal), email"}
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
                                {
                              if (!error) {
                                  // Set the use full name.
                                  self.lblEmail.text = [result objectForKey:@"email"];
                                  fbgender=[result objectForKey:@"gender"];
                                  fbuser_id=[result objectForKey:@"id"];
                                  stremail=[result objectForKey:@"email"];
                                  [[NSUserDefaults standardUserDefaults] setObject:stremail forKey:@"preferenceemail"];
                                  savedValue = [[NSUserDefaults standardUserDefaults]
                                                stringForKey:@"preferenceemail"]; //for retrive values of user
                                  savedValueemail=savedValue;
                                  [[NSUserDefaults standardUserDefaults] synchronize];
                                  [self fblogin];
                              }
                              else
                              {
                                  NSLog(@"%@", [error localizedDescription]);
                              }
                          }];
//    self.profilePicture.profileID = user.objectID;
    self.lblUsername.text = user.name;
    strusername=user.name;
    [[NSUserDefaults standardUserDefaults] setObject:strusername forKey:@"preferenceusername"];
    savedValueid = [[NSUserDefaults standardUserDefaults]
                  stringForKey:@"preferenceusername"];
    savedValueshowid=savedValueid;
    [[NSUserDefaults standardUserDefaults] synchronize];
    //  self.lblEmail.text = [user objectForKey:@"email"];
}

-(void)fblogin
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status==ReachableViaWiFi || status==ReachableViaWWAN)
    {
        
        NSArray *keys = [NSArray arrayWithObjects:@"op",@"email",@"gender",@"username", nil];
        NSArray *objects = [NSArray arrayWithObjects:@"LoginFB",stremail,fbgender,fbuser_id,nil];// need array of more than one string or data posted
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
                                                      NSLog(@"fb: %@",jsonidstore);
                                                      dispatch_async(dispatch_get_main_queue(),
                                                                     ^{
                                                                         //arracategory=[jsonidstore valueForKey:@"message"];
                                                                         
                                                                     });
                                                      
                                                  }
                                                  else
                                                  {
                                                      UIAlertController * alert = [UIAlertController
                                                                                   alertControllerWithTitle:@"ERROR"
                                                                                   message:@"No internet connectivity "
                                                                                   preferredStyle:UIAlertControllerStyleAlert];
                                                      
                                                      UIAlertAction* yesButton = [UIAlertAction
                                                                                  actionWithTitle:@"Ok"
                                                                                  style:UIAlertActionStyleDefault
                                                                                  handler:^(UIAlertAction * action) {
                                                                                      //Handle your yes please button action here
                                                                                  }];
                                                      
                                                      [alert addAction:yesButton];
                                                      [self presentViewController:alert animated:YES completion:nil];
                                                      
                                                  }
                                                  
                                                  
                                              }];
        
        [postDataTask resume];
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"ERROR"
                                     message:@"No internet connectivity"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}
//-(void)googlelogin
//{
//    Reachability *reachability = [Reachability reachabilityForInternetConnection];
//    [reachability startNotifier];
//    
//    NetworkStatus status = [reachability currentReachabilityStatus];
//    
//    if(status==ReachableViaWiFi || status==ReachableViaWWAN)
//    {
//        NSArray *keys = [NSArray arrayWithObjects:@"op",@"email",@"userid",@"username", nil];
//        NSArray *objects = [NSArray arrayWithObjects:@"LoginGmail",savedValueusergoogle,strshowgoogleuserid,strshowgoogleusername,nil];// need array of more than one string or data posted
//        NSError *error;
//        
//        jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];// for array or more than string values
//        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
//        NSURL *url = [NSURL URLWithString:@"http://192.168.1.33/pro/Webservice/habbits/index.php"];
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                           timeoutInterval:3.0f];
//        
//        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        
//        [request setHTTPMethod:@"POST"];
//        
//        NSData *postData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:&error];
//        [request setHTTPBody:postData];
//        
//        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
//                                              {
//                                                  NSError *jsonError;
//                                                  if(data.length>0)
//                                                  {
//                                                      NSDictionary *jsonidstore = [NSJSONSerialization JSONObjectWithData:data
//                                                                                                                  options:NSJSONReadingMutableContainers
//                                                                                                                    error:&jsonError];
//                                                      NSLog(@"google: %@",jsonidstore);
//                                                      dispatch_async(dispatch_get_main_queue(),
//                                                                     ^{
//                                                                         //arracategory=[jsonidstore valueForKey:@"message"];
//                                                                         [self performSegueWithIdentifier:@"googletodashboard-id" sender:self];
//
//                                                                         
//                                                                     });
//                                                      
//                                                  }
//                                                  else
//                                                  {
//                                                      UIAlertController * alert = [UIAlertController
//                                                                                   alertControllerWithTitle:@"ERROR"
//                                                                                   message:@"No internet connectivity "
//                                                                                   preferredStyle:UIAlertControllerStyleAlert];
//                                                      
//                                                      UIAlertAction* yesButton = [UIAlertAction
//                                                                                  actionWithTitle:@"Ok"
//                                                                                  style:UIAlertActionStyleDefault
//                                                                                  handler:^(UIAlertAction * action) {
//                                                                                      //Handle your yes please button action here
//                                                                                  }];
//                                                      
//                                                      [alert addAction:yesButton];
//                                                      [self presentViewController:alert animated:YES completion:nil];
//                                                      
//                                                  }
//                                                  
//                                                  
//                                              }];
//        
//        [postDataTask resume];
//    }
//    else
//    {
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:@"ERROR"
//                                     message:@"No internet connectivity"
//                                     preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction* yesButton = [UIAlertAction
//                                    actionWithTitle:@"Ok"
//                                    style:UIAlertActionStyleDefault
//                                    handler:^(UIAlertAction * action) {
//                                        //Handle your yes please button action here
//                                    }];
//        
//        [alert addAction:yesButton];
//        [self presentViewController:alert animated:YES completion:nil];
//        
//    }
//    
//}
//

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    self.lblLoginStatus.text = @"You are logged out";
    [self toggleHiddenState:YES];
    self.lblloginas.hidden=YES;
    _googleloginbtn.hidden=NO;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"preferenceemail"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"preferenceusername"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _txtusername.userInteractionEnabled=YES;
    _txtpassword.userInteractionEnabled=YES;
    _loginbtn.userInteractionEnabled=YES;

}


-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Message"
                                 message:@"You need to Login First for Further Process."
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];

    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)testInternetConnection
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"ERROR"
                                     message:@"No internet connectivity "
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"";
        [hud showAnimated:YES];
        
        
    }
    else if (status == ReachableViaWiFi)
    {
        //WiFi
    }
    else if (status == ReachableViaWWAN)
    {
        //3G
    }
}

-(IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    [_txtusername resignFirstResponder];
    [_txtpassword resignFirstResponder];
}
- (IBAction)loginbtn:(id)sender
{
    if (!(_txtpassword.text.length==0) && !(_txtusername.text.length==0))
    {
        if (savedValueusergoogle.length>0 || savedValueusername.length>0)
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Alert"
                                         message:@"You Are Already Logged in!"
                                         preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                        }];
            
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            [self loginuser];

        }
        
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"ERROR"
                                     message:@"Please Insert Username OR Password"
                                     preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)registration:(id)sender
{
    
}
- (IBAction)cancelbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
//   [self performSegueWithIdentifier:@"logindash-id" sender:sender];
}
- (IBAction)nextbtn:(id)sender
{
    if ([self.lblLoginStatus.text isEqualToString:@"You are logged in."])
    {
        NSLog(@"send to next page");
    }
    if (_txtusername.text.length>0 && _txtpassword.text.length>0)
    {
        NSLog(@"call the next method");
    }
   
}
- (IBAction)googleloginbutton:(id)sender
{
    
}

- (IBAction)signupbtn:(id)sender
{
    [self performSegueWithIdentifier:@"signuppage-id" sender:sender];

    
}
- (IBAction)notificabtn:(id)sender
{
    [self performSegueWithIdentifier:@"logindash-id" sender:sender];
   
}
@end
