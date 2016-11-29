#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import <QuartzCore/QuartzCore.h>
#include <OpenGL/gl3.h>

#import "MetalView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow *window;
    MetalView *view;
}

- (void)populateMainMenu;
- (void)populateApplicationMenu:(NSMenu *)aMenu;

@end
