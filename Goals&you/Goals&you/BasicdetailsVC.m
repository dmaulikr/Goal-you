//
//  BasicdetailsVC.m
//  Goals&you
//
//  Created by Raindrops Infotech on 18/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//
#define MAX_LENGTH 2
#import "BasicdetailsVC.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#import "anotherbasicVC.h"


@interface BasicdetailsVC ()
{
    NSString *agestring;
    NSString *weightstring;
    NSString *strbirthcal;
    NSDictionary *jsonDictionary;
    NSDictionary *jsonid;
    NSString *strsaveidlocal;
    NSDictionary *dictdetails;


}
@end

@implementation BasicdetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testInternetConnection];
    _dateview.hidden=YES;
    _dateview2.hidden=YES;
    _birthdateview.hidden=YES;
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    _txtweight.inputAccessoryView=numberToolbar;
    _txtsendname.inputAccessoryView=numberToolbar;
    _txtpersonemil.inputAccessoryView=numberToolbar;
    _txtpersonemil.userInteractionEnabled=YES;
    [_datepickr1 setMinimumDate: [NSDate date]];
    [_datepickr2 setMinimumDate:[NSDate date]];
    [_birthdatepickr setMaximumDate:[NSDate date]];
    _startdateview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _startdateview.layer.borderWidth = 1.0f;
    _enddatebtnview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _enddatebtnview.layer.borderWidth = 1.0f;
    _weightview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _weightview.layer.borderWidth = 1.0f;
    _birthdatebtnview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _birthdatebtnview.layer.borderWidth = 1.0f;
    _enternameview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _enternameview.layer.borderWidth = 1.0f;
    _txtemailview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _txtemailview.layer.borderWidth = 1.0f;
    strsaveidlocal = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"preferenceidlocal"];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMMM-yyyy"];
    _startlbldate.text = [dateFormat stringFromDate:date];

   

//    [self.datepickr1 addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];

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
        _btnenddate.userInteractionEnabled=NO;
        _txtemail.userInteractionEnabled=NO;
        _txtsendname.userInteractionEnabled=NO;
        _txtweight.userInteractionEnabled=NO;
    }
    else if (status == ReachableViaWiFi)
    {
        //WiFi
        _btnenddate.userInteractionEnabled=YES;
        _txtemail.userInteractionEnabled=YES;
        _txtsendname.userInteractionEnabled=YES;
        _txtweight.userInteractionEnabled=YES;
        _txtpersonemil.userInteractionEnabled=YES;
    }
    else if (status == ReachableViaWWAN)
    {
        //3G
    }
}

-(void)cancelNumberPad
{
    if ([_txtsendname isFirstResponder])
    {
        [_txtsendname resignFirstResponder];
    }
    if ([_txtweight isFirstResponder])
    {

        [_txtweight resignFirstResponder];
        _txtweight.text = @"";
    }
    else
    {
        [_txtpersonemil resignFirstResponder];
    }
}
-(void)doneWithNumberPad
{
    if ([_txtsendname isFirstResponder])
    {
        [_txtsendname resignFirstResponder];
    }
    if ([_txtweight isFirstResponder])
    {
        weightstring = _txtweight.text;
        [_txtweight resignFirstResponder];
    }
    else
    {
        [_txtpersonemil resignFirstResponder];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([_txtweight isFirstResponder])
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
            [_txtweight resignFirstResponder];
            return NO; // return NO to not change text
        }
        else
        {
            return YES;
        }
    }
    if ([_txtsendname isFirstResponder])
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
            [_txtweight resignFirstResponder];
            return NO; // return NO to not change text
        }
        else
        {
            return YES;
        }
    }
    else
    {
//        return YES;
    }
    return 0;
}
- (void)didReceiveMemoryWarning
{
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
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMMM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:_datepickr1.date];
    self.startlbldate.text = strDate;
}

- (IBAction)donebtn:(id)sender
{
    _dateview.hidden=YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMMM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:_datepickr1.date];
    self.startlbldate.text = strDate;
  
}
- (IBAction)btnenddate:(id)sender
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMMM-yyyy"];
    [_datepickr2 setMinimumDate:date];
    NSDate* now = [NSDate date] ;
    //.......maximum date from today to one month...../
    // Get current NSDate without seconds & milliseconds, so that I can better compare the chosen date to the minimum & maximum dates.
    NSCalendar* calendar = [NSCalendar currentCalendar] ;
    NSDateComponents* nowWithoutSecondsComponents = [calendar components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:now] ;
    NSDate* nowWithoutSeconds = [calendar dateFromComponents:nowWithoutSecondsComponents] ;
    //  UIDatePicker* picker ;
    _datepickr2.minimumDate = nowWithoutSeconds ;
    
    NSDateComponents* addOneMonthComponents = [NSDateComponents new] ;
    addOneMonthComponents.month = 1 ;
    NSDate* oneMonthFromNowWithoutSeconds = [calendar dateByAddingComponents:addOneMonthComponents toDate:nowWithoutSeconds options:0] ;
    _datepickr2.maximumDate = oneMonthFromNowWithoutSeconds ;
    if (_dateview2.hidden==YES)
    {
        _dateview2.hidden=NO;

    }
    else
    {
        _dateview2.hidden=YES;

    }
}

