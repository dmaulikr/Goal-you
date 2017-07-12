//
//  DashboardVC.m
//  Goals&you
//
//  Created by Raindrops Infotech on 23/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "DashboardVC.h"
#import "LoginviewVC.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


@interface DashboardVC ()
{
    NSString *savedValueusername;
    NSString *savedValueusernamelocal;
    NSString *savedValueusergoogle;
    NSDictionary *jsonDictionary;
    NSDictionary *jsonid;
    NSMutableArray  *arrahabitshow;
    NSString *strsaveidlocal;
    NSString *strdeleteid;
    NSString *strnames;

}
@end

@implementation DashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    savedValueusername = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceusername"];
    savedValueusernamelocal = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"preferencenamelocal"];
    _notificationimg.image=[UIImage imageNamed:@"notification-point.png"];
    strsaveidlocal = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"preferenceidlocal"];
    strnames = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"preferencenamelocal"];
       [self testInternetConnection];
   
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
        _tablmygoal.userInteractionEnabled=NO;
        _tablattendedgoal.userInteractionEnabled=NO;
        _userbtn.userInteractionEnabled=NO;
        _notificationbtn.userInteractionEnabled=NO;
        _habitbtn.userInteractionEnabled=NO;
    }
    else if (status == ReachableViaWiFi)
    {
        if (savedValueusername.length>0 || savedValueusergoogle.length>0 || savedValueusernamelocal.length>0)
        {
            [self showhabit];
        }
        //WiFi
    }
    else if (status == ReachableViaWWAN)
    {
        if (savedValueusername.length>0 || savedValueusergoogle.length>0 || savedValueusernamelocal.length>0)
        {
            [self showhabit];
        }
        //3G
    }
}


