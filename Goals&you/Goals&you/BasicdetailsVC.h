//
//  BasicdetailsVC.h
//  Goals&you
//
//  Created by Raindrops Infotech on 18/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "ViewController.h"

@interface BasicdetailsVC : ViewController<UITextFieldDelegate,NSURLSessionDelegate>
@property (strong, nonatomic) IBOutlet UIView *dateview;
- (IBAction)donebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *endlbldate;
- (IBAction)btnenddate:(id)sender;
- (IBAction)btnstartdate:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *startlbldate;
@property (strong, nonatomic) IBOutlet UIView *dateview2;
- (IBAction)donebtn2:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepickr1;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepickr2;
@property (strong, nonatomic) IBOutlet UITextField *txtweight;
@property (strong, nonatomic) IBOutlet UIView *birthdateview;
@property (strong, nonatomic) IBOutlet UIDatePicker *birthdatepickr;
@property (strong, nonatomic) IBOutlet UILabel *birthdatelabel;
- (IBAction)birthdatedonebtn:(id)sender;
- (IBAction)birthdatebtn:(id)sender;
- (IBAction)startbtn:(id)sender;
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)textFieldDidBeginEditing:(UITextField *)textField;
@property (strong, nonatomic) IBOutlet UITextField *txtemail;
- (IBAction)backbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnstartdate;
@property (strong, nonatomic) IBOutlet UITextField *txtsendname;

@property (strong, nonatomic) IBOutlet UIButton *btnenddate;
@property (strong, nonatomic) IBOutlet UIButton *btnbirthdate;
@property (strong, nonatomic) IBOutlet UIView *startdateview;
@property (strong, nonatomic) IBOutlet UIView *enddatebtnview;
@property (strong, nonatomic) IBOutlet UIView *birthdatebtnview;
@property (strong, nonatomic) IBOutlet UIView *weightview;
@property (weak, nonatomic) IBOutlet UIView *enternameview;
@property (strong, nonatomic) IBOutlet UITextField *txtpersonemil;
@property (strong, nonatomic) IBOutlet UIView *txtemailview;
- (IBAction)dahbtn:(id)sender;
@property(strong,nonatomic)NSString *strcategoryaddid;
@property(strong,nonatomic)NSDictionary *dicbasic;
@property(strong,nonatomic)UIPickerView *pickrweek;
- (IBAction)listbtn:(id)sender;

- (IBAction)selectypebtn:(id)sender;

@end
