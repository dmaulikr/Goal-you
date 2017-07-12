//
//  socialhabitdetailsVC.m
//  Goals&you
//
//  Created by Raindrops Infotech on 17/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "socialhabitdetailsVC.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

@interface socialhabitdetailsVC ()
{
    NSDictionary *jsonDictionary;
}
@end

@implementation socialhabitdetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
    [self.datpickr setLocale:locale];
    _timeview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _timeview.layer.borderWidth = 1.0f;
    _timeperiodview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _timeperiodview.layer.borderWidth = 1.0f;
    _spendtimeview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _spendtimeview.layer.borderWidth = 1.0f;
    _startview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _startview.layer.borderWidth = 1.0f;
    _enddateview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _enddateview.layer.borderWidth = 1.0f;
    _pickrview.hidden=YES;
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMMM-yyyy"];
    _startlbl.text = [dateFormat stringFromDate:date];
    _pickrenddateview.hidden=YES;
    NSLog(@"arrdata..%@",_arrplatform);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                                                      NSLog(@"message%@",strmessage);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backviewbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)socialshowbtn:(id)sender
{
    _pickrview.hidden=NO;
}

- (IBAction)doneviewbtn:(id)sender
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];
    NSString *strtime;
    strtime= [outputFormatter stringFromDate:self.datpickr.date];
    [_timeviewbtn setTitle:strtime forState:UIControlStateNormal];
    [_timeviewbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     _pickrview.hidden=YES;
}
- (IBAction)selectperiodtimebtn:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"How many time invest?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"0:30 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_selectperiodviewbtn setTitle:@"0:30 Hours" forState:UIControlStateNormal];
                                [_selectperiodviewbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"1 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_selectperiodviewbtn setTitle:@"1 Hours" forState:UIControlStateNormal];
                                [_selectperiodviewbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"1:30 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_selectperiodviewbtn setTitle:@"1:30 Hours" forState:UIControlStateNormal];
                                [_selectperiodviewbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"2 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              [_selectperiodviewbtn setTitle:@"2 Hours" forState:UIControlStateNormal];
                              [_selectperiodviewbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                              [self dismissViewControllerAnimated:YES completion:^{
                              }];
                          }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"2:30 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              [_selectperiodviewbtn setTitle:@"2:30 Hours" forState:UIControlStateNormal];
                              [_selectperiodviewbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                              [self dismissViewControllerAnimated:YES completion:^{
                              }];
                          }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"3 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_selectperiodviewbtn setTitle:@"3 Hours" forState:UIControlStateNormal];
                                [_selectperiodviewbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"More than three hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_selectperiodviewbtn setTitle:@"More than three hours" forState:UIControlStateNormal];
                                [_selectperiodviewbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (IBAction)spendtimebtn:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"How many time?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"1 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_spendtimebtn setTitle:@"1 Hours" forState:UIControlStateNormal];
                                [_spendtimebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"2 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_spendtimebtn setTitle:@"2 Hours" forState:UIControlStateNormal];
                                [_spendtimebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"3 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_spendtimebtn setTitle:@"3 Hours" forState:UIControlStateNormal];
                                [_spendtimebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"4 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_spendtimebtn setTitle:@"4 Hours" forState:UIControlStateNormal];
                                [_spendtimebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"5 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_spendtimebtn setTitle:@"5 Hours" forState:UIControlStateNormal];
                                [_spendtimebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"6 Hours" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_spendtimebtn setTitle:@"6 Hours" forState:UIControlStateNormal];
                                [_spendtimebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (IBAction)enddateshowbtn:(id)sender
{
    _pickrenddateview.hidden=NO;
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMMM-yyyy"];
    [_endadatepickr setMinimumDate:date];
    NSDate* now = [NSDate date] ;
    //.......maximum date from today to one month...../
    // Get current NSDate without seconds & milliseconds, so that I can better compare the chosen date to the minimum & maximum dates.
    NSCalendar* calendar = [NSCalendar currentCalendar] ;
    NSDateComponents* nowWithoutSecondsComponents = [calendar components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:now] ;
    NSDate* nowWithoutSeconds = [calendar dateFromComponents:nowWithoutSecondsComponents] ;
    //  UIDatePicker* picker ;
    _endadatepickr.minimumDate = nowWithoutSeconds ;
    NSDateComponents* addOneMonthComponents = [NSDateComponents new] ;
    addOneMonthComponents.month = 1;
    NSDate* oneMonthFromNowWithoutSeconds = [calendar dateByAddingComponents:addOneMonthComponents toDate:nowWithoutSeconds options:0] ;
    _endadatepickr.maximumDate = oneMonthFromNowWithoutSeconds;
    
}

- (IBAction)hidedatabtn:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMMM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:_endadatepickr.date];
    [_enddatebtn setTitle:strDate forState:UIControlStateNormal];
    [_enddatebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _pickrenddateview.hidden=YES;

}
@end
