//
//  anotherbasicVC.m
//  Goals&you
//
//  Created by Raindrops Infotech on 01/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//
#define MAX_LENGTH 2
#import "anotherbasicVC.h"
#import "Reachability.h"
#import "MBProgressHUD.h"


@interface anotherbasicVC ()
{
    NSString *strsaveidlocal;
    NSDictionary *jsonDictionary;

}
@end

@implementation anotherbasicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testInternetConnection];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    _txtgoalset.inputAccessoryView=numberToolbar;
    _sethourview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _sethourview.layer.borderWidth = 1.0f;
    _nameview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _nameview.layer.borderWidth = 1.0f;
    strsaveidlocal = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"preferenceidlocal"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cancelNumberPad
{
    [_txtgoalset resignFirstResponder];
    _txtgoalset.text=@"";
}
- (void)testInternetConnection
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"ERROR"
                                     message:@"No internet connectivity "
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
       
    }
    else if (status == ReachableViaWiFi)
    {
        //WiFi
       
    }
    else if (status == ReachableViaWWAN)
    {
        //3G
    }
}
-(IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_txtname isFirstResponder])
    {
        [_txtname resignFirstResponder];
    }
}

-(void)doneWithNumberPad
{
    [_txtgoalset resignFirstResponder];
//    if ([_txtsendname isFirstResponder])
//    {
//        [_txtsendname resignFirstResponder];
//    }
//    else
//    {
//        weightstring = _txtweight.text;
//        [_txtweight resignFirstResponder];
//    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([_txtgoalset isFirstResponder])
    {
        if (textField.text.length >= MAX_LENGTH-1 && range.length == 0)
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Message"
                                         message:@"Please Enter Proper Time!"
                                         preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            //Handle your yes please button action here
                                        }];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
            [_txtgoalset resignFirstResponder];
            return NO; // return NO to not change text
        }
        else
        {
            return YES;
        }
    }
    return 0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)basicbackbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)sendata
{
    //{"op":"addHabbitDetails","user_id":"1176","cat_id":"1","start_date":"01-february-2017","end_date":"25-february-2017","weight":"56","birth_date":"28-march-1993","person_name":"viral","person_email":"viral@raindropsinfotech.com"}
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status==ReachableViaWiFi || status==ReachableViaWWAN)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text=@"";
        [hud showAnimated:YES];
        hud.bezelView.backgroundColor = [UIColor clearColor];
        NSArray *keys = [NSArray arrayWithObjects:@"op",@"user_id",@"cat_id",@"start_date",@"end_date", nil];
        NSArray *objects = [NSArray arrayWithObjects:@"Alcoholhabit",@"",@"",@"",@"",nil];// need array of more than one string or data posted
        NSError *error;
        
        jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];// for array or more than string values
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.33/pro/Webservice/habbits/index.php"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:3.0f];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPMethod:@"POST"];
        NSData *postData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:&error];
        [request setHTTPBody:postData];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                              {
                                                  NSError *jsonError;
                                                  // NSString *strnsuserid;
                                                  // NSString *strnsuseremailid;
                                                  // NSLog(@"data printed:%@",data);
                                                  if (data.length>0)
                                                  {
                                                      NSDictionary *jsonid = [NSJSONSerialization JSONObjectWithData:data
                                                                                                             options:NSJSONReadingMutableContainers
                                                                                                               error:&jsonError];
                                                      NSString *strmessage=[NSString stringWithFormat:@"%@",[jsonid valueForKey:@"message"]];
                                                      NSLog(@"message:%@",strmessage);
                                                  }
                                                  else
                                                  {
                                                      UIAlertController * alert = [UIAlertController
                                                                                   alertControllerWithTitle:@"ERROR"
                                                                                   message:@"No data Found!"
                                                                                   preferredStyle:UIAlertControllerStyleAlert];
                                                      UIAlertAction* yesButton = [UIAlertAction
                                                                                  actionWithTitle:@"Ok"
                                                                                  style:UIAlertActionStyleDefault
                                                                                  handler:^(UIAlertAction * action) {
                                                                                      //Handle your yes please button action here
                                                                                  }];
                                                      
                                                      [alert addAction:yesButton];
                                                      [self presentViewController:alert animated:YES completion:nil];
                                                  }
                                              }];
        
        [postDataTask resume];
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"ERROR"
                                     message:@"Retry Please connection lost!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)continuebtn:(id)sender
{
    if (_txtgoalset.text.length>0 && _txtname.text.length>0)
    {
        //send data
        NSDate *now = [NSDate date];
        now = [now dateByAddingTimeInterval:60];//60*60*24*7
        
        NSLog(@"NSDate:%@",now);
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        [calendar setTimeZone:[NSTimeZone localTimeZone]];
        
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitTimeZone fromDate:now];
        
       // NSDate *todaySehri = [calendar dateFromComponents:components]; //unused
        
        
        
        UNMutableNotificationContent *objNotificationContent = [[UNMutableNotificationContent alloc] init];
        objNotificationContent.title = [NSString localizedUserNotificationStringForKey:@"Alert!" arguments:nil];
        objNotificationContent.body = [NSString localizedUserNotificationStringForKey:@"Are you on Your goal?"
                                                                            arguments:nil];
        objNotificationContent.sound = [UNNotificationSound defaultSound];
        
        /// 4. update application icon badge number
        objNotificationContent.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
        
        
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
        
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"ten"
                                                                              content:objNotificationContent trigger:trigger];
        /// 3. schedule localNotification
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (!error)
            {
                NSLog(@"Local Notification succeeded");
            }
            else {
                NSLog(@"Local Notification failed");
            }
        }];

    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                                    alertControllerWithTitle:@"ERROR"
                                                    message:@"Please Insert Proper Details OR Fill All Details"
                                                    preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
                                             UIAlertAction* yesButton = [UIAlertAction
                                                                         actionWithTitle:@"Ok"
                                                                         style:UIAlertActionStyleDefault
                                                                         handler:^(UIAlertAction * action)
                                                                         {
                                                                             //Handle your yes please button action here
                                                                         }];
                                             
                                             [alert addAction:yesButton];
                                             [self presentViewController:alert animated:YES completion:nil];
    }
    
}


@end
