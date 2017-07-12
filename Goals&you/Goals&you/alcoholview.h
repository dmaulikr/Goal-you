//
//  alcoholview.h
//  Goals&you
//
//  Created by Raindrops Infotech on 07/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface alcoholview : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
- (IBAction)backbtn:(id)sender;
- (IBAction)agebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *ageview;
@property (strong, nonatomic) IBOutlet UIView *ageselectview;
- (IBAction)hideageview:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *agepickr;
@property (strong, nonatomic) IBOutlet UILabel *arrowlbl;
@property (strong, nonatomic) IBOutlet UIButton *agebtn;
@property (strong, nonatomic) IBOutlet UIButton *selectsipbtn;
- (IBAction)selectsip:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *selectsipview;
@property (strong, nonatomic) IBOutlet UILabel *arrowlabl2;
@property (strong, nonatomic) IBOutlet UIView *selectnumberview;
@property (strong, nonatomic) IBOutlet UIPickerView *pickrselect;
- (IBAction)hideselectview:(id)sender;
- (IBAction)selectmonthbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *monthselectview;
@property (strong, nonatomic) IBOutlet UIButton *selectmonthbuttn;
@property (strong, nonatomic) IBOutlet UIView *textview;
@property (strong, nonatomic) IBOutlet UITextField *txtname;
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)limitbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *limitbuttn;
@property (strong, nonatomic) IBOutlet UIView *goalsetview;
- (IBAction)continuebtn:(id)sender;
@property (strong, nonatomic) NSDictionary *dictalcohol;

@end
