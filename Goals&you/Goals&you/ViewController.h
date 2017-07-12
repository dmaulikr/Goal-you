//
//  ViewController.h
//  Goals&you
//
//  Created by Raindrops Infotech on 17/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)readybtn:(id)sender;
- (IBAction)profilebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *profileview;
- (IBAction)cancelbtn:(id)sender;
- (IBAction)loginbtn:(id)sender;
- (IBAction)signupbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *profilebtn;
@property (strong, nonatomic) IBOutlet UIButton *readybtn;

@end

