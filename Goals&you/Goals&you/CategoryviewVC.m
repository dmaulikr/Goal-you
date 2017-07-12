//
//  CategoryviewVC.m
//  Goals&you
//
//  Created by Raindrops Infotech on 18/01/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "CategoryviewVC.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "BasicdetailsVC.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "alcoholview.h"

@interface CategoryviewVC ()
{
    NSString *savedValueusername;
    NSString *savedValueusergoogle;
    NSDictionary *jsonDictionary;
    Reachability *internetReachableFoo;
    NSMutableArray  *arracategory;
    NSDictionary *jsonid;
    NSString *savedValueusernamelocal;
    NSString *basiccategoryid;
    NSString *strnamecat;


}
@end

@implementation CategoryviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testInternetConnection];
    self.tablecategory.allowsMultipleSelectionDuringEditing = NO;
    _addview.hidden=YES;
    savedValueusername = [[NSUserDefaults standardUserDefaults]
                    stringForKey:@"preferenceusername"];
    savedValueusernamelocal = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"preferencenamelocal"];
    savedValueusergoogle = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceuseremailgoogle"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    _notificationimg.image=[UIImage imageNamed:@"notification-point.png"];
    hud.label.text = @"";
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.0];
//    [hud setBackgroundColor:[UIColor lightGrayColor]];
    hud.bezelView.color = [UIColor clearColor];

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
        _tablecategory.userInteractionEnabled=NO;
    }
    else if (status == ReachableViaWiFi)
    {
        [self getcategory];
        //WiFi
    }
    else if (status == ReachableViaWWAN)
    {
        [self getcategory];
        //3G
    }
}


-(void)getcategory
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status==ReachableViaWiFi || status==ReachableViaWWAN)
    {

        NSArray *keys = [NSArray arrayWithObjects:@"op", nil];
        NSArray *objects = [NSArray arrayWithObjects:@"habbitCategory",nil];// need array of more than one string or data posted
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
                                            if(data.length>0)
                                            {
                                           jsonid = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers
                                                                                                           error:&jsonError];
                                                                    dispatch_async(dispatch_get_main_queue(),
                                                                     ^{
                                                                         arracategory=[jsonid valueForKey:@"message"];
                                                                         [_tablecategory reloadData];
                                                                         
                                                                     });
                                            
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
                                     message:@"No internet connectivity"
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arracategory.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    else
    {
        UILabel *lblname=(UILabel *)[cell viewWithTag:1];
        lblname.text=[[arracategory valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
        lblname.font=[UIFont fontWithName:@"Times New Roman" size:20.0];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
                       ^{
                           
                           NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[arracategory valueForKey:@"cat_image"] objectAtIndex:indexPath.row]]];
                           UIImage *imaedat=[[UIImage alloc]initWithData: data];
                           dispatch_sync(dispatch_get_main_queue(), ^(void)
                                         {
                                             UIImageView *imgthumbnail=(UIImageView *)[cell viewWithTag:2];
                                             imgthumbnail.image=imaedat;
                                             
                                         });
                           
                       });
    }
    return cell;
}

