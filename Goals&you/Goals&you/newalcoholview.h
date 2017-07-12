//
//  newalcoholview.h
//  Goals&you
//
//  Created by Raindrops Infotech on 07/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newalcoholview : UIViewController<NSURLSessionDelegate,NSURLSessionDelegate>
@property (strong, nonatomic) IBOutlet UIButton *yesbtn;
@property (strong, nonatomic) IBOutlet UIButton *nobtn;
- (IBAction)yesaction:(id)sender;
- (IBAction)noaction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *startview;
@property (strong, nonatomic) IBOutlet UILabel *lblstartdate;
- (IBAction)backviewbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *endview;
- (IBAction)enddatebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblenddate;
@property (strong, nonatomic) IBOutlet UIView *enddateview;
- (IBAction)enddonebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *enddatepickr;
- (IBAction)donebtn:(id)sender;
@property (strong, nonatomic) NSDictionary *dictalcohol;

@end