- (IBAction)btnstartdate:(id)sender
{
//    if (_dateview.hidden==YES)
//    {
//        _dateview.hidden=NO;
//
//    }
//    else
//    {
//        _dateview.hidden=YES;
//
//    }
}
- (IBAction)donebtn2:(id)sender
{
    _dateview2.hidden=YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMMM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:_datepickr2.date];
    self.endlbldate.text = strDate;
}
- (IBAction)birthdatedonebtn:(id)sender
{
    _birthdateview.hidden=YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMMM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:_birthdatepickr.date];
    _birthdatelabel.text= strDate;
    strbirthcal=strDate;
    [self calculatebirth];

}
-(void)calculatebirth
{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMMM-yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:strbirthcal]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    
    NSLog(@"You live since %i years and %i days",years,days);
}
- (IBAction)birthdatebtn:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Weekdays" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Monday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _birthdatelabel.text=@"Monday";
                                _birthdatelabel.textColor=[UIColor blackColor];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Tuesday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _birthdatelabel.text=@"Tuesday";
                                _birthdatelabel.textColor=[UIColor blackColor];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Wednesday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _birthdatelabel.text=@"Wednesday";
                                _birthdatelabel.textColor=[UIColor blackColor];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Thursday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _birthdatelabel.text=@"Thursday";
                                _birthdatelabel.textColor=[UIColor blackColor];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Friday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _birthdatelabel.text=@"Friday";
                                _birthdatelabel.textColor=[UIColor blackColor];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Saturday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _birthdatelabel.text=@"Saturday";
                                _birthdatelabel.textColor=[UIColor blackColor];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Sunday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _birthdatelabel.text=@"Sunday";
                                _birthdatelabel.textColor=[UIColor blackColor];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
   
}
-(void)addbasicdetails
{
    
    NSArray *keys = [NSArray arrayWithObjects:@"op",@"user_id",@"cat_id",@"start_date",@"end_date",@"weight",@"birth_date",@"person_name",@"person_email",nil];
    NSArray *objects = [NSArray arrayWithObjects:@"addHabbitDetails",strsaveidlocal,_strcategoryaddid,self.startlbldate.text,self.endlbldate.text,_txtweight.text,self.birthdatelabel.text,_txtsendname.text,_txtpersonemil.text,nil];// need array of more than one string or data posted
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
                                              jsonid = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers
                                                                                         error:&jsonError];
                                              NSString *strmessage=[NSString stringWithFormat:@"%@",[jsonid valueForKey:@"message"]];
                                              dispatch_async(dispatch_get_main_queue(),
                                                             ^{
                                                                // NSLog(@"this is basic id%@",[jsonid valueForKey:@"message"]);
                                                                 if ([strmessage containsString:@"success"])
                                                                 {
                                                                     [self performSegueWithIdentifier:@"Rewarddetails-id" sender:self];
                                                                    }
                                                                 else
                                                                 {
                                                                     UIAlertController * alert = [UIAlertController
                                                                                                  alertControllerWithTitle:@"ERROR"
                                                                                                  message:@"Please try Again Details is not saved."
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
                                                             });
                                          }];
    [postDataTask resume];
}

-(IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_txtsendname)
    {
        [self.view setFrame:CGRectMake(0,-60, self.view.frame.size.width, self.view.frame.size.height)];

    }
    if (textField== _txtweight)
    {
        [self.view setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    if (textField== _txtpersonemil)
    {
        [self.view setFrame:CGRectMake(0,-210, self.view.frame.size.width, self.view.frame.size.height)];
    }
    if (textField== _txtemail)
    {
        [self.view setFrame:CGRectMake(0,-210, self.view.frame.size.width, self.view.frame.size.height)];
    }
//    else
//    {
//        [self.view setFrame:CGRectMake(0,-80, self.view.frame.size.width, self.view.frame.size.height)];
//    }
}
-(IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==_txtsendname)
    {
        [self.view setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
//        [self.view endEditing:YES];
        [_txtsendname resignFirstResponder];
    }
    if (textField==_txtweight)
    {
        [self.view setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
        [_txtweight resignFirstResponder];

    }
    if (textField==_txtpersonemil)
    {
        [self.view setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
        [_txtpersonemil resignFirstResponder];
        
    }
    else
    {
        [self.view setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
        [_txtemail resignFirstResponder];
    }
}
- (IBAction)startbtn:(id)sender
{
    if (_endlbldate.text.length>0 && _birthdatelabel.text.length>0 && _txtpersonemil.text.length>0 && _txtsendname.text.length>0 && _txtweight.text.length>0 &&_startlbldate.text.length>0)
    {
        NSArray *keys = [NSArray arrayWithObjects:@"startdate", @"endadate", @"investtime",@"perticularday",@"timeinvest",@"listactivity",nil];
        
        NSArray *objects = [NSArray arrayWithObjects:_startlbldate.text,_endlbldate.text,_txtweight.text,_birthdatelabel.text,_txtsendname.text,_txtpersonemil.text,nil];
        dictdetails = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [self performSegueWithIdentifier:@"basicanother1" sender:sender];

    }
    else
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"ERROR"
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"basicanother1"])
    {
        anotherbasicVC *anotherviews = segue.destinationViewController;
        anotherviews.dicbasic=dictdetails;
    
    }
    
}
- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)dahbtn:(id)sender
{
    [self performSegueWithIdentifier:@"dashboardbasic" sender:self];
}
- (IBAction)listbtn:(id)sender
{
    
    
      UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select your activity" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Yoga" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _txtpersonemil.text=@"Yoga";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Walking" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _txtpersonemil.text=@"Walking";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"other" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _txtpersonemil.text=@"other";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    
   // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)selectypebtn:(id)sender
{
    
}
@end
