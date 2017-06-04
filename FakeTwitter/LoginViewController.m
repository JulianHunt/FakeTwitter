//
//  ViewController.m
//  FakeTwitter
//
//  Created by Julian Hunt on 2017-06-03.
//  Copyright © 2017 Julian Hunt. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.x
    _welcomeLabel.text = @"Welcome to Fake Twitter";
    _descriptionLabel.text = @"Check out my l33t iOS skills XD";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender {
    // If text fields are hidden animate them into stack view, otherwise attempt to login
    if (_usernameTextField.hidden) {
        [self animateLoginFields];
    } else {
        //Attempt login here
        [self attemptLogin];
    }
}

- (void)animateLoginFields
{
    [UIView animateWithDuration:0.3 animations:^{
        _signInButton.hidden = YES;
    }];
    [UIView animateWithDuration:0.3 animations:^{
        _usernameTextField.hidden = NO;
        _passwordTextField.hidden = NO;
    }];
}

/*
    AttempLogin: Attempts a login call async and displays loading screen
 */
- (void)attemptLogin
{
    // TODO: Implement network calls
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL loginSuccess = YES;
        // Attempt login here
        sleep(3);
        if (loginSuccess) {
            [self succesfullLogin];
        }
        
    });
}

- (void)succesfullLogin
{
    // Push to new view here
    [self performSegueWithIdentifier:@"homeSegue" sender:self];
}



@end
