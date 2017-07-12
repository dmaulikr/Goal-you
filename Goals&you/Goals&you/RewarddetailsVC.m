//
//  RewarddetailsVC.m
//  Goals&you
//
//  Created by Raindrops Infotech on 19/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "RewarddetailsVC.h"
#import "Reachability.h"

@interface RewarddetailsVC ()
{
    NSDictionary *jsonDictionary;
    NSString *strcontinue;
    NSDictionary *jsonid;
    NSString *strsaveidlocal;



}

@end

@implementation RewarddetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    strsaveidlocal = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"preferenceidlocal"];
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
-(void)sendcontinue
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status==ReachableViaWiFi || status==ReachableViaWWAN)
    {

    NSArray *keys = [NSArray arrayWithObjects:@"op",@"continue",@"id",nil];
    NSArray *objects = [NSArray arrayWithObjects:@"checkContinue",@"1",strsaveidlocal,nil];// need array of more than one string or data posted
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
                                              jsonid = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers
                                                                                         error:&jsonError];
                                           strcontinue=[NSString stringWithFormat:@"%@",[jsonid valueForKey:@"message"]];
                                              if ([strcontinue containsString:@"0"])
                                              {
                                                  UIAlertController * alert = [UIAlertController
                                                                               alertControllerWithTitle:@"ERROR"
                                                                               message:@"Please Retry To Send"
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
                                              else
                                              {
                                              dispatch_async(dispatch_get_main_queue(),
                                                             ^{
                                                                 [self performSegueWithIdentifier:@"dashboard-id" sender:self];
                                                                 
                                                             });
                                              }
                                              }
                                              else
                                              {
                                                  UIAlertController * alert = [UIAlertController
                                                                               alertControllerWithTitle:@"ERROR"
                                                                               message:@"Please Retry,No Connection!"
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

- (IBAction)continuebtn:(id)sender
{
    [self sendcontinue];
}

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
@end