-(void)showhabit
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    NSArray *objects;
    if(status==ReachableViaWiFi || status==ReachableViaWWAN)
    {

    NSArray *keys = [NSArray arrayWithObjects:@"op",@"user_id", nil];
        if (savedValueusername.length>0)
        {
            objects = [NSArray arrayWithObjects:@"showHabbitDetails",savedValueusername,nil];// need array of more than one string or data posted

        }
        if (savedValueusergoogle.length>0)
        {
            objects = [NSArray arrayWithObjects:@"showHabbitDetails",savedValueusergoogle,nil];// need array of more than one string or data posted

        }
        if (savedValueusernamelocal.length>0)
        {
            objects = [NSArray arrayWithObjects:@"showHabbitDetails",strsaveidlocal,nil];// need array of more than one string or data posted

        }
//    NSArray *objects = [NSArray arrayWithObjects:@"showHabbitDetails",strsaveidlocal,nil];// need array of more than one string or data posted
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

                                              if ([jsonid count] ==0 || [strmessage containsString:@"fail"])
                                              {
                                                  UIAlertController * alert = [UIAlertController
                                                                               alertControllerWithTitle:@"ERROR"
                                                                               message:@"No Date Found!"
                                                                               preferredStyle:UIAlertControllerStyleAlert];
                                                  
                                                  UIAlertAction* yesButton = [UIAlertAction
                                                                              actionWithTitle:@"OK"
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
                                                                     arrahabitshow=[jsonid valueForKey:@"message"];
                                                                     [_tablmygoal reloadData];
                                                                     
                                                                 });
 
                                              }
                                                    }];
    
    [postDataTask resume];
}
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"ERROR"
                                     message:@"Connection Lost!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)deletehabit
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if(status==ReachableViaWiFi || status==ReachableViaWWAN)
    {

    NSArray *keys = [NSArray arrayWithObjects:@"op",@"id",@"user_id", nil];
    NSArray *objects = [NSArray arrayWithObjects:@"deleteHabbit",strdeleteid,strsaveidlocal,nil];// need array of more than one string or data posted
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

                                                  dispatch_async(dispatch_get_main_queue(),
                                                                 ^{
                                                                     //                                                                     arrahabitshow=[jsonid valueForKey:@"details"];
                                                                     //                                                                    [_tablmygoal reloadData];
                                                                     [self showhabit];
                                                                 });
                                                  
                                              }
                                              else
                                              {
                                                  UIAlertController * alert = [UIAlertController
                                                                               alertControllerWithTitle:@"ERROR"
                                                                               message:@"Delete Failed!"
                                                                               preferredStyle:UIAlertControllerStyleAlert];
                                                  
                                                  UIAlertAction* yesButton = [UIAlertAction
                                                                              actionWithTitle:@"OK"
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
                                     message:@"Connection Lost!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tablmygoal)
    {
        return arrahabitshow.count;
    }
    if (tableView==_tablattendedgoal)
    {
        return  1;
    }
    return 0;
    
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    CGRect frame = [tableView rectForRowAtIndexPath:indexPath];
    //    NSLog(@"row width : %f", frame.size.width);
    //    NSLog(@"row height : %f", frame.size.height);
    
    if (tableView==_tablmygoal)
    {
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        else
        {
           NSString *colorstr=[NSString stringWithFormat:@"%@",[[[arrahabitshow valueForKey:@"status"] valueForKey:@"color"] objectAtIndex:indexPath.row]];
           // NSLog(@"color name%@",colorstr);
            UIView *showview=(UIView *)[cell viewWithTag:2];
            [showview setBackgroundColor: [self colorWithHexString:colorstr]]; /* white */

            UILabel *lblname=(UILabel *)[cell viewWithTag:1];
            lblname.text=[[arrahabitshow valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
            UIButton *btnedit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btnedit.tag=indexPath.row;
            [btnedit addTarget:self
                        action:@selector(popButtonClicked:) forControlEvents:UIControlEventTouchDown];
            btnedit.frame = CGRectMake(frame.size.width-88, frame.size.height-50, 73.0, 42.0);
            //btnedit.backgroundColor=[UIColor redColor];
            [cell.contentView addSubview:btnedit];
        }
    }
    if (tableView==_tablattendedgoal)
    {
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        else
        {
//             NSString *colorstrgoal=[NSString stringWithFormat:@"%@",[[[arrahabitshow valueForKey:@"status"] valueForKey:@"color"] objectAtIndex:indexPath.row]];
            cell.contentView.backgroundColor = [self colorWithHexString:@"FF0000"];
            UILabel *lblname=(UILabel *)[cell viewWithTag:1];
            lblname.text=@"Weight Loss";
            UILabel *goalname=(UILabel *)[cell viewWithTag:2];
            goalname.text=@"Failed Goal";
            //cell.textLabel.text = @"menu";//@"first";
        }
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"%ld", (long)indexPath.row+1); // you can see selected row number in your console;
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tablattendedgoal)
    {

        
    }
     if (tableView==_tablmygoal)
    {
                strdeleteid=[NSString stringWithFormat:@"%@",[[arrahabitshow valueForKey:@"id"] objectAtIndex:indexPath.row]];
                [self deletehabit];
    }
}
-(void)popButtonClicked:(UIButton*)sender
{
    NSLog(@"button tapped Index %ld",(long)sender.tag+1);
    [self performSegueWithIdentifier:@"Editdetails-id" sender:sender];

}

- (IBAction)accountsbtn:(id)sender
{
    savedValueusergoogle = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"preferenceuseremailgoogle"];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Accounts" message:strnames preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                            {
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    if (savedValueusername.length>0 || savedValueusernamelocal.length>0 || savedValueusergoogle.length>0)
    {
        if (savedValueusernamelocal.length>0)
        {
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        _logoutstring=@"time to logout";
                                        savedValueusernamelocal=@"";
                                        [arrahabitshow removeAllObjects];
                                        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                                        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                                        [[NSUserDefaults standardUserDefaults] synchronize];
                                        savedValueusernamelocal=[[NSUserDefaults standardUserDefaults]
                                                                 stringForKey:@"preferencenamelocal"];
                                        [_tablmygoal reloadData];
                                        [self dismissViewControllerAnimated:YES completion:^{
                                        }];
                                    }]];
            [self presentViewController:actionSheet animated:YES completion:nil];
        }
        if (savedValueusername.length>0 || savedValueusergoogle.length>0)
        {
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                         {
                                             
                                             _logoutstring=@"time to logout";
                                            [self performSegueWithIdentifier:@"dashboardtoaccounts-id" sender:sender];
                                             [self dismissViewControllerAnimated:YES completion:^{
                                             }];
                                         }]];
            [self presentViewController:actionSheet animated:YES completion:nil];
        }
    }
    else
    {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Accounts" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Signup" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                {
            [self performSegueWithIdentifier:@"registrationpage-id" sender:sender];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self performSegueWithIdentifier:@"dashboardtoaccounts-id" sender:sender];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                {
                                    [self dismissViewControllerAnimated:YES completion:^{
                                    }];
                                }]];
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"dashboardtoaccounts-id"])
    {
        LoginviewVC *loginviews = segue.destinationViewController;
        loginviews.logoutstr=_logoutstring;
        
    }
    
}

- (IBAction)categorybtn:(id)sender
{
    [self performSegueWithIdentifier:@"addcategory-id" sender:sender];

    
}
- (IBAction)notificationbtn:(id)sender
{
    _notificationimg.image=[UIImage imageNamed:@"notification.png"];
    [self performSegueWithIdentifier:@"dashnotification-id" sender:sender];
    
}
@end
