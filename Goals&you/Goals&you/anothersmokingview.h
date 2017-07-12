//
//  anothersmokingview.h
//  Goals&you
//
//  Created by Raindrops Infotech on 09/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface anothersmokingview : UIViewController<NSURLSessionDelegate>
- (IBAction)backbtns:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cigarscountbtn;
@property (strong, nonatomic) IBOutlet UIView *selctcigarview;
@property (strong, nonatomic) IBOutlet UIButton *yesbtn;
@property (strong, nonatomic) IBOutlet UIButton *nobtn;
- (IBAction)smokeyesbtn:(id)sender;
- (IBAction)smokenobtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *startview;
@property (strong, nonatomic) IBOutlet UIView *enddateview;
@property (strong, nonatomic) IBOutlet UILabel *startdatelbl;
@property (strong, nonatomic) IBOutlet UILabel *enddatelbl;
- (IBAction)enddatebtn:(id)sender;
- (IBAction)donebtnview:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepikr;
@property (strong, nonatomic) IBOutlet UIView *dateview;
@property (strong, nonatomic) NSDictionary *dictsmoke;

@end
