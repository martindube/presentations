
Function Parse-Event {
    # Credit: https://github.com/RamblingCookieMonster/PowerShell/blob/master/Get-WinEventData.ps1
    param(
        [Parameter(ValueFromPipeline=$true)] $Event
    )

    Process
    {
        foreach($entry in $Event)
        {
            $XML = [xml]$entry.ToXml()
            $X = $XML.Event.EventData.Data
            For( $i=0; $i -lt $X.count; $i++ ){
                $Entry = Add-Member -InputObject $entry -MemberType NoteProperty -Name "$($X[$i].name)" -Value $X[$i].'#text' -Force -Passthru
            }
            $Entry
        }
    }
}

function Write-Alert($Type, $Output){
    Write-Host "$($Type): $($Output)"
    #Write-Host "`n"
}

#
#            if($_.Id -eq 3){ # NetworkConnection
#                Write-Alert "Network Connection" "$($_.Image) connected to $($_.DestinationIp + ':' + $_.DestinationPort) ($($_.DestinationHostname))"
#            }
#

$LogName = "Microsoft-Windows-Sysmon"

Write-Host "`n`t[+] MehSIEM! (Ctrl-C to Exit)`n"

$Index = (Get-WinEvent -provider $LogName -max 1).RecordId
while ($true)
{
    Start-Sleep -Seconds 1

    $NewIndex  = (Get-WinEvent -provider $LogName -max 1).RecordId
    if ($NewIndex -gt $Index) {
        Get-WinEvent -provider $LogName -max ($NewIndex - $Index) | Parse-Event | sort RecordId | % {
            if($_.Id -eq 1){ # CreateProcess
                Write-Alert "Process Creation" "$($_.ParentCommandLine) started $($_.CommandLine) ($($_.ProcessId))"
            }

            if($_.Id -eq 8){ # CreateRemoteThread
                Write-Alert "Process Injection" "$($_.SourceImage) injected code into $($_.TargetImage)"
            }
			
			if($_.Id -eq 10){ # ProcessAccess
                Write-Alert "Process Access" "$($_.SourceImage) attached to $($_.TargetImage)"
            }
        }
    }
    $Index = $NewIndex

    if($Host.UI.RawUI.KeyAvailable -and (3 -eq [int]$Host.UI.RawUI.ReadKey("AllowCtrlC,IncludeKeyUp,NoEcho").Character)){ return; }
}