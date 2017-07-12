//
//  RegistrationVC.h
//  Goals&you
//
//  Created by Raindrops Infotech on 24/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "ViewController.h"

@interface RegistrationVC : ViewController<UITextFieldDelegate,NSURLSessionDelegate>
- (IBAction)backbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtname;
@property (strong, nonatomic) IBOutlet UITextField *txtpassword;
@property (strong, nonatomic) IBOutlet UITextField *txtemail;
@property (strong, nonatomic) IBOutlet UITextField *txtage;
@property (strong, nonatomic) IBOutlet UIButton *femalebtn;
@property (strong, nonatomic) IBOutlet UIButton *malebtn;
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)registerbtn:(id)sender;
- (IBAction)malebtn:(id)sender;
- (IBAction)femalebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *usernameview;
@property (strong, nonatomic) IBOutlet UIView *passwordview;
@property (strong, nonatomic) IBOutlet UIView *emailview;
@property (strong, nonatomic) IBOutlet UIView *ageview;

@end
