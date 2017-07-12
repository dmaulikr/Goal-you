//
//  socialhabitdetailsVC.h
//  Goals&you
//
//  Created by Raindrops Infotech on 17/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface socialhabitdetailsVC : UIViewController<NSURLSessionDelegate>
- (IBAction)backviewbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *datpickr;
@property (strong, nonatomic) IBOutlet UIView *timeview;
@property (strong, nonatomic) IBOutlet UIView *pickrview;
- (IBAction)socialshowbtn:(id)sender;
- (IBAction)doneviewbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *timeviewbtn;
@property (strong, nonatomic) IBOutlet UIView *timeperiodview;
- (IBAction)selectperiodtimebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *selectperiodviewbtn;
@property (strong, nonatomic) IBOutlet UIView *spendtimeview;
@property (strong, nonatomic) IBOutlet UIButton *spendtimebtn;
- (IBAction)spendtimebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *startview;
@property (strong, nonatomic) IBOutlet UILabel *startlbl;
@property (strong, nonatomic) IBOutlet UIView *enddateview;
@property (strong, nonatomic) IBOutlet UIButton *enddatebtn;
- (IBAction)enddateshowbtn:(id)sender;
- (IBAction)hidedatabtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *endadatepickr;
@property (strong, nonatomic) IBOutlet UIView *pickrenddateview;
@property (strong, nonatomic) NSDictionary *dictsocial;
@property (strong, nonatomic) NSArray *arrplatform;

@end
