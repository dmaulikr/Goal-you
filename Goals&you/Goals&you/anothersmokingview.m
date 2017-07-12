//
//  anothersmokingview.m
//  Goals&you
//
//  Created by Raindrops Infotech on 09/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "anothersmokingview.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

@interface anothersmokingview ()
{
    NSString *strcigarcont;
    NSString *stryesno;
    NSDictionary *jsonDictionary;
}

@end

@implementation anothersmokingview

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMMM-yyyy"];
    _startdatelbl.text = [dateFormat stringFromDate:date];
    _selctcigarview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _selctcigarview.layer.borderWidth = 1.0f;
    _enddateview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _enddateview.layer.borderWidth = 1.0f;
    _startview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _startview.layer.borderWidth = 1.0f;
    _dateview.hidden=YES;
    NSLog(@"...%@",_dictsmoke);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backbtns:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)cigarcountbtn:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select How Many" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
    {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"1" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_cigarscountbtn setTitle:@"1" forState:UIControlStateNormal];
                                [_cigarscountbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strcigarcont=@"1";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"2" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_cigarscountbtn setTitle:@"2" forState:UIControlStateNormal];
                                [_cigarscountbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strcigarcont=@"2";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"3" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_cigarscountbtn setTitle:@"3" forState:UIControlStateNormal];
                                [_cigarscountbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strcigarcont=@"3";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"None" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_cigarscountbtn setTitle:@"None" forState:UIControlStateNormal];
                                [_cigarscountbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strcigarcont=@"none";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (IBAction)smokeyesbtn:(id)sender
{
    _yesbtn.backgroundColor=[UIColor colorWithRed:(1/255.0) green:(87/255.0) blue:(155/255.0) alpha:1];
    _nobtn.backgroundColor=[UIColor lightGrayColor];
    stryesno=@"yes";
}

- (IBAction)smokenobtn:(id)sender
{
    _nobtn.backgroundColor=[UIColor colorWithRed:(1/255.0) green:(87/255.0) blue:(155/255.0) alpha:1];
    _yesbtn.backgroundColor=[UIColor lightGrayColor];
    stryesno=@"no";
}

- (IBAction)enddatebtn:(id)sender
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMMM-yyyy"];
    [_datepikr setMinimumDate:date];
    NSDate* now = [NSDate date] ;
    //.......maximum date from today to one month...../
    // Get current NSDate without seconds & milliseconds, so that I can better compare the chosen date to the minimum & maximum dates.
    NSCalendar* calendar = [NSCalendar currentCalendar] ;
    NSDateComponents* nowWithoutSecondsComponents = [calendar components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:now] ;
    NSDate* nowWithoutSeconds = [calendar dateFromComponents:nowWithoutSecondsComponents] ;
    //  UIDatePicker* picker ;
    _datepikr.minimumDate = nowWithoutSeconds;
    
    NSDateComponents* addOneMonthComponents = [NSDateComponents new] ;
    addOneMonthComponents.month = 1;
    NSDate* oneMonthFromNowWithoutSeconds = [calendar dateByAddingComponents:addOneMonthComponents toDate:nowWithoutSeconds options:0] ;
    _datepikr.maximumDate = oneMonthFromNowWithoutSeconds ;
    if (_dateview.hidden==YES)
    {
        _dateview.hidden=NO;
    }
    else
    {
        _dateview.hidden=YES;
    }

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

- (IBAction)donebtnview:(id)sender
{
    _dateview.hidden=YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMMM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:_datepikr.date];
    _enddatelbl.text=strDate;
    if (_dictsmoke>0)
    {
       // [self sendata];
        
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Alert"
                                     message:@"Please fill all details !"
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
