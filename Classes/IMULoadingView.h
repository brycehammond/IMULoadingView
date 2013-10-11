//
//  IMULoadingView.h
//
//  Created by Bryce Hammond on 10/10/13.
//  Copyright (c) 2013 Imulus, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMULoadingView : UIView

@property (nonatomic, strong) UIColor *panelBgColor;
@property (nonatomic, strong) UIColor *panelBorderColor;
@property (nonatomic, strong) UIColor *panelTextColor;
@property (nonatomic, strong) UIFont *panelFont;
@property (nonatomic, assign) CGFloat panelCornerRadius;
@property (nonatomic, assign) CGFloat panelMinWidth;
@property (nonatomic, assign) BOOL showActivityIndicator;
@property (nonatomic, assign) CGFloat panelVerticalOffset;
@property (nonatomic, strong) NSString *message;

- (id)initWithFrame:(CGRect)frame message:(NSString *)message activityIndicator:(BOOL)yesNo;



@end
