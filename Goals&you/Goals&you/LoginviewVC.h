//
//  LoginviewVC.h
//  Goals&you
//
//  Created by Raindrops Infotech on 18/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <GoogleSignIn/GoogleSignIn.h>


@interface LoginviewVC : ViewController<UITextFieldDelegate,FBLoginViewDelegate,NSURLSessionDelegate,GIDSignInUIDelegate>
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)loginbtn:(id)sender;
- (IBAction)registration:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtusername;
@property (strong, nonatomic) IBOutlet UITextField *txtpassword;
- (IBAction)cancelbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *headerview;
@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic)NSString *logoutstr;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePicture;
- (IBAction)nextbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblloginas;
@property (strong, nonatomic) IBOutlet UIButton *loginbtn;
@property (strong, nonatomic) IBOutlet UIView *usernameview;
@property (strong, nonatomic) IBOutlet UIView *passwordview;
//@property (strong, nonatomic) IBOutlet UIButton *googleloginbtn;
@property (strong, nonatomic) IBOutlet UILabel *googleloginstatus;
- (IBAction)googleloginbutton:(id)sender;
- (IBAction)signupbtn:(id)sender;
//googlelogin.........
@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;
@property (weak, nonatomic) IBOutlet UILabel *statusText;
@property (strong, nonatomic) IBOutlet GIDSignInButton *googleloginbtn;
@property (strong, nonatomic) IBOutlet UIView *signoutview;
- (IBAction)notificabtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *notificationimg;

@end
