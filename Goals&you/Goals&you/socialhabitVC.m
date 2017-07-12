//
//  socialhabitVC.m
//  Goals&you
//
//  Created by Raindrops Infotech on 16/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "socialhabitVC.h"
#import "socialhabitdetailsVC.h"

@interface socialhabitVC ()
{
    NSMutableArray *data;
    NSArray *platformdata;
    NSMutableArray *selectsocialmedia;
    NSString *strsocialinsta;
    NSString *strsocialtwitter;
    NSString *strsocialfacebook;
    NSString *strsocialWhatsapp;
    NSString *strsocialpinterest;
    NSString *strsocialLinkedin;
    NSDictionary *dictsocialhabitdata;
    NSString *strfamilytime;
    NSString *strweekday;
    NSString *stravgtime;





}
@end

@implementation socialhabitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickrview.hidden=YES;
    data = [[NSMutableArray alloc] init];
    for (int i=1; i<=20; i++)
    {
        [data addObject:[NSString stringWithFormat:@"%d",i]];
    }
    _hourview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _hourview.layer.borderWidth = 1.0f;
    _averagetimeview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _averagetimeview.layer.borderWidth = 1.0f;
    _selectaveragetimeview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _selectaveragetimeview.layer.borderWidth = 1.0f;
    _dayview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _dayview.layer.borderWidth = 1.0f;
    _selectsocialview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _selectsocialview.layer.borderWidth = 1.0f;
    _timeaverageview.hidden=YES;
    _dayview.layer.borderWidth = 1.0f;
    _selectplatformview.hidden=YES;
    selectsocialmedia=[[NSMutableArray alloc]init];
    platformdata=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];
    // here combine social platform with id and name for multiple option selection.
    // Do any additional setup after loading the view.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    if (thePickerView==_hourpickr)
    {
        return  data.count;
    }
    if (thePickerView==_averagetimepickr)
    {
        return [data count];
    }
    return 0;
    
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (thePickerView==_hourpickr)
    {
        return [data objectAtIndex:row];
    }
    if (thePickerView==_averagetimepickr)
    {
        return [data objectAtIndex:row];
    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //strageselect=[NSString stringWithFormat:@"%@",[data objectAtIndex:row]];
}

