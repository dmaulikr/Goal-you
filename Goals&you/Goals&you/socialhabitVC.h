//
//  socialhabitVC.h
//  Goals&you
//
//  Created by Raindrops Infotech on 16/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface socialhabitVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *hourview;
- (IBAction)selecthourbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *hourpickr;
- (IBAction)hidebtnview:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *pickrview;
- (IBAction)backsbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *hourselectbtn;
@property (strong, nonatomic) IBOutlet UIView *averagetimeview;
- (IBAction)averagetimebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *averagetimepickr;
- (IBAction)averagepickrhidebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *timeaverageview;
@property (strong, nonatomic) IBOutlet UIView *selectaveragetimeview;
@property (strong, nonatomic) IBOutlet UIButton *selectaveragetimebtn;
@property (strong, nonatomic) IBOutlet UIView *dayview;
- (IBAction)daybtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *daysetbtn;
@property (strong, nonatomic) IBOutlet UIButton *socialselectbtn;
@property (strong, nonatomic) IBOutlet UIView *selectsocialview;
- (IBAction)socialselectshowbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *selectplatformview;
- (IBAction)selectplatformbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tablplatform;
- (IBAction)nextbtn:(id)sender;
@property (strong, nonatomic) NSDictionary *dictsocial;
@property (strong, nonatomic) NSArray *arrplatform;

@end
