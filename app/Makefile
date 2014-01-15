CC     ?= cc
CFLAGS ?= -O2 -g

LFLAGS = $(LIB) -framework Cocoa

all: App.app/Contents/MacOS/App

App.app/Contents/MacOS/App: AppDelegate.m View.m main.m
	/bin/sh makeapp.sh App
	$(CC) $(CFLAGS) AppDelegate.m View.m main.m $(LFLAGS) -o App.app/Contents/MacOS/App

clean:
	rm -rf app app.dSYM/ App.app/