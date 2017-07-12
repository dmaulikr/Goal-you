//
//  smokingview.m
//  Goals&you
//
//  Created by Raindrops Infotech on 08/03/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "smokingview.h"
#import "anothersmokingview.h"

@interface smokingview ()
{
    NSMutableArray *data;
    NSMutableArray *cigdata;
    NSString *strtimes;
    NSString *strpickr1;
    NSString *strpick2;
    NSDictionary *dictsmokedata;


}
@end

@implementation smokingview

- (void)viewDidLoad {
    [super viewDidLoad];
    _cigaratenumberview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _cigaratenumberview.layer.borderWidth = 1.0f;
    _smokingageview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _smokingageview.layer.borderWidth = 1.0f;
    _chainsmokerview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _chainsmokerview.layer.borderWidth = 1.0f;
    _reasonview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _reasonview.layer.borderWidth = 1.0f;
    _decisionview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _decisionview.layer.borderWidth = 1.0f;
     data = [[NSMutableArray alloc] init];
    cigdata = [[NSMutableArray alloc] init];
    _smkingview2.hidden=YES;
    _pickr1view.hidden=YES;
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    _txtdecision.inputAccessoryView=numberToolbar;
    _txtreason.inputAccessoryView=numberToolbar;
    for (int i=14; i<=100; i++)
    {
        [data addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self cigarecalculate];

    // Do any additional setup after loading the view.
}
-(void)cancelNumberPad
{
    if ([_txtreason isFirstResponder])
    {
        [_txtreason resignFirstResponder];
        _txtreason.text=@"";
    }
    else
    {
        [_txtdecision resignFirstResponder];
        _txtdecision.text=@"";
    }
}
-(void)doneWithNumberPad
{
    if ([_txtreason isFirstResponder])
    {
        [_txtreason resignFirstResponder];
    }
    else
    {
        [_txtdecision resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cigarecalculate
{
    for (int i=1; i<=20; i++)
    {
        [cigdata addObject:[NSString stringWithFormat:@"%d",i]];
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
    if (thePickerView==_pickerselect)
    {
        return  cigdata.count;
    }
    if (thePickerView==_pickrhabit)
    {
        return [data count];
    }
    return 0;
  
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (thePickerView==_pickerselect)
    {
        return [cigdata objectAtIndex:row];
    }
    if (thePickerView==_pickrhabit)
    {
        return [data objectAtIndex:row];
    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==_pickrhabit)
    {
        strpickr1=[NSString stringWithFormat:@"%@",[data objectAtIndex:row]];

    }
    else
    {
       strpick2=[NSString stringWithFormat:@"%@",[cigdata objectAtIndex:row]];
    }
}
- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)smokingshowbtn:(id)sender
{
    if (_pickr1view.hidden==YES)
    {
        _pickr1view.hidden=NO;

    }
    else
    {
        _pickr1view.hidden=NO;
    }
}
- (IBAction)cigarateshowbtn:(id)sender
{
    if (_smkingview2.hidden==YES)
    {
        _smkingview2.hidden=NO;
    }
    else
    {
        _smkingview2.hidden=YES;
    }
}
- (IBAction)chainsmokerbtn:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Chain Smoker?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_chainsmokershowbtn setTitle:@"Yes" forState:UIControlStateNormal];
                                [_chainsmokershowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strtimes=@"yes";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_chainsmokershowbtn setTitle:@"No" forState:UIControlStateNormal];
                                [_chainsmokershowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strtimes=@"no";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Sometimes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [_chainsmokershowbtn setTitle:@"Sometimes" forState:UIControlStateNormal];
                                [_chainsmokershowbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                strtimes=@"sometime";
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (IBAction)backdetailsbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)hidepickr1:(id)sender
{
    NSUInteger num = [[self.pickrhabit dataSource] numberOfComponentsInPickerView:self.pickrhabit];
    NSMutableString *text = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [self.pickrhabit selectedRowInComponent:i];
        NSString *number = [[self.pickrhabit delegate] pickerView:self.pickrhabit titleForRow:selectRow forComponent:i];
        [text appendFormat:@"%@",number];
        NSLog(@"%@",text);
    }
    strpickr1=text;
    [_smokingbtn setTitle:text forState:UIControlStateNormal];
    [_smokingbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _lblarrow.hidden=YES;
    _pickr1view.hidden=YES;
  


}
- (IBAction)selectcigarbtn:(id)sender
{
    NSUInteger num = [[self.pickerselect dataSource] numberOfComponentsInPickerView:self.pickerselect];
    NSMutableString *text1 = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [self.pickerselect selectedRowInComponent:i];
        NSString *number = [[self.pickerselect delegate] pickerView:self.pickerselect titleForRow:selectRow forComponent:i];
        [text1 appendFormat:@"%@",number];
        NSLog(@"%@",text1);
    }
    strpick2=text1;
    [_cigaratebtn setTitle:text1 forState:UIControlStateNormal];
    [_cigaratebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _arrowlabel2.hidden=YES;
    _smkingview2.hidden=YES;
}
-(IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_txtdecision)
    {
        [self.view setFrame:CGRectMake(0,-170, self.view.frame.size.width, self.view.frame.size.height)];
    }
    if (textField==_txtreason)
    {
        [self.view setFrame:CGRectMake(0,-85, self.view.frame.size.width, self.view.frame.size.height)];
    }
}

- (IBAction)nextviewbtn:(id)sender
{
    if (_txtreason.text.length>0 && _txtdecision.text.length>0 && strtimes.length>0 && strpick2.length>0 && strpickr1.length>0)
    {
        NSArray *keys = [NSArray arrayWithObjects:@"age", @"cigcount", @"chainsmoker",@"reason",@"inspire reason",nil];
        
        NSArray *objects = [NSArray arrayWithObjects:strpickr1,strpick2,strtimes,_txtreason.text,_txtdecision.text,nil];
        dictsmokedata = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        if (dictsmokedata>0)
        {
            [self performSegueWithIdentifier:@"anothersmokingview-id" sender:sender];

        }
        else
        {
            NSLog(@"no data send");
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
-(IBAction)textFieldDidEndEditing:(UITextField *)textField
{
   // if (textField==_txtdecision)
   // {
        [self.view setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
       // [_txtdecision resignFirstResponder];
   // }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"anothersmokingview-id"])
    {
         anothersmokingview *anothersmokeview = segue.destinationViewController;
        anothersmokeview.dictsmoke=dictsmokedata;
        
    }
    
}

@end
