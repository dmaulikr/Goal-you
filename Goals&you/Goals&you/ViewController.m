//
//  ViewController.m
//  Goals&you
//
//  Created by Raindrops Infotech on 17/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

@interface ViewController ()
{
    NSString *savedValueusername;
    NSString *savedValueusernamelocal;


}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testInternetConnection];
    _profileview.hidden=YES;
    savedValueusername = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceusername"];
    savedValueusernamelocal = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferencenamelocal"];
    //     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.mode = MBProgressHUDModeIndeterminate;
    //hud.label.text = @"Loading";
    //[hud showAnimated:YES];
    //  [hud hideAnimated:YES afterDelay:4.0];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)testInternetConnection
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
         _profilebtn.userInteractionEnabled=NO;
         _readybtn.userInteractionEnabled=NO;
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
        _profilebtn.userInteractionEnabled=YES;
        _readybtn.userInteractionEnabled=YES;
        //WiFi
    }
    else if (status == ReachableViaWWAN)
    {
        _profilebtn.userInteractionEnabled=YES;
        _readybtn.userInteractionEnabled=YES;
        //3G
    }
}
- (IBAction)readybtn:(id)sender
{
            [self performSegueWithIdentifier:@"categoryid" sender:sender];
}
- (IBAction)profilebtn:(id)sender
{

        _profileview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        [self.view addSubview:_profileview];
        [UIView animateWithDuration:0.2/1.5 animations:^{
            _profileview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2/2 animations:^{
                _profileview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2/2 animations:^{
                    _profileview.transform = CGAffineTransformIdentity;
                    _profileview.hidden=NO;
//                    self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.9];
                }];
            }];
        }];

}
- (IBAction)cancelbtn:(id)sender
{
    if (_profileview.hidden==NO)
    {
        _profileview.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _profileview.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished)
         {
             _profileview.hidden = YES;
         }];
    }
}

- (IBAction)loginbtn:(id)sender
{
    
    [self performSegueWithIdentifier:@"loginshow-id" sender:sender];
}

- (IBAction)signupbtn:(id)sender
{
     [self performSegueWithIdentifier:@"registration-id" sender:sender];
    
}
@end
