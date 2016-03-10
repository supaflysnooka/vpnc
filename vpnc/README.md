=======
Install vpnc on Mac OSX El Capitan

Install via Homebrew
Press Command+Space and type Terminal and press enter/return key.
Run in Terminal app:
 ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
 and press enter/return key. Wait for the command to finish.
Run:
 brew install vpnc
Jump down to 'configure vpnc' section below

Alternate method using MacPorts
Install the Apple Xcode development system (either through the app store or through https://developer.apple.com/downloads/  [search for xcode] ) as well as the Command Line Tools.  At the time of this writing, 7.2 was available:
http://adcdownload.apple.com/Developer_Tools/Xcode_7.2/Xcode_7.2.dmg
and
http://adcdownload.apple.com/Developer_Tools/Command_Line_Tools_OS_X_10.10_for_Xcode_7.2/Command_Line_Tools_OS_X_10.10_for_Xcode_7.2.dmg
Download and Install MacPorts.  The easiest method is to download the .pkg file from macports.org:  https://distfiles.macports.org/MacPorts/MacPorts-2.3.4-10.11-ElCapitan.pkg
Install macports (via command line) using the following command:  sudo installer -pkg /path/to/package.pkg -target /
Run port install vpnc which, at the time of this writing, will install vpnc 0.5.3
Configure vpnc
Create a backup of the current default.conf file (typically located in): /opt/local/etc/vpnc/ or /usr/local/etc/vpnc
Edit the file (using vi/nano/emacs) to **include the following:

IPSec gateway 96.63.70.15
IPSec ID Asurion-SecureID-2014
IPSec secret D0ntGu3$$M3
Xauth username firstname.lastname #replace with your personal ID
DPD idle timeout (our side) 0

**PLEASE NOTE:  You will receive an error if there are any spaces or special characters at the beginning or end of the lines in each entry.  In vi, you can display these characters by typing :set list use :set nolist to turn this option off.

(Optional) Import the VPN SSL certificate (attached) to your mac
When connecting to your SSL VPN, a message may show regarding the cert not being in the chain may appear.  You may install the certificate to your mac so that it is implicitly trusted.
Pull the certificate down utilizing the openssl command (e.g.  openssl s_client -connect vpn.asurion.com:443 </dev/null 2>/dev/null|openssl x509 -outform PEM >/Users/rob.birdwell/Downloads/vpn.asurion.com.pem)
Open the Keychain Access App (Through Finder > Utilities > System > Certificates)
Import the certificate (File > Import Items)

3. Start vpnc
Simply type vpnc at the command line.  For debug information (without showing password information in the logs) use vpnc --debug 3

4. Use vpnc.sh script (attached in this document) to stop/start (tested on Mac OSX El Capitan).  Feel free to rename this file to whatever you prefer
