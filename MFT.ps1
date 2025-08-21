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

# ============================================================================
#                               Colors and Formatting
# ============================================================================

$Global:RED    = "Red"
$Global:GREEN  = "Green"
$Global:YELLOW = "Yellow"
$Global:CYAN   = "Cyan"
$Global:PURPLE = "Magenta"
$Global:WHITE  = "White"
$Global:BLACK  = "Black"

# ANSI formatting
$Global:Reset     = "`e[0m"
$Global:Bold      = "`e[1m"
$Global:Dim       = "`e[2m"
$Global:Underline = "`e[4m"
$Global:Blink     = "`e[5m"
$Global:Reverse   = "`e[7m"
$Global:Hidden    = "`e[8m"

# ============================================================================
#                               Helper Functions
# ============================================================================

function Info($Message) {
	Write-Host "$Global:Bold[INFO]$Global:Reset $Message" -ForegroundColor $Global:CYAN
}

function Warning($Message) {
	Write-Host "$Global:Bold[WARN]$Global:Reset $Message" -ForegroundColor $Global:YELLOW
}

function Error($Message) {
	Write-Host "$Global:Bold[ERROR]$Global:Reset $Message" -ForegroundColor $Global:RED
}

function Debug($Message) {
	Write-Host "$Global:Bold[DEBUG]$Global:Reset $Message" -ForegroundColor $Global:PURPLE
}

function Success($Message) {
	Write-Host "$Global:Bold[SUCCESS]$Global:Reset $Message" -ForegroundColor $Global:GREEN
}

# ============================================================================
#                               Script Output
# ============================================================================

Write-Host ""
Write-Host "==============================================" -ForegroundColor $Global:CYAN
Write-Host "  Forensic Analysis Script" -ForegroundColor $Global:GREEN -NoNewline
Write-Host " (v$Global:ScriptVersion)" -ForegroundColor $Global:YELLOW
Write-Host "==============================================" -ForegroundColor $Global:CYAN
Write-Host ""

Info     "Author        : $Global:ScriptAuthor"
Info     "Version       : $Global:ScriptVersion"
Success     "Description   : $Global:ScriptDescription"
Debug "Tools Root    : $Global:ToolsRoot"
Debug "MFTECmd Folder: $Global:MFTECmdFolder"
Debug "Executable    : $Global:MFTECmdExePath"
Debug "Download URL  : $Global:MFTECmdDownloadUrl"
Info     "Output Dir    : $Global:OutputDirectory"

Write-Host ""
Warning "⚠ Ensure `$MFT and `$MFTMirr are extracted with FTK Imager before running full analysis."
Write-Host ""