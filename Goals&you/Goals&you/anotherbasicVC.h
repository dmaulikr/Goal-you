//
//  anotherbasicVC.h
//  Goals&you
//
//  Created by Raindrops Infotech on 01/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
@import UserNotifications;

@interface anotherbasicVC : UIViewController<UITextFieldDelegate,NSURLSessionDelegate>
- (IBAction)basicbackbtn:(id)sender;
- (IBAction)continuebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtgoalset;
@property (strong, nonatomic) IBOutlet UIView *sethourview;
@property (strong, nonatomic) IBOutlet UIView *nameview;
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;
@property (strong, nonatomic) IBOutlet UITextField *txtname;
@property(strong,nonatomic)NSDictionary *dicbasic;

@end
