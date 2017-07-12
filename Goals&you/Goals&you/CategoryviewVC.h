//
//  CategoryviewVC.h
//  Goals&you
//
//  Created by Raindrops Infotech on 18/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "ViewController.h"

@interface CategoryviewVC : ViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,NSURLSessionDelegate>
- (IBAction)addcategorybtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtcategory;
@property (strong, nonatomic) IBOutlet UITableView *tablecategory;
- (IBAction)addnewcategorybtn:(id)sender;
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;
@property (strong, nonatomic) IBOutlet UIView *addview;
- (IBAction)hidebtn2:(id)sender;
- (IBAction)hidebtn1:(id)sender;
- (IBAction)dashboardbtn:(id)sender;
- (IBAction)notificationbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *notificationimg;
@property(strong,nonatomic)NSString *strcategoryaddid;

@end
