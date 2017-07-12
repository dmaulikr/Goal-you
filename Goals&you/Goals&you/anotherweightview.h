//
//  anotherweightview.h
//  Goals&you
//
//  Created by Raindrops Infotech on 16/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface anotherweightview : UIViewController
- (IBAction)backbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtview;
@property (strong, nonatomic) IBOutlet UIView *textview;
@property (strong, nonatomic) IBOutlet UIView *adviceview;
@property (strong, nonatomic) IBOutlet UIButton *advicebtn;
- (IBAction)showadvicebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *startdateview;
@property (strong, nonatomic) IBOutlet UILabel *starrtdatelbl;
@property (strong, nonatomic) IBOutlet UIPickerView *pickrmonth;
- (IBAction)hideviewbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *pickrview;
- (IBAction)enddatebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *enddatelbl;
@property (strong, nonatomic) IBOutlet UIView *endadateview;
@property (strong, nonatomic) IBOutlet UIView *enddatebtnview;
- (IBAction)viewhidebtn:(id)sender;
@property (strong, nonatomic)NSDictionary *dictweight;

@property (strong, nonatomic) IBOutlet UIDatePicker *enddatepickr;
@property (strong, nonatomic) IBOutlet UIView *inspirtxt;
@property (strong, nonatomic) IBOutlet UITextField *inspiretxt;

@end
