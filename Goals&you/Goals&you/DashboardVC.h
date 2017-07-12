//
//  DashboardVC.h
//  Goals&you
//
//  Created by Raindrops Infotech on 23/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "ViewController.h"

@interface DashboardVC : ViewController<UITableViewDataSource,UITableViewDelegate,NSURLSessionDelegate>
- (IBAction)accountsbtn:(id)sender;

@property (strong, nonatomic)NSString *logoutstr;
@property (strong, nonatomic)NSString *logoutstring;
- (IBAction)categorybtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tablmygoal;
@property (strong, nonatomic) IBOutlet UITableView *tablattendedgoal;
- (IBAction)notificationbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *notificationimg;
@property (strong, nonatomic) IBOutlet UIButton *habitbtn;
@property (strong, nonatomic) IBOutlet UIButton *notificationbtn;
@property (strong, nonatomic) IBOutlet UIButton *userbtn;

@end
