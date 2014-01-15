#import <Cocoa/Cocoa.h>

#import "View.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow *window;
    View *view;
}

- (void)populateMainMenu;
- (void)populateApplicationMenu:(NSMenu *)aMenu;

@end
