//
//  ViewController.m
//  FakeTwitter
//
//  Created by Julian Hunt on 2017-06-03.
//  Copyright © 2017 Julian Hunt. All rights reserved.
//

#import "LoginViewController.h"
#import "NetworkEngine.h"

@interface LoginViewController ()

// Icon view that displays the twitter logo
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

// Label that displays the welcome text
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

// Label that displays the description text
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

// Triggers the login sequence
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

// Triggers sign up sequence (currently a bypass to get to table view)
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

// Takes the users username as input
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

// Secure Text field for taking the password as input
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

// Constraint for helping the top icon disappear when the keyboard appears
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconTopConstraint;

// Label to be shown when there is a login error
@property (weak, nonatomic) IBOutlet UILabel *loginErrorLabel;

@end

@implementation LoginViewController


#pragma mark
#pragma mark - Lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    _welcomeLabel.text = @"Welcome to Fake Twitter";
    _descriptionLabel.text = @"Check out my l33t iOS skills XD";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Add the observer for when the keyboard appears and disappears
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Remove the observer for when the keyboard appears and disappears
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark
#pragma mark - IBActions

/*
 Method: downSwipe
 Purpose: Called when a downward swipe gesture is recognized
 */
- (IBAction)downSwipe:(id)sender {
    [[self view] endEditing:YES];
}

/*
 Method: loginAction
 Purpose: Called when the login button is pressed
 */
- (IBAction)loginAction:(id)sender {
    // If text fields are hidden animate them into stack view, otherwise attempt to login
    if (_usernameTextField.hidden) {
        [self animateLoginFields];
    } else {
        //Attempt login here
        [self attemptLogin];
    }
}


#pragma mark
#pragma mark - Animations

/*
 Method: animateLoginFields
 Purpose: Animate the login fields in the stack View
 */
- (void)animateLoginFields
{
    [UIView animateWithDuration:0.3 animations:^{
        _signUpButton.hidden = YES;
    }];
    [UIView animateWithDuration:0.3 animations:^{
        _usernameTextField.hidden = NO;
        _passwordTextField.hidden = NO;
    }];
}


#pragma mark
#pragma mark - Helper Methods

/*
 Method: attempLogin
 Purpose: Attempts a async login call  and displays loading screen
 */
- (void)attemptLogin
{
    // TODO: Implement network calls
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL loginSuccess = [NetworkEngine authenticateLoginForUser:[_usernameTextField text]
                                                       withPassword:[_passwordTextField text]];
        if (loginSuccess) {
            [self succesfullLogin];
        }else{
            _loginErrorLabel.hidden = NO;
        }
        
    });
}

/*
 Method: succesfullLogin
 Purpose: Called on login success to segue to the next view
 */
- (void)succesfullLogin
{
    // Push to new view here
    [self performSegueWithIdentifier:@"homeSegue" sender:self];
}

/*
 Method: keyboardWillShow
 Purpose: Called when the keyboard appears to move view up
 */
- (void)keyboardWillShow:(NSNotification *)notification
{
    // Disable the upper constraint so the icon moves up with the keyboard
    _iconTopConstraint.active = NO;
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        self.view.frame = f;
    }];
}


/*
 Method: keyboardWillHide
 Purpose: Called when the keyboard disappears to move view down
 */
-(void)keyboardWillHide:(NSNotification *)notification
{
    // Re-enable the upper constraint so the icon moves down with the keyboard
    _iconTopConstraint.active = YES;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}



@end
