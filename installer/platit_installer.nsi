; Plat it - Social Music (c) Baraily Innovation
; NSIS installer for the Windows desktop build.
; Run after: flutter build windows --release
;   makensis platit_installer.nsi

!define APPNAME "Plat it"
!define COMPANY "Baraily Innovation"
!define VERSION "0.1.0"
!define BUILDDIR "..\build\windows\x64\runner\Release"
!define INSTALLDIR "$PROGRAMFILES64\${COMPANY}\${APPNAME}"

Name "${APPNAME}"
OutFile "platit-${VERSION}-setup.exe"
InstallDir "${INSTALLDIR}"
RequestExecutionLevel admin

!include "MUI2.nsh"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

Section "Install"
  SetOutPath "$INSTDIR"
  File /r "${BUILDDIR}\*.*"
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  CreateShortcut "$DESKTOP\${APPNAME}.lnk" "$INSTDIR\platit.exe"
  CreateShortcut "$SMPROGRAMS\${COMPANY}\${APPNAME}.lnk" "$INSTDIR\platit.exe"
SectionEnd

Section "Uninstall"
  Delete "$INSTDIR\Uninstall.exe"
  RMDir /r "$INSTDIR"
  Delete "$DESKTOP\${APPNAME}.lnk"
  Delete "$SMPROGRAMS\${COMPANY}\${APPNAME}.lnk"
SectionEnd
