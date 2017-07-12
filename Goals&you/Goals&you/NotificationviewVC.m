//
//  NotificationviewVC.m
//  Goals&you
//
//  Created by Raindrops Infotech on 01/02/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "NotificationviewVC.h"
#import "Reachability.h"
#import "CustomTableViewCell.h"



@interface NotificationviewVC ()
{
    NSMutableArray *array1;
    NSMutableArray *array2;

}
@end

@implementation NotificationviewVC


- (void)viewDidLoad {
    [super viewDidLoad];
    array1=[[NSMutableArray alloc] init];
    array2=[[NSMutableArray alloc]init];
       // Do any additional setup after loading the view.
    array1 =[[NSMutableArray alloc]initWithObjects:@"My Target",@"This Track",@"Off track",@"should start soon", nil];
    array2 =[[NSMutableArray alloc]initWithObjects:@"Not completed should complete",@"this is not right way to reduce in fast way",@"finished early",@"begin the practice", nil];

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
        _tablnotification.userInteractionEnabled=NO;
        _readall.userInteractionEnabled=NO;
        
    }
    else if (status == ReachableViaWiFi)
    {
        _readall.userInteractionEnabled=YES;
        _tablnotification.userInteractionEnabled=YES;
        //WiFi
        
    }
    else if (status == ReachableViaWWAN)
    {
        //3G
        _tablnotification.userInteractionEnabled=YES;
        _readall.userInteractionEnabled=YES;
    }
}

///..guesture shows tableview index with data
//- (void)handleSwipeRight:(UISwipeGestureRecognizer *)gestureRecognizer
//{
//    CGPoint point = [gestureRecognizer locationInView:self.tablnotification];
//    NSIndexPath *indexPath = [self.tablnotification indexPathForRowAtPoint:point];
//        indexPath=[array1 objectAtIndex:indexPath.row];
//    NSLog(@"print data%@",indexPath);
//    [self displayNoCommentWithAnimation];
//    
//}
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array1.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Add utility buttons
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    cell.patternLabel.text=[array1 objectAtIndex:indexPath.row];
    cell.descLabel.text=[array2 objectAtIndex:indexPath.row];
    cell.patternLabel.textColor=[UIColor blackColor];

    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f/255.0f green:87.0f/255.0f blue:155.0f/255.0f alpha:1.0]
                                                icon:[UIImage imageNamed:@"chek-icon.png"]];
//    [leftUtilityButtons sw_addUtilityButtonWithColor:
//     [UIColor whiteColor]
                                               // icon:[UIImage imageNamed:@"chek-icon.png"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    cell.leftUtilityButtons = leftUtilityButtons;
    cell.rightUtilityButtons = rightUtilityButtons;
    cell.delegate = self;
    
    
    return cell;
}
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
   
    switch (index)
    {
        case 0:
        {
            // Add utility buttons
            
           
      
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Alert"
                                         message:@"Successfully Read!"
                                         preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
//            UIAlertAction* yesButton = [UIAlertAction
//                                        actionWithTitle:@""
//                                        style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * action)
//                                        {
                                            [cell hideUtilityButtonsAnimated:YES];
                                            [_tablnotification reloadData];
//                                            //Handle your yes please button action here
//                                        }];
//            
//            [alert addAction:yesButton];
            [self performSelector:@selector(dissmissAlert:) withObject:alert afterDelay:2.0];
            [self presentViewController:alert animated:YES completion:nil];
            
            break;
        }
        default:
            break;
    }
}
-(void)dissmissAlert:(UIAlertController *) alert
{
    [alert dismissViewControllerAnimated:true completion:nil];
}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//    //    if (editingStyle == UITableViewCellEditingStyleDelete)
//    //    {
//    //        [arracategory removeObjectAtIndex:indexPath.row];
//    //        [_tablecategory reloadData];
//    //        //add code here for when you hit delete
//    //    }
//}
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Alert"
                                         message:@"Do You Want To Delete Are You Sure?"
                                         preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            [cell hideUtilityButtonsAnimated:YES];
                                            [array1 removeObjectAtIndex:index];
                                            [array2 removeObjectAtIndex:index];
                                            UIAlertController * alert = [UIAlertController
                                                                         alertControllerWithTitle:@"Alert"
                                                                         message:@"Successfully Deleted!"
                                                                         preferredStyle:UIAlertControllerStyleAlert];// please fill all fields
                                            [cell hideUtilityButtonsAnimated:YES];
                                            [_tablnotification reloadData];
                                            [self performSelector:@selector(dissmissAlert:) withObject:alert afterDelay:2.0];
                                            [self presentViewController:alert animated:YES completion:nil];

                                            //Handle your yes please button action here
                                        }];
            UIAlertAction* nobutton = [UIAlertAction
                                       actionWithTitle:@"No"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction * action)
                                       {
                                           [cell hideUtilityButtonsAnimated:YES];

                                           //Handle your yes please button action here
                                       }];
            
            [alert addAction:yesButton];
            [alert addAction:nobutton];
            [self presentViewController:alert animated:YES completion:nil];
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button is pressed
            NSIndexPath *cellIndexPath = [self.tablnotification indexPathForCell:cell];
            [self.tablnotification deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
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

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)readallbtn:(id)sender
{
    [array1 removeAllObjects];
    [array2 removeAllObjects];
    [_tablnotification reloadData];
}
@end
