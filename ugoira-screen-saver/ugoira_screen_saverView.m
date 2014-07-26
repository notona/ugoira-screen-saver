//
//  ugoira_screen_saverView.m
//  ugoira-screen-saver
//
//  Created by notona on 7/24/14.
//  Copyright (c) 2014 notona. All rights reserved.
//

#import "ugoira_screen_saverView.h"
#import <WebKit/WebKit.h>

@implementation ugoira_screen_saverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    
    NSString *path = [[NSBundle bundleForClass:self.class].resourcePath stringByAppendingString:@"/index.html"];
    NSString *URLString = [NSURL fileURLWithPath:path isDirectory:NO];
    NSURL* url = [NSURL URLWithString:[URLString description]];
    
    
    /*
     NSAlert *alert = [ NSAlert alertWithMessageText: @"Message"
     defaultButton: @"OK"
     alternateButton: nil
     otherButton: nil
     informativeTextWithFormat: @"%@", url];
     
     [alert runModal];
     */
    
    WebView* webView = [[WebView alloc] initWithFrame:NSMakeRect(0, 0, frame.size.width, frame.size.height)];
    webView.frameLoadDelegate = self;
    NSURLRequest *request;
    request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [webView.mainFrame loadRequest:request];
    [self addSubview:webView];
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
