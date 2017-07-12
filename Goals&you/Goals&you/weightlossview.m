//
//  weightlossview.m
//  Goals&you
//
//  Created by Raindrops Infotech on 15/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "weightlossview.h"
#import "anotherweightview.h"

@interface weightlossview ()
{
    NSMutableArray *data;
    NSMutableArray *weightdata;
    NSMutableArray *agedata;
    NSString *stragestore;
    NSMutableArray *weightarr;
    NSString *reducestr;
    NSString *eattime;
    NSString *weightstr;
    NSString *heightstr;
    NSDictionary *dictweightdata;

    

}

@end
@implementation weightlossview

- (void)viewDidLoad {
    [super viewDidLoad];
    _heightview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _heightview.layer.borderWidth = 1.0f;
    _ageview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _ageview.layer.borderWidth = 1.0f;
    _weightview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _weightview.layer.borderWidth = 1.0f;
    _timeselectview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _timeselectview.layer.borderWidth = 1.0f;
    _habitview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _habitview.layer.borderWidth = 1.0f;
    _agepickview.hidden=YES;
    _heightshowview.hidden=YES;
    _weightpickrview.hidden=YES;
    agedata=[[NSMutableArray alloc]init];
    weightarr=[[NSMutableArray alloc]init];
    data=[[NSMutableArray alloc]init];

    for (int i=20; i<=180; i++)
    {
        [data addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self cigarecalculate];
//    for (int i=1; i<=150; i++)
//    {
//        [weightdata addObject:[NSString stringWithFormat:@"%d",i]];
//    }
    [self weightset];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)weightset
{
    for (int i=14; i<=100; i++)
    {
        [agedata addObject:[NSString stringWithFormat:@"%d",i]];
    }
}
-(void)cigarecalculate
{
    for (int i=1; i<=180; i++)
    {
        [weightarr addObject:[NSString stringWithFormat:@"%d",i]];
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
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    if (thePickerView==_agepickr)
    {
        return  agedata.count;
    }
    if (thePickerView==_heightpickr)
    {
        return [data count];
    }
    if (thePickerView==_weightpickr)
    {
        return [weightarr count];
    }
    return 0;
    
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (thePickerView==_agepickr)
    {
        return [agedata objectAtIndex:row];
    }
    if (thePickerView==_heightpickr)
    {
        return [data objectAtIndex:row];
    }
    if (thePickerView==_weightpickr)
    {
        return [weightarr objectAtIndex:row];
    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //strageselect=[NSString stringWithFormat:@"%@",[data objectAtIndex:row]];
}
- (IBAction)backviewbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)agebtn:(id)sender
{
    if (_agepickview.hidden==YES)
    {
        _agepickview.hidden=NO;
        
    }
    else
    {
        _agepickview.hidden=NO;
    }

}
- (IBAction)hrightbtn:(id)sender
{
    if (_heightshowview.hidden==YES)
    {
        _heightshowview.hidden=NO;
        
    }
    else
    {
        _heightshowview.hidden=NO;
    }
}
- (IBAction)agehidebtn:(id)sender
{
    NSUInteger num = [[self.agepickr dataSource] numberOfComponentsInPickerView:self.agepickr];
    NSMutableString *text1 = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [self.agepickr selectedRowInComponent:i];
        NSString *number = [[self.agepickr delegate] pickerView:self.agepickr titleForRow:selectRow forComponent:i];
        [text1 appendFormat:@"%@",number];
        NSLog(@"%@",text1);
        stragestore=text1;
        [_ageshowbtn setTitle:text1 forState:UIControlStateNormal];
        [_ageshowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    _agepickview.hidden=YES;
   

}
- (IBAction)hideheightviewbtn:(id)sender
{
    NSUInteger num = [[self.heightpickr dataSource] numberOfComponentsInPickerView:self.heightpickr];
    NSMutableString *text1 = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [self.heightpickr selectedRowInComponent:i];
        NSString *number = [[self.heightpickr delegate] pickerView:self.heightpickr titleForRow:selectRow forComponent:i];
        [text1 appendFormat:@"%@",number];
        heightstr=text1;
        NSString *strheights=@"cm";
        NSString *strtotal=[NSString stringWithFormat:@"%@ %@",text1,strheights];
        [_heighshowbtn setTitle:strtotal forState:UIControlStateNormal];
        [_heighshowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    _heightshowview.hidden=YES;

}
- (IBAction)showweightbtn:(id)sender
{
    if (_weightpickrview.hidden==YES)
    {
        _weightpickrview.hidden=NO;
        
    }
    else
    {
        _weightpickrview.hidden=NO;
    }
}
- (IBAction)weighthidebtn:(id)sender
{
    NSUInteger num = [[self.weightpickr dataSource] numberOfComponentsInPickerView:self.weightpickr];
    NSMutableString *text1 = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [self.weightpickr selectedRowInComponent:i];
        NSString *number = [[self.weightpickr delegate] pickerView:self.weightpickr titleForRow:selectRow forComponent:i];
        [text1 appendFormat:@"%@",number];
        weightstr=text1;
        NSLog(@"%@",text1);
//        stragestore=text1;
        NSString *strkg=@"Kg";
        NSString *strtotal=[NSString stringWithFormat:@"%@ %@",text1,strkg];
        [_weightshowbtn setTitle:strtotal forState:UIControlStateNormal];
        [_weightshowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    _weightpickrview.hidden=YES;
}
- (IBAction)timeselectbtn:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"When You Eat Most?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Regularly" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                eattime=@"Regularly";
                                [_timeshowbtn setTitle:@"Regularly" forState:UIControlStateNormal];
                                [_timeshowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"An Alternate day" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                eattime=@"An Alternate day";
                                [_timeshowbtn setTitle:@"An Alternate day" forState:UIControlStateNormal];
                                [_timeshowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Once in a week" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                 eattime=@"once in a week";
                                [_timeshowbtn setTitle:@"Once in a week" forState:UIControlStateNormal];
                                [_timeshowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Twice in a Week" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                eattime=@"Twice in a Week";
                                [_timeshowbtn setTitle:@"Twice in a Week" forState:UIControlStateNormal];
                                [_timeshowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Twice in a Month" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                eattime=@"Twice in a Month";
                                [_timeshowbtn setTitle:@"Twice in a Month" forState:UIControlStateNormal];
                                [_timeshowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Not Certain" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                eattime=@"Not Certain";
                                [_timeshowbtn setTitle:@"Not Certain" forState:UIControlStateNormal];
                                [_timeshowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (IBAction)habitbtn:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"how many time you want to reduce?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Once in a Month" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                reducestr=@"once in month";
                                [_habitviewbtn setTitle:@"Once in a Month" forState:UIControlStateNormal];
                                [_habitviewbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Never" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                reducestr=@"never";
                                [_habitviewbtn setTitle:@"Never" forState:UIControlStateNormal];
                                [_habitviewbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Twice in a Month" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                reducestr=@"Twice in a Month";
                                [_habitviewbtn setTitle:@"Twice in a Month" forState:UIControlStateNormal];
                                [_habitviewbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (IBAction)continbtn:(id)sender
{
    if (reducestr.length>0 && weightstr.length>0 && heightstr.length>0 && stragestore.length>0 && eattime.length>0)
    {
        NSArray *keys = [NSArray arrayWithObjects:@"age", @"height", @"weight",@"eatingtime",@"fastfoodstatus",nil];
        
        NSArray *objects = [NSArray arrayWithObjects:stragestore,heightstr,weightstr,eattime,reducestr,nil];
        dictweightdata = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        if (dictweightdata>0)
        {
            [self performSegueWithIdentifier:@"weightsetgoal-id" sender:sender];
        }
        else
        {
            NSLog(@"No ..data Found");
        }

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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"weightsetgoal-id"])
    {
         anotherweightview *anotherwighview = segue.destinationViewController;
        anotherwighview.dictweight=dictweightdata;
        
    }
    
}

@end
