#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    // create an autorelease pool
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    // make sure the application singleton has been instantiated
    NSApplication * application = [NSApplication sharedApplication];
    
    // instantiate our application delegate
    AppDelegate * applicationDelegate = [[[AppDelegate alloc] init] autorelease];
    
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [NSApp activateIgnoringOtherApps:YES];
    
    // assign our delegate to the NSApplication
    [application setDelegate:applicationDelegate];
    
    // call the run method of our application
    [application run];
    
    // drain the autorelease pool
    [pool drain];
    
    // execution never gets here ..
    return 0;
}