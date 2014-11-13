//
//  EnterMasterPassword.h
//  project_MAD_Password
//
//  Created by Nishikant Raje on 11/10/14.
//  Copyright (c) 2014 UHCL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class websiteTVC;
@interface EnterMasterPassword : UIViewController
- (IBAction)Login:(id)sender;

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,retain)websiteTVC *WebsiteTVC;
@property(nonatomic,retain)UINavigationController *RootVC;

@property (retain, nonatomic) IBOutlet UITextField *masterUsernameTextField;
@property (retain, nonatomic) IBOutlet UITextField *masterPasswordTextField;
@end
