//
//  anotherweightview.m
//  Goals&you
//
//  Created by Raindrops Infotech on 16/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "anotherweightview.h"
#import "Reachability.h"

@interface anotherweightview ()
{
    NSMutableArray *monthdata;

}
@end

@implementation anotherweightview

- (void)viewDidLoad {
    [super viewDidLoad];
    monthdata=[[NSMutableArray alloc]init];
    _textview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _textview.layer.borderWidth = 1.0f;
    _adviceview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _adviceview.layer.borderWidth = 1.0f;
    _startdateview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _startdateview.layer.borderWidth = 1.0f;
    _enddatebtnview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _enddatebtnview.layer.borderWidth = 1.0f;
    _startdateview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _startdateview.layer.borderWidth = 1.0f;
    _inspirtxt.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _inspirtxt.layer.borderWidth = 1.0f;
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    _txtview.inputAccessoryView=numberToolbar;
    _inspiretxt.inputAccessoryView=numberToolbar;
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMMM-yyyy"];
    _starrtdatelbl.text = [dateFormat stringFromDate:date];
    _pickrview.hidden=YES;
    [self cigarecalculate];
    _endadateview.hidden=YES;
    
    

    // Do any additional setup after loading the view.
}
/*-(void)registeruser
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status==ReachableViaWiFi || status==ReachableViaWWAN)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"Registering Please wait..";
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:2.0];
        hud.bezelView.color = [UIColor clearColor];
        NSArray *keys = [NSArray arrayWithObjects:@"op",@"username",@"email",@"gender",@"age",@"password", nil];
        NSArray *objects = [NSArray arrayWithObjects:@"Register",_txtname.text,_txtemail.text,strgender,_txtage.text,_txtpassword.text,nil];// need array of more than one string or data posted
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
                                                  if (data.length>0)
                                                  {
                                                      
                                                      json1id = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:&jsonError];
                                                      NSLog(@"data printed:%@",json1id);
                                                      
                                                      NSString *strmessage=[NSString stringWithFormat:@"%@",[json1id valueForKey:@"message"]];
                                                      if([strmessage containsString:@"Already Username exists"] || [strmessage containsString:@"Already Email exists"] || [strmessage containsString:@"Please try again."] || [strmessage containsString:@"Username and Email already exists"])
                                                      {
                                                          UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"ERROR"
                                                                                                                          message:strmessage//@"please enter valid password or username or email address!"
                                                                                                                   preferredStyle:UIAlertControllerStyleAlert];//please enter valid password or username
                                                          
                                                          UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                              style:UIAlertActionStyleDefault
                                                                                                            handler:^(UIAlertAction * action) {
                                                                                                                //Handle your yes please button action here
                                                                                                            }];
                                                          [alert addAction:yesButton];
                                                          [self presentViewController:alert animated:YES completion:nil];
                                                      }
                                                      else
                                                      {
                                                          dispatch_async(dispatch_get_main_queue(),
                                                                         ^{
                                                                             UIAlertController * alert = [UIAlertController
                                                                                                          alertControllerWithTitle:@"Message"
                                                                                                          message:@"Successfully Registered."
                                                                                                          preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
                                                                             
                                                                             UIAlertAction* yesButton = [UIAlertAction
                                                                                                         actionWithTitle:@"Ok"
                                                                                                         style:UIAlertActionStyleDefault
                                                                                                         handler:^(UIAlertAction * action)
                                                                                                         {
                                                                                                             
                                                                                                             [self performSegueWithIdentifier:@"loginback-id" sender:self];
                                                                                                             
                                                                                                             //Handle your yes please button action here
                                                                                                         }];
                                                                             
                                                                             [alert addAction:yesButton];
                                                                             [self presentViewController:alert animated:YES completion:nil];
                                                                         });
                                                      }
                                                  }
                                                  else
                                                  {
                                                      UIAlertController * alert = [UIAlertController
                                                                                   alertControllerWithTitle:@"ERROR"
                                                                                   message:@"Resend data Please conenctivity lost. "
                                                                                   preferredStyle:UIAlertControllerStyleAlert];
                                                      
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
                                                  
                                              }];
        
        [postDataTask resume];
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"ERROR"
                                     message:@"No internet connectivity "
                                     preferredStyle:UIAlertControllerStyleAlert];
        
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
*/
-(void)cigarecalculate
{
    for (int i=20; i<=90; i++)
    {
        [monthdata addObject:[NSString stringWithFormat:@"%d",i]];
    }
}
-(void)cancelNumberPad
{
        [_txtview resignFirstResponder];
        _txtview.text=@"";
    if ([_inspiretxt isFirstResponder])
    {
        [self.view setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];

    }
    else
    {
        [_txtview resignFirstResponder];
        _txtview.text=@"";
    }
}
-(void)doneWithNumberPad
{
    if ([_inspiretxt isFirstResponder])
    {
        [_inspiretxt resignFirstResponder];
        [self.view setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];

    }
    else
    {
        [_txtview resignFirstResponder];
    }
   
}
-(IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_inspiretxt)
    {
        [self.view setFrame:CGRectMake(0,-170, self.view.frame.size.width, self.view.frame.size.height)];
    }
    else
    {
        NSLog(@"no need to up");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    if (thePickerView==_pickrmonth)
    {
        return  monthdata.count;
    }
//    if (thePickerView==_pickrhabit)
//    {
//        return [data count];
//    }
    return 0;
    
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (thePickerView==_pickrmonth)
    {
        return [monthdata objectAtIndex:row];
    }
//    if (thePickerView==_pickrhabit)
//    {
//        return [data objectAtIndex:row];
//    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //strageselect=[NSString stringWithFormat:@"%@",[data objectAtIndex:row]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)showadvicebtn:(id)sender
{
    _pickrview.hidden=NO;
}
- (IBAction)hideviewbtn:(id)sender
{
    NSUInteger num = [[self.pickrmonth dataSource] numberOfComponentsInPickerView:self.pickrmonth];
    NSMutableString *text1 = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [self.pickrmonth selectedRowInComponent:i];
        NSString *number = [[self.pickrmonth delegate] pickerView:self.pickrmonth titleForRow:selectRow forComponent:i];
        [text1 appendFormat:@"%@",number];
        NSLog(@"%@",text1);
        NSString *strheights=@"Kg";
        NSString *strtotal=[NSString stringWithFormat:@"%@ %@",text1,strheights];
        [_advicebtn setTitle:strtotal forState:UIControlStateNormal];
        [_advicebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    _pickrview.hidden=YES;
}
- (IBAction)enddatebtn:(id)sender
{
    _endadateview.hidden=NO;
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
    _enddatebtnview.hidden=NO;

}
- (IBAction)viewhidebtn:(id)sender
{
    _endadateview.hidden=YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMMM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:_enddatepickr.date];
    _enddatelbl.text=strDate;
    _enddatelbl.textColor=[UIColor blackColor];
}
@end
