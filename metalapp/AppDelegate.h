#import <Cocoa/Cocoa.h>

#import "MetalView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow *window;
    MetalView *view;
}

- (void)populateMainMenu;
- (void)populateApplicationMenu:(NSMenu *)aMenu;

@end
