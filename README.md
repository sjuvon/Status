# Status README

Status is an app for displaying real-time system stats on Mac OS X, like Mac's own Activity Monitor.  The difference is, this one's implemented in the menu bar for more convenience.

Everything is written in Swift via XCode, versions 4.0.3 and 9.2 respectively.  Although Status has been made for OS X 10.12 Sierra, with appropriate tweaks, it should work for all 64-bit Macs.

This is an on-going toy project.  Currently, the app only shows basic RAM stats; the door's wide open for more:
  1) *Add functionality for displaying the top active processes, ranked by, say, memory usage.*
  2) *Figure out how to compute Activity Monitor's Memory Pressure.*  This will open doors to more functionality.
  3) *Extend the app to cover more things: CPU, network, battery, etc.*
  
All in good time.

There's been a lot of trial and error in this project; here are some resources that have helped tremendously along the way:
  - [The GNU Mach Reference Manual](https://www.gnu.org/software/hurd/gnumach-doc/index.html);
  - The various Objective-C headers found in /usr/include;
  - Alexis Gallagher and [his posts over at Stack Overflow](https://stackoverflow.com/users/577888/algal);
  - Mike Bradshaw and [his posts on Stack Overflow](https://stackoverflow.com/users/475228/bmike);
  - And finally, [Serhiy Mytrovtsiy and his app](https://github.com/exelban/stats).  Check this out for an excellent, production-grade app that accomplishes everything Status would like to do, and then some!
