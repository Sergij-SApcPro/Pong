#NSIS Example Install Script

#Basic definitions
!define APPNAME "Pong"
!define COMPANYNAME "SApcPro"
!define DESCRIPTION "A Simple Pong Game By SApcPro."
!define APPSHORTNAME "pong"

#Ask for administrative rights
RequestExecutionLevel admin

#Other options include:
#none
#user
#highest

#Default installation location - let's clutter up our root directory!
InstallDir "C:\Program Files\Pong by SApcPro"

#Text (or RTF) file with license information. The text file must be in DOS end line format (\r\n)
#LicenseData "..\docs\license.md"

#'Name' goes in the installer's title bar
Name "Pong By SApcPro - Installer"

#Icon for the installer - this is the default icon
Icon "icon.ico"

#The following lines replace the default icons
!include "MUI2.nsh"

#The name of the installer executable
outFile "Install Pong.exe"

#...Not certain about this one
!include LogicLib.nsh

#Defines installation pages - these are known to NSIS
#Shows the license
#Page license
#Allows user to pick install path
Page directory
#Installs the files
Page instfiles

#A macro to verify that administrator rights have been acquired
!macro VerifyUserIsAdmin
UserInfo::GetAccountType
pop $0
${If} $0 != "admin" ;Require admin rights on NT4+
        messageBox mb_iconstop "Administrator rights required!"
        setErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
        quit
${EndIf}
!macroend

#This ensures the administrator check is performed at startup?
function .onInit
	setShellVarContext all
	!insertmacro VerifyUserIsAdmin
functionEnd

# Files for the install directory - to build the installer, these should be in the same directory as the install script (this file)
Section "install"
    setOutPath $INSTDIR
	
	File pong.exe
	File ball.wav
	
	WriteUninstaller $INSTDIR\Uninstall.exe
 
    #This creates a shortcut to the executable on the desktop - the second set of options in quotes are for command-line arguments
	CreateShortcut "$desktop\Pong.lnk" "$instdir\pong.exe"
 
SectionEnd

Section "Uninstall"

Delete $INSTDIR\Uninstall.exe
Delete $INSTDIR\pong.exe
Delete $INSTDIR\ball.wav
RMDir $INSTDIR

SectionEnd 