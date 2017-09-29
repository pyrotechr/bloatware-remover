@rem  Disable Some Service 
sc stop DiagTrack
sc stop diagnosticshub.standardcollector.service
sc stop dmwappushservice
sc stop WMPNetworkSvc
sc stop WSearch

sc config DiagTrack start= disabled
sc config diagnosticshub.standardcollector.service start= disabled
sc config dmwappushservice start= disabled
REM sc config RemoteRegistry start= disabled
REM sc config TrkWks start= disabled
sc config WMPNetworkSvc start= disabled
sc config WSearch start= disabled
REM sc config SysMain start= disabled

REM  SCHEDULED TASKS tweaks 
REM schtasks Change TN MicrosoftWindowsAppIDSmartScreenSpecific Disable
schtasks Change TN MicrosoftWindowsApplication ExperienceMicrosoft Compatibility Appraiser Disable
schtasks Change TN MicrosoftWindowsApplication ExperienceProgramDataUpdater Disable
schtasks Change TN MicrosoftWindowsApplication ExperienceStartupAppTask Disable
schtasks Change TN MicrosoftWindowsCustomer Experience Improvement ProgramConsolidator Disable
schtasks Change TN MicrosoftWindowsCustomer Experience Improvement ProgramKernelCeipTask Disable
schtasks Change TN MicrosoftWindowsCustomer Experience Improvement ProgramUsbCeip Disable
schtasks Change TN MicrosoftWindowsCustomer Experience Improvement ProgramUploader Disable
schtasks Change TN MicrosoftWindowsShellFamilySafetyUpload Disable
schtasks Change TN MicrosoftOfficeOfficeTelemetryAgentLogOn Disable
schtasks Change TN MicrosoftOfficeOfficeTelemetryAgentFallBack Disable
schtasks Change TN MicrosoftOfficeOffice 15 Subscription Heartbeat Disable

REM schtasks Change TN MicrosoftWindowsAutochkProxy Disable
REM schtasks Change TN MicrosoftWindowsCloudExperienceHostCreateObjectTask Disable
REM schtasks Change TN MicrosoftWindowsDiskDiagnosticMicrosoft-Windows-DiskDiagnosticDataCollector Disable
REM schtasks Change TN MicrosoftWindowsDiskFootprintDiagnostics Disable  Not sure if should be disabled, maybe related to S.M.A.R.T.
REM schtasks Change TN MicrosoftWindowsFileHistoryFile History (maintenance mode) Disable
REM schtasks Change TN MicrosoftWindowsMaintenanceWinSAT Disable
REM schtasks Change TN MicrosoftWindowsNetTraceGatherNetworkInfo Disable
REM schtasks Change TN MicrosoftWindowsPISqm-Tasks Disable
REM The stubborn task MicrosoftWindowsSettingSyncBackgroundUploadTask can be Disabled using a simple bit change. I use a REG file for that (attached to this post).
REM schtasks Change TN MicrosoftWindowsTime SynchronizationForceSynchronizeTime Disable
REM schtasks Change TN MicrosoftWindowsTime SynchronizationSynchronizeTime Disable
REM schtasks Change TN MicrosoftWindowsWindows Error ReportingQueueReporting Disable
REM schtasks Change TN MicrosoftWindowsWindowsUpdateAutomatic App Update Disable


@rem  Remove Telemetry & Data Collection 
reg add HKLMSOFTWAREMicrosoftWindowsCurrentVersionDevice Metadata v PreventDeviceMetadataFromNetwork t REG_DWORD d 1 f
reg add HKLMSOFTWAREMicrosoftWindowsCurrentVersionPoliciesDataCollection v AllowTelemetry t REG_DWORD d 0 f
reg add HKLMSOFTWAREPoliciesMicrosoftMRT v DontOfferThroughWUAU t REG_DWORD d 1 f
reg add HKLMSOFTWAREPoliciesMicrosoftSQMClientWindows v CEIPEnable t REG_DWORD d 0 f
reg add HKLMSOFTWAREPoliciesMicrosoftWindowsAppCompat v AITEnable t REG_DWORD d 0 f
reg add HKLMSOFTWAREPoliciesMicrosoftWindowsAppCompat v DisableUAR t REG_DWORD d 1 f
reg add HKLMSOFTWAREPoliciesMicrosoftWindowsDataCollection v AllowTelemetry t REG_DWORD d 0 f
reg add HKLMSYSTEMCurrentControlSetControlWMIAutoLoggerAutoLogger-Diagtrack-Listener v Start t REG_DWORD d 0 f
reg add HKLMSYSTEMCurrentControlSetControlWMIAutoLoggerSQMLogger v Start t REG_DWORD d 0 f

@REM Settings - Privacy - General - Let apps use my advertising ID...
reg add HKCUSOFTWAREMicrosoftWindowsCurrentVersionAdvertisingInfo v Enabled t REG_DWORD d 0 f
REM - SmartScreen Filter for Store Apps Disable
reg add HKCUSOFTWAREMicrosoftWindowsCurrentVersionAppHost v EnableWebContentEvaluation t REG_DWORD d 0 f
REM - Let websites provide locally...
reg add HKCUControl PanelInternationalUser Profile v HttpAcceptLanguageOptOut t REG_DWORD d 1 f