- (IBAction)selecthourbtn:(id)sender
{
    _pickrview.hidden=NO;

}
- (IBAction)hidebtnview:(id)sender
{
    NSUInteger num = [[self.hourpickr dataSource] numberOfComponentsInPickerView:self.hourpickr];
    NSMutableString *text = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [self.hourpickr selectedRowInComponent:i];
        NSString *number = [[self.hourpickr delegate] pickerView:self.hourpickr titleForRow:selectRow forComponent:i];
        [text appendFormat:@"%@",number];
        stravgtime=text;
        
        NSLog(@"%@",text);
    }
    [_hourselectbtn setTitle:text forState:UIControlStateNormal];
    [_hourselectbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _pickrview.hidden=YES;

}
- (IBAction)backsbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)averagetimebtn:(id)sender
{
    _timeaverageview.hidden=NO;

}
- (IBAction)averagepickrhidebtn:(id)sender
{
    NSUInteger num = [[self.averagetimepickr dataSource] numberOfComponentsInPickerView:self.averagetimepickr];
    NSMutableString *text = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [self.averagetimepickr selectedRowInComponent:i];
        NSString *number = [[self.averagetimepickr delegate] pickerView:self.hourpickr titleForRow:selectRow forComponent:i];
        [text appendFormat:@"%@",number];
        strfamilytime=text;
        NSLog(@"%@",text);
    }
    [_selectaveragetimebtn setTitle:text forState:UIControlStateNormal];
    [_selectaveragetimebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    _timeaverageview.hidden=YES;
}
- (IBAction)daybtn:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Weekdays" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Monday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                strweekday=@"Monday";
                                [_daysetbtn setTitle:@"Monday" forState:UIControlStateNormal];
                                [_daysetbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Tuesday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                strweekday=@"Tuesday";
                                [_daysetbtn setTitle:@"Tuesday" forState:UIControlStateNormal];
                                [_daysetbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Wednesday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                strweekday=@"Wednesday";
                                [_daysetbtn setTitle:@"Wednesday" forState:UIControlStateNormal];
                                [_daysetbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Thursday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                strweekday=@"Thursday";
                                [_daysetbtn setTitle:@"Thursday" forState:UIControlStateNormal];
                                [_daysetbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Friday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                strweekday=@"Friday";
                                [_daysetbtn setTitle:@"Friday" forState:UIControlStateNormal];
                                [_daysetbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Saturday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                strweekday=@"Saturday";
                                [_daysetbtn setTitle:@"Saturday" forState:UIControlStateNormal];
                                [_daysetbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Sunday" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                strweekday=@"Sunday";
                                [_daysetbtn setTitle:@"Sunday" forState:UIControlStateNormal];
                                [_daysetbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (IBAction)socialselectshowbtn:(id)sender
{
//    _selectplatformview.hidden=NO;
    _selectplatformview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [self.view addSubview:_selectplatformview];
    [UIView animateWithDuration:0.2/1.5 animations:^{
        _selectplatformview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2/2 animations:^{
            _selectplatformview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2/2 animations:^{
                _selectplatformview.transform = CGAffineTransformIdentity;
                _selectplatformview.hidden=NO;
            }];
        }];
    }];
}
- (IBAction)selectplatformbtn:(id)sender
{
    if (_selectplatformview.hidden==NO)
    {
        _selectplatformview.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _selectplatformview.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished)
         {
             _selectplatformview.hidden = YES;
         }];

    _selectplatformview.hidden=YES;
    NSString *stringsocial = [selectsocialmedia componentsJoinedByString:@","];
    if ([stringsocial containsString:@"Instagram"])
    {
        strsocialinsta=@"Instagram";
    }
    if ([stringsocial containsString:@"Twitter"])
    {
        strsocialtwitter=@"Twitter";
    }
    if ([stringsocial containsString:@"Facebook"])
    {
        strsocialfacebook=@"Facebook";
    }
    if ([stringsocial containsString:@"pinterest"])
    {
        strsocialpinterest=@"pinterest";
    }
    if ([stringsocial containsString:@"Whatsapp"])
    {
        strsocialpinterest=@"pinterest";
    }
    if ([stringsocial containsString:@"Linkedin"])
    {
        strsocialpinterest=@"Linkedin";
    }
    
  }


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return platformdata.count;
    
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
        lblname.text=[platformdata  objectAtIndex:indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    [selectsocialmedia addObject:[platformdata objectAtIndex:indexPath.row]];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:255/255.0
                                                      green:152/255.0
                                                       blue:0/255.0
                                                      alpha:1.0];
    cell.selectedBackgroundView =  customColorView;
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    UILabel *lblname=(UILabel *)[cell viewWithTag:1];
    lblname.textColor=[UIColor whiteColor];
    NSLog(@"select social%@",selectsocialmedia);



}

//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    [selectsocialmedia removeObject:[platformdata objectAtIndex:indexPath.row]];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView =  customColorView;
    UILabel *lblname=(UILabel *)[cell viewWithTag:1];
    lblname.textColor=[UIColor blackColor];
   // NSLog(@"select social%@",selectsocialmedia);
    
}


- (IBAction)nextbtn:(id)sender
{
    NSArray *keys = [NSArray arrayWithObjects:@"average time", @"familytime", @"dayinvest",nil];
    NSArray *objects = [NSArray arrayWithObjects:stravgtime,strfamilytime,strweekday, nil];
    dictsocialhabitdata = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    
    if (dictsocialhabitdata>0 && selectsocialmedia.count>0)
    {
        
        [self performSegueWithIdentifier:@"socialdetails-id" sender:sender];
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Alert"
                                     message:@"Please fill all details!"
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
    if ([segue.identifier isEqualToString:@"socialdetails-id"])
    {
        socialhabitdetailsVC *socialdetails = segue.destinationViewController;
        socialdetails.dictsocial=dictsocialhabitdata;
        socialdetails.arrplatform=selectsocialmedia;
    }
    
}

@end
