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

# ============================================================================
#                               Helper Functions
# ============================================================================

function Info($Message) {
	Write-Host "[INFO] $Message" -ForegroundColor $Global:CYAN
}

function Warning($Message) {
	Write-Host "[WARN] $Message" -ForegroundColor $Global:YELLOW
}

function Error($Message) {
	Write-Host "[ERROR] $Message" -ForegroundColor $Global:RED
}

function Debug($Message) {
	Write-Host "[DEBUG] $Message" -ForegroundColor $Global:PURPLE
}

function Success($Message) {
	Write-Host "[SUCCESS] $Message" -ForegroundColor $Global:GREEN
}

# ============================================================================
#                               Script Output
# ============================================================================

$currentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentIdentity)
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    if ($PSCommandPath) {
        # Running from a file → relaunch that file as admin
        $arguments = "-File `"$PSCommandPath`""
    } else {
        # Running inline (iwr ... | iex) → relaunch the script body
        $scriptContent = $MyInvocation.MyCommand.Definition
        $encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($scriptContent))
        $arguments = "-EncodedCommand $encoded"
    }

	if (Get-Command pwsh -ErrorAction SilentlyContinue) {
		Start-Process pwsh.exe -Verb RunAs -ArgumentList $arguments
	}else{
		Start-Process powershell.exe -Verb RunAs -ArgumentList $arguments
	}
	return
}

[System.Console]::Clear()
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Write-Host ""
Write-Host "=============================================" -ForegroundColor $Global:CYAN
Write-Host "        	Forensic Tools" -ForegroundColor $Global:GREEN
Write-Host "=============================================" -ForegroundColor $Global:CYAN
Write-Host ""

# Pretty metadata output
Write-Host ( "AUTHOR") -ForegroundColor $Global:CYAN -NoNewline
Write-Host ":" $Global:ScriptAuthor -ForegroundColor $Global:WHITE

Write-Host ("VERSION") -ForegroundColor $Global:CYAN -NoNewline
Write-Host ": $Global:ScriptVersion" -ForegroundColor $Global:WHITE

Write-Host ("DESCRIPTION") -ForegroundColor $Global:CYAN -NoNewline
Write-Host ": $Global:ScriptDescription" -ForegroundColor $Global:WHITE

Write-Host ("TOOLS ROOT")  -ForegroundColor $Global:CYAN -NoNewline
Write-Host ": $Global:ToolsRoot" -ForegroundColor $Global:WHITE

Write-Host ("OUTPUT DIR")  -ForegroundColor $Global:CYAN -NoNewline
Write-Host ": $Global:OutputDirectory" -ForegroundColor $Global:WHITE
Write-Host ""

if ($Host.Name -eq 'ConsoleHost') {
	Write-Host "Press ENTER to exit.." -ForegroundColor $Global:CYAN
	[void][System.Console]::ReadLine()
}