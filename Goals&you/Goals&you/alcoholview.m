//
//  alcoholview.m
//  Goals&you
//
//  Created by Raindrops Infotech on 07/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "alcoholview.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#import "newalcoholview.h"


@interface alcoholview ()
{
    NSMutableArray *data;
    NSMutableArray *dataselect;
    NSString *strageselect;
    NSString *agestr;
    NSString *strtakensip;
    NSString *strmonthinterval;
    NSString *strlimit;
    NSDictionary *dictalcoholdata;
    
}
@end

@implementation alcoholview

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testInternetConnection];
    _ageview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _ageview.layer.borderWidth = 1.0f;
    _selectsipview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _selectsipview.layer.borderWidth = 1.0f;
    _monthselectview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _monthselectview.layer.borderWidth = 1.0f;
    _textview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _textview.layer.borderWidth = 1.0f;
    _goalsetview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _goalsetview.layer.borderWidth = 1.0f;
    data = [[NSMutableArray alloc] init];
    dataselect = [[NSMutableArray alloc] init];
    for (int i=14; i<=100; i++)
    {
        [data addObject:[NSString stringWithFormat:@"%d",i]];
    }
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    _txtname.inputAccessoryView=numberToolbar;
    _ageselectview.hidden=YES;
    _selectnumberview.hidden=YES;
    [self calculates];

    // Do any additional setup after loading the view.
}
-(void)cancelNumberPad
{
    [_txtname resignFirstResponder];
    _txtname.text=@"";
}
-(void)doneWithNumberPad
{
    [_txtname resignFirstResponder];
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

-(void)calculates
{
    for (int i=1; i<=10; i++)
    {
        [dataselect addObject:[NSString stringWithFormat:@"%d",i]];
    }
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
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    if (thePickerView==_pickrselect)
    {
        return  dataselect.count;
    }
    if (thePickerView==_agepickr)
    {
        return [data count];

    }
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (thePickerView==_pickrselect)
    {
        return [dataselect objectAtIndex:row];
    }
    if (thePickerView==_agepickr)
    {
        return [data objectAtIndex:row];
    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==_pickrselect)
    {
        strageselect=[NSString stringWithFormat:@"%@",[data objectAtIndex:row]];
    }
    else
    {
        
    }
    
}
- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)agebtn:(id)sender
{
    if (_ageselectview.hidden==NO)
    {
        _ageselectview.hidden=YES;
    }
    else
    {
        _ageselectview.hidden=NO;
    }
    
    
}
- (IBAction)hideageview:(id)sender
{
    
    //print data of selected pickerview outside didselectrow method.
    NSUInteger num = [[self.agepickr dataSource] numberOfComponentsInPickerView:self.agepickr];
    NSMutableString *text = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [self.agepickr selectedRowInComponent:i];
        NSString *number = [[self.agepickr delegate] pickerView:self.agepickr titleForRow:selectRow forComponent:i];
        [text appendFormat:@"%@",number];
        //NSLog(@"%@",text);
        agestr=text;
    }
    _ageselectview.hidden=YES;
    _arrowlbl.hidden=YES;
    [_agebtn setTitle:text forState:UIControlStateNormal];
    [_agebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (IBAction)selectsip:(id)sender
{
    if (_selectnumberview.hidden==NO)
    {
        _selectnumberview.hidden=YES;
    }
    else
    {
        _selectnumberview.hidden=NO;
    }
}
- (IBAction)hideselectview:(id)sender
{
    NSUInteger num = [[self.pickrselect dataSource] numberOfComponentsInPickerView:self.pickrselect];
    NSMutableString *text1 = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [self.pickrselect selectedRowInComponent:i];
        NSString *number = [[self.pickrselect delegate] pickerView:self.pickrselect titleForRow:selectRow forComponent:i];
        [text1 appendFormat:@"%@",number];
       // NSLog(@"%@",text1);
        strtakensip=text1;
    }
    _arrowlabl2.hidden=YES;
    _selectnumberview.hidden=YES;
    [_selectsipbtn setTitle:text1 forState:UIControlStateNormal];
    [_selectsipbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

- (IBAction)selectmonthbtn:(id)sender
{
    strmonthinterval=@"";
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Time Interval" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Regularaly" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_selectmonthbuttn setTitle:@"Regularaly" forState:UIControlStateNormal];
                                [_selectmonthbuttn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strmonthinterval=@"regularly";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"An Alternate day" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_selectmonthbuttn setTitle:@"An Alternate day" forState:UIControlStateNormal];
                                [_selectmonthbuttn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strmonthinterval=@"An Alternate day";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Once in a week" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_selectmonthbuttn setTitle:@"Once in a week" forState:UIControlStateNormal];
                                [_selectmonthbuttn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strmonthinterval=@"Once in a week";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Twice in a Week" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_selectmonthbuttn setTitle:@"Twice in a Week" forState:UIControlStateNormal];
                                [_selectmonthbuttn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strmonthinterval=@"Twice in a Week";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Twice in a Month" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_selectmonthbuttn setTitle:@"Twice in a Month" forState:UIControlStateNormal];
                                [_selectmonthbuttn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strmonthinterval=@"Twice in a Month";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Not Certain" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_selectmonthbuttn setTitle:@"Not Certain" forState:UIControlStateNormal];
                                [_selectmonthbuttn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strmonthinterval=@"Not Certain";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
-(IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==_txtname)
    {
        [self.view setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [_txtname resignFirstResponder];
    }
}

- (IBAction)limitbtn:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Time Interval" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"1" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_limitbuttn setTitle:@"1" forState:UIControlStateNormal];
                                [_limitbuttn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                               strlimit=@"1";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"2" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_limitbuttn setTitle:@"2" forState:UIControlStateNormal];
                                [_limitbuttn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strlimit=@"2";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"3" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_limitbuttn setTitle:@"3" forState:UIControlStateNormal];
                                [_limitbuttn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strlimit=@"3";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];

}
-(IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_txtname)
    {
        [self.view setFrame:CGRectMake(0,-114, self.view.frame.size.width, self.view.frame.size.height)];
        
    }
}
- (IBAction)continuebtn:(id)sender
{
    if (_txtname.text.length>0 && strlimit.length>0 && strtakensip.length>0 && strmonthinterval.length>0 && agestr.length>0)
    {
        NSArray *keys = [NSArray arrayWithObjects:@"age", @"totalsip", @"monthtime", @"motivator",@"limitpack",nil];
        
        NSArray *objects = [NSArray arrayWithObjects:strageselect,strtakensip,strmonthinterval,_txtname.text,strlimit, nil];
        dictalcoholdata = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        if (dictalcoholdata>0)
        {
            [self performSegueWithIdentifier:@"alcoholpage2-id" sender:sender];

        }
        else
        {
            NSLog(@"no data sent to next view");
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
    if ([segue.identifier isEqualToString:@"alcoholpage2-id"])
    {
         newalcoholview *anotherview = segue.destinationViewController;
        anotherview.dictalcohol=dictalcoholdata;
        
    }
    
}

@end
