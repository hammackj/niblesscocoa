CC     ?= cc
CFLAGS ?= -O2 -g

LFLAGS = $(LIB) -framework Cocoa -framework OpenGL -framework QuartzCore

all: GLApp.app/Contents/MacOS/GLApp

GLApp.app/Contents/MacOS/GLApp: AppDelegate.m OpenGLView.m main.m
	/bin/sh makeapp.sh GLApp
	$(CC) $(CFLAGS) AppDelegate.m OpenGLView.m main.m $(LFLAGS) -o GLApp.app/Contents/MacOS/GLApp

clean:
	rm -rf app app.dSYM/ glapp.app/