-(void)addcategory
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status==ReachableViaWiFi || status==ReachableViaWWAN)
    {
    NSArray *keys = [NSArray arrayWithObjects:@"op",@"cat_name", nil];
    NSArray *objects = [NSArray arrayWithObjects:@"addCategory",_txtcategory.text,nil];// need array of more than one string or data posted
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
                                              if(data.length>0)
                                              {
                                              jsonid = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&jsonError];
                                               NSLog(@"data printed:%@",jsonid);
                                              
                                                            dispatch_async(dispatch_get_main_queue(),
                                                             ^{
                                                                // arracategory=[jsonid valueForKey:@"message"];
                                                                 //[self getcategory];
                                                                 
                                                                 //                           [self.view addSubview:imagecolleview];
                                                             });
                                              //                                                  }
                                              }
                                              else
                                              {
                                                  UIAlertController * alert = [UIAlertController
                                                                               alertControllerWithTitle:@"ERROR"
                                                                               message:@"No internet Connectivity!"
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
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}

-(IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    [_txtcategory resignFirstResponder];
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        [arracategory removeObjectAtIndex:indexPath.row];
//        [_tablecategory reloadData];
//        //add code here for when you hit delete
//    }
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (savedValueusername.length>0 || savedValueusernamelocal.length>0 || savedValueusergoogle.length>0)
    {
        [self testInternetConnection];
        basiccategoryid=[NSString stringWithFormat:@"%@",[[arracategory valueForKey:@"id"] objectAtIndex:indexPath.row]];
        if ([basiccategoryid isEqualToString:@"2"])
        {
            [self performSegueWithIdentifier:@"alcohol-id" sender:_tablecategory];
        }
        if ([basiccategoryid isEqualToString:@"4"])
        {
           [self performSegueWithIdentifier:@"smokingpage-id" sender:_tablecategory];
        }
        if ([basiccategoryid isEqualToString:@"5"])
        {
             [self performSegueWithIdentifier:@"socialhabit-id" sender:_tablecategory];
        }
        if ([basiccategoryid isEqualToString:@"1"])
        {
             [self performSegueWithIdentifier:@"categorytobasic-id" sender:_tablecategory];
        }
        if ([basiccategoryid isEqualToString:@"3"])
        {
             [self performSegueWithIdentifier:@"weight-id" sender:_tablecategory];
        }
        
    }
    else
    {
        [self testInternetConnection];
        [self performSegueWithIdentifier:@"login-id" sender:_tablecategory];
    }

//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    UIImageView *imgcircle=(UIImageView *)[cell viewWithTag:1];
//    imgcircle.image = [UIImage imageNamed:@"white_dot_60.png"];
//    imgcircle.contentMode = UIViewContentModeScaleAspectFit;
    //    imgcircle.clipsToBounds = YES;
//    imgcircle.contentMode = UIViewContentModeScaleAspectFit;


//    NSLog(@"%ld", (long)indexPath.row+1); // you can see selected row number in your console;
//    if (indexPath.row==0)
//    {
//        [self performSegueWithIdentifier:@"menu1-id" sender:tableView];
//        
//    }
//    if (indexPath.row==1)
//    {
//        [self performSegueWithIdentifier:@"menu2-id" sender:tableView];
//    }
//    if (indexPath.row==2)
//    {
//        [self performSegueWithIdentifier:@"menu3-id" sender:tableView];
//    }
//    if (indexPath.row==3)
//    {
//        [self performSegueWithIdentifier:@"menu4-id" sender:tableView];
//        
//    }
//    if (indexPath.row==4)
//    {
//        [self performSegueWithIdentifier:@"menu5-id" sender:tableView];
//        
//    }
//    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addcategorybtn:(id)sender
{
    _addview.hidden=NO;
    _txtcategory.text=@"";

}
- (IBAction)addnewcategorybtn:(id)sender
{
    _addview.hidden=YES;
    [arracategory  addObject:[NSString stringWithFormat:@"%@", _txtcategory.text]];
    [_txtcategory  resignFirstResponder];
//    [_tablecategory reloadData];
    if (savedValueusername.length>0 || savedValueusernamelocal.length>0 || savedValueusergoogle.length>0)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Message"
                                     message:@"For Your knowledge Your category is Submitted to Our Team After Approval We Add It."
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

        [self addcategory];
//        [self performSegueWithIdentifier:@"categorytobasic-id" sender:sender];
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Message"
                                     message:@"Please enter category"
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
//        [self addcategory];
//        [self performSegueWithIdentifier:@"login-id" sender:sender];
    }

}
- (IBAction)hidebtn2:(id)sender
{
    _addview.hidden=YES;
    _txtcategory.text=@"";
    [_txtcategory  resignFirstResponder];

}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect myRect = [tableView rectForRowAtIndexPath:indexPath];
    
    //instead of 568, choose the origin of your animation
    cell.frame = CGRectMake(cell.frame.origin.x,
                            cell.frame.origin.y + 568,
                            cell.frame.size.width,
                            cell.frame.size.height);
    
    [UIView animateWithDuration:0.5 delay:0.1*indexPath.row options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //instead of -30, choose how much you want the cell to get "under" the cell above
        cell.frame = CGRectMake(myRect.origin.x,
                                myRect.origin.y - 30,
                                myRect.size.width,
                                myRect.size.height);
        
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.5 animations:^{
            cell.frame = myRect;
        }];
        
    }];
}
- (IBAction)hidebtn1:(id)sender
{
    _addview.hidden=YES;
    _txtcategory.text=@"";
    [_txtcategory  resignFirstResponder];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"categorytobasic-id"])
    {
        BasicdetailsVC *basicview = segue.destinationViewController;
        basicview.strcategoryaddid=basiccategoryid;
        
    }
    
}
- (IBAction)dashboardbtn:(id)sender
{
     if (savedValueusername.length>0 || savedValueusernamelocal.length>0 || savedValueusergoogle.length>0)
     {
         [self performSegueWithIdentifier:@"dashbaordgo-id" sender:sender];
 
     }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Message"
                                     message:@" Create Habit Tracking First To See Dashboard!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)notificationbtn:(id)sender
{
    _notificationimg.image=[UIImage imageNamed:@"notification.png"];

    [self performSegueWithIdentifier:@"notificationcategory-id" sender:sender];
}
@end
