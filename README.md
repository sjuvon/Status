# Status README

Welcome.  This is a small toy app for displaying real-time RAM statistics on Mac OS X, the sort of stats you see in Mac's Activity Monitor.  The difference is, this app's implemented in the menu bar for better convenience.

Everything is written in Swift using XCode, versions 4.0.3 and 9.2 respectively.  As is, the app's specifically for Mac OS X 10.12 Sierra, although it should work for all 64-bit Mac OSs with minor tweaks.

The app's still a work in progress.  Some things on the to-do list:
  1) *Add functionality for changing the stat displayed on the menu bar.*  Currently, the default is the amount of RAM used.
  2) *Add functionality for displaying the top active processes, ranked by memory usage.*
  3) *Extend the app to cover more things: CPU, network, battery, etc.*
  
Hopefully I'll get to this when time permits.  For now, I'm happy with the app as is; what started off as a quick side project turned into a great learning experience!

There was a lot of trial and error involved with writing this app, but I'd like to mention a few sources that helped me tremendously along the way:
  - [The GNU Mach Reference Manual](https://www.gnu.org/software/hurd/gnumach-doc/index.html),
  - The various Objective-C headers found in /usr/include,
  - Alexis Gallagher and [his posts over at Stack Overflow](https://stackoverflow.com/users/577888/algal),
  - Mike Bradshaw and [his posts on Stack Overflow](https://stackoverflow.com/users/475228/bmike),
  - And finally, [Serhiy Mytrovtsiy and his app](https://github.com/exelban/stats).  You should check out Serhiy's app if you'd like an excellent, production-grade version of this one!
