#!/usr/bin/env pwsh
<#
	============================================================================
	Script Name : script.ps1
	Author      : Armoghan-ul-Mohmin
	Date        : 2025-08-20
	Version     : 1.0.0
	----------------------------------------------------------------------------
	Description :
		This PowerShell script is designed for forensic analysis of NTFS file systems.
		Workflow:
		1. Extract the $MFT (Master File Table) using FTK Imager and save it locally.
		2. Download and install required forensic tools from the internet, saving them to a specified location.
		3. Add the tools' directory to the system PATH for global access.
		4. Use the installed tools for further $MFT analysis and processing.
	----------------------------------------------------------------------------
	Usage :
		# Run directly if downloaded:
		pwsh script.ps1
	----------------------------------------------------------------------------
	Notes :
		- Extract the $MFT file using FTK Imager before running this script.
		- Internet access is required to download and install additional tools.
		- For educational and forensic lab use only.
	============================================================================
#>

# ============================================================================
#                               Global Variables
# ============================================================================

# Script Metadata
$Global:ScriptAuthor      = "Armoghan-ul-Mohmin"
$Global:ScriptVersion     = "1.0.0"
$Global:ScriptDescription = "PowerShell script for forensic analysis of `$MFT and `$MFTMirr files"

# Tool Configuration
$Global:ToolsRoot          = "C:\tools"
$Global:MFTECmdFolder      = Join-Path $Global:ToolsRoot "MFTECmd"
$Global:MFTECmdExePath     = Join-Path $Global:MFTECmdFolder "MFTECmd.exe"
$Global:MFTECmdDownloadUrl = "https://download.ericzimmermanstools.com/MFTECmd.zip"

# Input / Output Paths
$Global:OutputDirectory = (Get-Location).Path

#  Script Output
Write-Host "Author        : $Global:ScriptAuthor"
Write-Host "Version       : $Global:ScriptVersion"
Write-Host "Description   : $Global:ScriptDescription"
Write-Host "Tools Root    : $Global:ToolsRoot"
Write-Host "MFTECmd Folder: $Global:MFTECmdFolder"
Write-Host "Executable    : $Global:MFTECmdExePath"
Write-Host "Download URL  : $Global:MFTECmdDownloadUrl"
Write-Host "Output Dir    : $Global:OutputDirectory"
