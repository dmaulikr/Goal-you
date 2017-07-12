//
//  smokingview.h
//  Goals&you
//
//  Created by Raindrops Infotech on 08/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface smokingview : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *smokingbtn;
- (IBAction)smokingshowbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblarrow;
@property (strong, nonatomic) IBOutlet UIView *smokingageview;
@property (strong, nonatomic) IBOutlet UILabel *arrowlabel2;
@property (strong, nonatomic) IBOutlet UIButton *cigaratebtn;
- (IBAction)cigarateshowbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *cigaratenumberview;
@property (strong, nonatomic) IBOutlet UIView *chainsmokerview;
- (IBAction)chainsmokerbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *chainsmokershowbtn;
@property (strong, nonatomic) IBOutlet UIView *reasonview;
@property (strong, nonatomic) IBOutlet UITextField *txtreason;
@property (strong, nonatomic) IBOutlet UIView *decisionview;
- (IBAction)backdetailsbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *pickrhabit;
@property (strong, nonatomic) IBOutlet UIView *pickr1view;
- (IBAction)hidepickr1:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *smkingview2;
- (IBAction)selectcigarbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerselect;
@property (strong, nonatomic) IBOutlet UITextField *txtdecision;
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)textFieldDidBeginEditing:(UITextField *)textField;
- (IBAction)nextviewbtn:(id)sender;
@property (strong, nonatomic) NSDictionary *dictsmoke;

@end
