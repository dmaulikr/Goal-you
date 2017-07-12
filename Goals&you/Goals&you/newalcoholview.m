//
//  newalcoholview.m
//  Goals&you
//
//  Created by Raindrops Infotech on 07/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "newalcoholview.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

@interface newalcoholview ()
{
    NSDictionary *jsonDictionary;
    NSString *yesnostr;
}
@end

@implementation newalcoholview

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testInternetConnection];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMMM-yyyy"];
    _lblstartdate.text = [dateFormat stringFromDate:date];
    _startview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _startview.layer.borderWidth = 1.0f;
    _endview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _endview.layer.borderWidth = 1.0f;
    _enddateview.hidden=YES;
    NSLog(@"data%@",_dictalcohol);

    // Do any additional setup after loading the view.
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

- (IBAction)yesaction:(id)sender
{
    _yesbtn.backgroundColor=[UIColor colorWithRed:(1/255.0) green:(87/255.0) blue:(155/255.0) alpha:1];
    _nobtn.backgroundColor=[UIColor lightGrayColor];
    yesnostr=@"yes";
}

- (IBAction)noaction:(id)sender
{
    _yesbtn.backgroundColor=[UIColor lightGrayColor];
    _nobtn.backgroundColor=[UIColor colorWithRed:(1/255.0) green:(87/255.0) blue:(155/255.0) alpha:1];
    yesnostr=@"no";
}
- (IBAction)backviewbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)enddatebtn:(id)sender
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMMM-yyyy"];
    [_enddatepickr setMinimumDate:date];
    NSDate* now = [NSDate date] ;
    //.......maximum date from today to one month...../
    // Get current NSDate without seconds & milliseconds, so that I can better compare the chosen date to the minimum & maximum dates.
    NSCalendar* calendar = [NSCalendar currentCalendar] ;
    NSDateComponents* nowWithoutSecondsComponents = [calendar components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:now] ;
    NSDate* nowWithoutSeconds = [calendar dateFromComponents:nowWithoutSecondsComponents] ;
    //  UIDatePicker* picker ;
    _enddatepickr.minimumDate = nowWithoutSeconds ;
    
    NSDateComponents* addOneMonthComponents = [NSDateComponents new] ;
    addOneMonthComponents.month = 1;
    NSDate* oneMonthFromNowWithoutSeconds = [calendar dateByAddingComponents:addOneMonthComponents toDate:nowWithoutSeconds options:0] ;
    _enddatepickr.maximumDate = oneMonthFromNowWithoutSeconds ;
    if (_enddateview.hidden==YES)
    {
        _enddateview.hidden=NO;
    }
    else
    {
        _enddateview.hidden=YES;
    }

}
- (IBAction)enddonebtn:(id)sender
{
    _enddateview.hidden=YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMMM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:_enddatepickr.date];
    _lblenddate.text=strDate;
}
- (IBAction)donebtn:(id)sender
{
    if (_dictalcohol>0)
    {
        [self sendata];

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
@end
