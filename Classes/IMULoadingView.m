//
//  IMULoadingView.m
//
//  Created by Bryce Hammond on 10/10/13.
//  Copyright (c) 2013 Imulus, LLC. All rights reserved.
//

#import "IMULoadingView.h"
#import <QuartzCore/QuartzCore.h>

#define kActivityIndicatorSize			24
#define kDefaultLoadingMessage			@"Loading"
#define kDefaultPanelCornerRadius		10
#define kDefaultPanelHorizPadding		10
#define kDefaultPanelVertPadding		5
#define kDefaultPanelVertOffset        -37
#define kDefaultSpacing					5
#define kMinLabelWidth					140
#define kMaxLabelWidth					180

#define kDefaultBgColor             [UIColor blackColor]
#define kDefaultPanelBgColor        [UIColor whiteColor]
#define kDefaultPanelBorderColor    [UIColor clearColor]
#define kDefaultPanelTextColor      [UIColor blackColor]

#define kDefaultPanelFont           [UIFont fontWithName:@"Helvetica" size:12]

@interface IMULoadingView ()

@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *messagePanel;
@property (nonatomic, assign) CGRect messagePanelFrame;

@end

@implementation IMULoadingView

- (id)initWithFrame:(CGRect)frame message:(NSString *)message activityIndicator:(BOOL)yesNo {
	if (self = [super initWithFrame:frame]) {
        [self setupDefaultView];
        self.message = message;
        self.showActivityIndicator = yesNo;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame message:kDefaultLoadingMessage activityIndicator:YES];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupDefaultView];
}

- (void)setupDefaultView
{
    self.backgroundColor = kDefaultBgColor;
    self.panelCornerRadius = kDefaultPanelCornerRadius;
    self.panelBgColor = kDefaultPanelBgColor;
    self.panelBorderColor = kDefaultPanelBorderColor;
    self.panelTextColor = kDefaultPanelTextColor;
    self.panelFont = kDefaultPanelFont;
    self.panelVerticalOffset = kDefaultPanelVertOffset;
}

- (void)layoutSubviews
{
    //remove the current message panel
    [self.messagePanel removeFromSuperview];
    self.messagePanel = nil;
	
	// Figure out how much space the loading message will take up
	CGSize messageLabelSize = CGSizeZero;
	if(nil != self.message)
	{
		messageLabelSize = [self.message sizeWithFont:self.panelFont
								constrainedToSize:CGSizeMake(self.frame.size.width / 2, self.frame.size.height)
									lineBreakMode:NSLineBreakByWordWrapping];
	}
    
    messageLabelSize.height += 5; //add some padding to the label size as heigh calculations could be incorrect for custom fonts
    
	if(messageLabelSize.width < kMinLabelWidth) {
		messageLabelSize.width = kMinLabelWidth;
	} else if(messageLabelSize.width > kMaxLabelWidth) {
		// for landscape
		messageLabelSize.width = kMaxLabelWidth;
	}
	
    //Calculate the size and position of where to put the panel
    
	CGSize messagePanelSize;
	
	if(self.showActivityIndicator) {
		// Based on message label size, determine the size of the panel that will hold the message, indicator, and bg
		messagePanelSize = CGSizeMake((messageLabelSize.width) + (kDefaultPanelHorizPadding * 2),
									  messageLabelSize.height + kActivityIndicatorSize + kDefaultSpacing + (kDefaultPanelVertPadding * 2));
	} else {
		messagePanelSize = CGSizeMake((messageLabelSize.width) + (kDefaultPanelHorizPadding * 2),
									  messageLabelSize.height + (kDefaultPanelVertPadding * 2));
	}
    
	CGPoint messagePanelOrigin = CGPointMake((self.frame.size.width - messagePanelSize.width) / 2,
                                             ((self.frame.size.height-messagePanelSize.height) / 2) + self.panelVerticalOffset);
	
	// Create messagePanel using messagePanelOrigin and messagePanelSize
	self.messagePanelFrame = CGRectMake(floor(messagePanelOrigin.x), floor(messagePanelOrigin.y), floor(messagePanelSize.width), floor(messagePanelSize.height));
	self.messagePanel = [[UIView alloc] initWithFrame:self.messagePanelFrame];
    self.messagePanel.backgroundColor = self.panelBgColor;
	
	
	if(self.showActivityIndicator)
    {
		// Create a loading activity indicator and add to messagePanel
		UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		[indicator setFrame:CGRectMake(((self.messagePanelFrame.size.width - kActivityIndicatorSize) / 2), kDefaultPanelVertPadding, kActivityIndicatorSize, kActivityIndicatorSize)];
		
		[self.messagePanel addSubview:indicator];
		[indicator startAnimating];
	}
	
	// Create messageLabel and add to messagePanel
	CGPoint messageLabelOrigin;
	if(self.showActivityIndicator) {
		messageLabelOrigin = CGPointMake(kDefaultPanelHorizPadding, kDefaultPanelVertPadding + kActivityIndicatorSize + kDefaultSpacing);
	} else {
		messageLabelOrigin = CGPointMake(kDefaultPanelHorizPadding, kDefaultPanelVertPadding);
	}
    
    [self.messageLabel removeFromSuperview];

	
	self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(messageLabelOrigin.x, messageLabelOrigin.y, messageLabelSize.width, messageLabelSize.height)];
    self.messageLabel.text = self.message;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.font = self.panelFont;
    self.messageLabel.textColor = self.panelTextColor;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messagePanel.layer.cornerRadius = self.panelCornerRadius;
    self.messagePanel.layer.borderColor = self.panelBorderColor.CGColor;
    self.messagePanel.layer.borderWidth = 1.0f;
    
    [self.messagePanel addSubview:self.messageLabel];
	
	[self addSubview:self.messagePanel];
    
}

- (void)setMessage:(NSString *)newMessage {
    _message = newMessage;
	[self.messageLabel setText:newMessage];
    [self setNeedsLayout];
}

@end
