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
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconTopConstraint;

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (IBAction)downSwipe:(id)sender {
    [[self view] endEditing:YES];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    _iconTopConstraint.active = NO;
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    _iconTopConstraint.active = YES;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
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
