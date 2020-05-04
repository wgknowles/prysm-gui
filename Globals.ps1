#--------------------------------------------
# Declare Global Variables and Functions here
#--------------------------------------------

#Used for showing / hiding cmd windows
Add-Type -TypeDefinition '
	public enum ShowStates
	{
	    Hide = 0,
	    Normal = 1,
	    Minimized = 2,
	    Maximized = 3,
	    ShowNoActivateRecentPosition = 4,
	    Show = 5,
	    MinimizeActivateNext = 6,
	    MinimizeNoActivate = 7,
	    ShowNoActivate = 8,
	    Restore = 9,
	    ShowDefault = 10,
	    ForceMinimize = 11,
	}
	'
# the C#-style signature of an API function (see also www.pinvoke.net)
$code = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'

# add signature as new type to PowerShell (for this session)
$type = Add-Type -MemberDefinition $code -Name myAPI -PassThru

$hiddenWindows = [System.Collections.ArrayList]@()

#Sample function that provides the location of the script
function Get-ScriptDirectory
{
<#
	.SYNOPSIS
		Get-ScriptDirectory returns the proper location of the script.

	.OUTPUTS
		System.String
	
	.NOTES
		Returns the correct path within a packaged executable.
#>
	[OutputType([string])]
	param ()
	if ($null -ne $hostinvocation)
	{
		Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}

#Sample variable that provides the location of the script
[string]$ScriptDirectory = Get-ScriptDirectory


