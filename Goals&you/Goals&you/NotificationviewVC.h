//
//  NotificationviewVC.h
//  Goals&you
//
//  Created by Raindrops Infotech on 01/02/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "ViewController.h"
#import "SWTableViewCell.h"




@interface NotificationviewVC : ViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,NSURLSessionDelegate,SWTableViewCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tablnotification;
- (IBAction)backbtn:(id)sender;
- (IBAction)readallbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *readall;

@end
