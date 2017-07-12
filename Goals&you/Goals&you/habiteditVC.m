//
//  habiteditVC.m
//  Goals&you
//
//  Created by Raindrops Infotech on 02/02/17.
//  Copyright © 2017 Raindrops Infotech. All rights reserved.
//

#import "habiteditVC.h"
#import <QuartzCore/QuartzCore.h>

@interface habiteditVC ()

@end

@implementation habiteditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewshow.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _viewshow.layer.borderWidth = 1.0f;
    _viewstart.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _viewstart.layer.borderWidth = 1.0f;
    _viewend.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _viewend.layer.borderWidth = 1.0f;
    _habitview.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0] CGColor];
    _habitview.layer.borderWidth = 1.0f;


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

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