@REM WiFi Sense HotSpot Sharing Disable
reg add HKLMSoftwareMicrosoftPolicyManagerdefaultWiFiAllowWiFiHotSpotReporting v value t REG_DWORD d 0 f
@REM WiFi Sense Shared HotSpot Auto-Connect Disable
reg add HKLMSoftwareMicrosoftPolicyManagerdefaultWiFiAllowAutoConnectToWiFiSenseHotspots v value t REG_DWORD d 0 f

@REM Change Windows Updates to Notify to schedule restart
reg add HKLMSOFTWAREMicrosoftWindowsUpdateUXSettings v UxOption t REG_DWORD d 1 f
@REM Disable P2P Update downlods outside of local network
reg add HKLMSOFTWAREMicrosoftWindowsCurrentVersionDeliveryOptimizationConfig v DODownloadMode t REG_DWORD d 0 f


REM  Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for 
REM 0 = hide completely, 1 = show only icon, 2 = show long search box
reg add HKCUSOFTWAREMicrosoftWindowsCurrentVersionSearch v SearchboxTaskbarMode t REG_DWORD d 0 f

REM  Disable MRU lists (jump lists) of XAML apps in Start Menu 
reg add HKEY_CURRENT_USERSOFTWAREMicrosoftWindowsCurrentVersionExplorerAdvanced v Start_TrackDocs t REG_DWORD d 0 f

REM  Set Windows Explorer to start on This PC instead of Quick Access 
REM 1 = This PC, 2 = Quick access
REM reg add HKEY_CURRENT_USERSOFTWAREMicrosoftWindowsCurrentVersionExplorerAdvanced v LaunchTo t REG_DWORD d 1 f

@rem Remove Apps
PowerShell -Command Get-AppxPackage 3DBuilder  Remove-AppxPackage
PowerShell -Command Get-AppxPackage Getstarted  Remove-AppxPackage
PowerShell -Command Get-AppxPackage WindowsAlarms  Remove-AppxPackage
PowerShell -Command Get-AppxPackage WindowsCamera  Remove-AppxPackage
PowerShell -Command Get-AppxPackage bing  Remove-AppxPackage
PowerShell -Command Get-AppxPackage MicrosoftOfficeHub  Remove-AppxPackage
PowerShell -Command Get-AppxPackage OneNote  Remove-AppxPackage
PowerShell -Command Get-AppxPackage people  Remove-AppxPackage
PowerShell -Command Get-AppxPackage WindowsPhone  Remove-AppxPackage
PowerShell -Command Get-AppxPackage photos  Remove-AppxPackage
PowerShell -Command Get-AppxPackage SkypeApp  Remove-AppxPackage
PowerShell -Command Get-AppxPackage solit  Remove-AppxPackage
PowerShell -Command Get-AppxPackage WindowsSoundRecorder  Remove-AppxPackage
PowerShell -Command Get-AppxPackage windowscommunicationsapps  Remove-AppxPackage
PowerShell -Command Get-AppxPackage zune  Remove-AppxPackage
REM PowerShell -Command Get-AppxPackage WindowsCalculator  Remove-AppxPackage
REM PowerShell -Command Get-AppxPackage WindowsMaps  Remove-AppxPackage
PowerShell -Command Get-AppxPackage Sway  Remove-AppxPackage
PowerShell -Command Get-AppxPackage CommsPhone  Remove-AppxPackage
PowerShell -Command Get-AppxPackage ConnectivityStore  Remove-AppxPackage
PowerShell -Command Get-AppxPackage Microsoft.Messaging  Remove-AppxPackage
PowerShell -Command Get-AppxPackage Facebook  Remove-AppxPackage
PowerShell -Command Get-AppxPackage Twitter  Remove-AppxPackage
PowerShell -Command Get-AppxPackage Drawboard PDF  Remove-AppxPackage


@rem NOW JUST SOME TWEAKS
REM  Show hidden files in Explorer 
REM reg add HKEY_CURRENT_USERSOFTWAREMicrosoftWindowsCurrentVersionExplorerAdvanced v Hidden t REG_DWORD d 1 f
 
REM  Show super hidden system files in Explorer 
REM reg add HKEY_CURRENT_USERSOFTWAREMicrosoftWindowsCurrentVersionExplorerAdvanced v ShowSuperHidden t REG_DWORD d 1 f

REM  Show file extensions in Explorer 
reg add HKEY_CURRENT_USERSOFTWAREMicrosoftWindowsCurrentVersionExplorerAdvanced v HideFileExt t  REG_DWORD d 0 f



REM  Uninstall OneDrive 
start wait  %SYSTEMROOT%SYSWOW64ONEDRIVESETUP.EXE UNINSTALL
rd COneDriveTemp Q S NUL 2&1
rd %USERPROFILE%OneDrive Q S NUL 2&1
rd %LOCALAPPDATA%MicrosoftOneDrive Q S NUL 2&1
rd %PROGRAMDATA%Microsoft OneDrive Q S NUL 2&1
reg add HKEY_CLASSES_ROOTCLSID{018D5C66-4533-4307-9B53-224DE2ED1FE6}ShellFolder f v Attributes t REG_DWORD d 0 NUL 2&1
reg add HKEY_CLASSES_ROOTWow6432NodeCLSID{018D5C66-4533-4307-9B53-224DE2ED1FE6}ShellFolder f v Attributes t REG_DWORD d 0 NUL 2&1
echo OneDrive has been removed. Windows Explorer needs to be restarted.
pause
start wait TASKKILL F IM explorer.exe
start explorer.exe