//
//  RegistrationVC.m
//  Goals&you
//
//  Created by Raindrops Infotech on 24/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "RegistrationVC.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

#define MAX_LENGTH 2
#define MAX_number 100


@interface RegistrationVC ()
{
    NSString *agestring;
    NSString *strgender;
    NSMutableArray  *arraregister;
    NSDictionary *json1id;
    NSDictionary *jsonDictionary;


}
@end

@implementation RegistrationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    strgender=@"";
    [self testInternetConnection];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    _txtage.inputAccessoryView=numberToolbar;
    _passwordview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _passwordview.layer.borderWidth = 1.0f;
    _usernameview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _usernameview.layer.borderWidth = 1.0f;
    _ageview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _ageview.layer.borderWidth = 1.0f;
    _emailview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _emailview.layer.borderWidth = 1.0f;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cancelNumberPad
{
    
    [_txtage resignFirstResponder];
    _txtage.text = @"";
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

-(void)doneWithNumberPad
{
    
    agestring = _txtage.text;
    [_txtage resignFirstResponder];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([_txtage isFirstResponder])
    {
        if (_txtage.text.length >= MAX_LENGTH && range.length == 0)
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Message"
                                         message:@"Please enter valid Age"
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
            [_txtage resignFirstResponder];
            return NO; // return NO to not change text
        }
        else
        {
            return YES;
        }
        
    }
    else
    {
        
    }
    return YES;
//    NSString *strNum =_txtage.text;
//    int num = [strNum intValue];
//   
//    if (num <MAX_number)
//    {
//        NSLog(@"right age");
//        return YES; // return NO to not change text
//    }
//    return 0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)registeruser
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
- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (IBAction)registerbtn:(id)sender
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if (!([self.txtage.text  isEqual: @""]) && !([self.txtname.text  isEqual: @""])&& !([self.txtpassword.text  isEqual: @""])&& [emailTest evaluateWithObject:_txtemail.text] == YES && ![strgender isEqualToString:@""])//[emailTest evaluateWithObject:_txtemail.text] == YES &&
    {
        [self registeruser];
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
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

- (IBAction)malebtn:(id)sender
{
    if ([strgender isEqualToString:@"female"])
    {
        _femalebtn.backgroundColor=[UIColor whiteColor];
//        _malebtn.titleLabel.textColor=[UIColor orangeColor];
        _malebtn.backgroundColor=[UIColor darkGrayColor];
        _malebtn.tag=1;
        strgender=@"male";
    }
    else
    {
        _malebtn.titleLabel.textColor=[UIColor orangeColor];
        _malebtn.backgroundColor=[UIColor darkGrayColor];
        _malebtn.tag=1;
        strgender=@"male";

    }
    
}

- (IBAction)femalebtn:(id)sender
{
    if ([strgender isEqualToString:@"male"])
    {
        _malebtn.backgroundColor=[UIColor whiteColor];
//        _femalebtn.titleLabel.textColor=[UIColor orangeColor];
        _femalebtn.backgroundColor=[UIColor darkGrayColor];
        _femalebtn.tag=1;
        strgender=@"female";
    }
    else
    {
        _femalebtn.titleLabel.textColor=[UIColor orangeColor];
        _femalebtn.backgroundColor=[UIColor darkGrayColor];
        _femalebtn.tag=1;
        strgender=@"female";
    }
    

}
@end
