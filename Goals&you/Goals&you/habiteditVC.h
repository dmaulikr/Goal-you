//
//  habiteditVC.h
//  Goals&you
//
//  Created by Raindrops Infotech on 02/02/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "ViewController.h"

@interface habiteditVC : ViewController

- (IBAction)backbtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewend;
@property (strong, nonatomic) IBOutlet UIView *viewstart;
@property (strong, nonatomic) IBOutlet UIView *viewshow;
@property (strong, nonatomic) IBOutlet UIView *habitview;
@property (strong, nonatomic) IBOutlet UITextField *txthabitname;
@property (strong, nonatomic) IBOutlet UITextField *txthabitstart;
@property (strong, nonatomic) IBOutlet UITextField *txthabitend;
@property (strong, nonatomic) IBOutlet UITextField *txtemail;

@end
