//
//  weightlossview.h
//  Goals&you
//
//  Created by Raindrops Infotech on 15/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface weightlossview : UIViewController
- (IBAction)backviewbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *ageview;
- (IBAction)agebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *heightview;
- (IBAction)hrightbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *ageshowbtn;
@property (strong, nonatomic) IBOutlet UIButton *heighshowbtn;
- (IBAction)agehidebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *agepickview;
@property (strong, nonatomic) IBOutlet UIPickerView *agepickr;
@property (strong, nonatomic) IBOutlet UIPickerView *heightpickr;
- (IBAction)hideheightviewbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *heightshowview;
@property (strong, nonatomic) IBOutlet UIView *weightview;
@property (strong, nonatomic) IBOutlet UIButton *weightshowbtn;
- (IBAction)showweightbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *weightpickr;
- (IBAction)weighthidebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *weightpickrview;
- (IBAction)timeselectbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *timeshowbtn;
@property (strong, nonatomic) IBOutlet UIView *timeselectview;
- (IBAction)habitbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *habitview;
@property (strong, nonatomic) IBOutlet UIButton *habitviewbtn;
@property (strong, nonatomic) IBOutlet UITextField *txtadvice;
@property (strong, nonatomic)NSDictionary *dictweight;


- (IBAction)continbtn:(id)sender;

@end
