function Show-Computer
{
    <#
    .SYNOPSIS
    Show specified computer in Honolulu

    .DESCRIPTION
    Takes the specified computer and crafts the needed URL to load it in Project Honolulu

    .PARAMETER ComputerName
    Parameter description

    .PARAMETER View
    The view to show by default.

    .EXAMPLE
    Show-Computer

    Will show the local computer in Project Honolulu

    .EXAMPLE
    Show-Computer -ComputerName server02

    .NOTES
    General notes
    #>

    [CmdletBinding()]
    param(
        $ComputerName = $env:COMPUTERNAME,
        $View = 'overview'
    )

    begin
    {
        $info = Get-HonoluluServer
        $uri = 'http://{0}:{1}' -f $info.ComputerName, $info.Port
    }
    process
    {
        try
        {
            foreach ($node in $ComputerName)
            {
                Start-Process "$uri/servermanager/connections/server/$node/tools/$View"
            }
        }
        catch
        {
            $PSCmdlet.ThrowTerminatingError( $PSItem )
        }
    }
}