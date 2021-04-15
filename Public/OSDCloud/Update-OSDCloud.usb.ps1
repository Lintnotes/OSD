function Update-OSDCloud.usb {
    [CmdletBinding()]
    param (
        [switch]$Mirror
    )
    #=======================================================================
    #	Block
    #=======================================================================
    Block-PowerShellVersionLt5
    Block-StandardUser
    #=======================================================================
    #	USBBOOT
    #=======================================================================
    $OSDCloudWorkspace = Get-OSDCloud.workspace

    if ($OSDCloudWorkspace){
        #=======================================================================
        #	USBBOOT
        #=======================================================================
        $USBBOOT = Get-Volume.usb | Where-Object {$_.FileSystemLabel -eq 'USBBOOT'}
    
        if ($USBBOOT) {
            Write-Verbose -Verbose "Setting NewFileSystemLabel to OSDBoot"
            Set-Volume -DriveLetter $USBBOOT.DriveLetter -NewFileSystemLabel 'OSDBoot' -ErrorAction Ignore
        }
        #=======================================================================
        #	OSDBoot
        #=======================================================================
        $OSDBoot = (Get-Volume.usb | Where-Object {$_.FileSystemLabel -eq 'OSDBoot'}).DriveLetter
    
        if ($OSDBoot) {
            Write-Verbose -Verbose "Updating Volume OSDBoot with content from $OSDCloudWorkspace\Media"
            
            if ($PSBoundParameters.ContainsKey('Mirror')) {
                Write-Verbose -Verbose "Mirroring $OSDCloudWorkspace\Media to $($OSDCloud):\"
                robocopy "$OSDCloudWorkspace\Media" "$($OSDBoot):\" *.* /mir /ndl /np /njh /njs /b /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
            }
            else {
                Write-Verbose -Verbose "Copying $OSDCloudWorkspace\Media to $($OSDCloud):\"
                robocopy "$OSDCloudWorkspace\Media" "$($OSDBoot):\" *.* /e /ndl /np /njh /njs /b /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
            }
        }
        #=======================================================================
        #	OSDCloud
        #=======================================================================
        $OSDCloud = (Get-Volume.usb | Where-Object {$_.FileSystemLabel -eq 'OSDCloud'}).DriveLetter
    
        if ($OSDCloud) {
            if ($PSBoundParameters.ContainsKey('Mirror')) {
                if (Test-Path "$OSDCloudWorkspace\Autopilot") {
                    Write-Verbose -Verbose "Mirroring $OSDCloudWorkspace\Autopilot to $($OSDCloud):\OSDCloud\Autopilot"
                    robocopy "$OSDCloudWorkspace\Autopilot" "$($OSDCloud):\OSDCloud\Autopilot" *.* /mir /mt /ndl /njh /njs /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
                }
                
                if (Test-Path "$OSDCloudWorkspace\DriverPacks") {
                    Write-Verbose -Verbose "Mirroring $OSDCloudWorkspace\DriverPacks to $($OSDCloud):\OSDCloud\DriverPacks"
                    robocopy "$OSDCloudWorkspace\DriverPacks" "$($OSDCloud):\OSDCloud\DriverPacks" *.* /mir /mt /ndl /njh /njs /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
                }
                
                if (Test-Path "$OSDCloudWorkspace\ODT") {
                    Write-Verbose -Verbose "Mirroring $OSDCloudWorkspace\ODT to $($OSDCloud):\OSDCloud\ODT"
                    robocopy "$OSDCloudWorkspace\ODT" "$($OSDCloud):\OSDCloud\ODT" *.* /mir /mt /ndl /njh /njs /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
                }
                
                if (Test-Path "$OSDCloudWorkspace\OS") {
                    Write-Verbose -Verbose "Mirroring $OSDCloudWorkspace\OS to $($OSDCloud):\OSDCloud\OS"
                    robocopy "$OSDCloudWorkspace\OS" "$($OSDCloud):\OSDCloud\OS" *.* /mir /mt /ndl /njh /njs /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
                }
                
                if (Test-Path "$OSDCloudWorkspace\PowerShell") {
                    Write-Verbose -Verbose "Mirroring $OSDCloudWorkspace\PowerShell to $($OSDCloud):\OSDCloud\PowerShell"
                    robocopy "$OSDCloudWorkspace\PowerShell" "$($OSDCloud):\OSDCloud\PowerShell" *.* /mir /mt /ndl /njh /njs /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
                }
            }
            else {
                if (Test-Path "$OSDCloudWorkspace\Autopilot") {
                    if (Test-Path "$OSDCloudWorkspace\Autopilot") {
                        Write-Verbose -Verbose "Copying $OSDCloudWorkspace\Autopilot to $($OSDCloud):\OSDCloud\Autopilot"
                        robocopy "$OSDCloudWorkspace\Autopilot" "$($OSDCloud):\OSDCloud\Autopilot" *.* /e /mt /ndl /njh /njs /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
                    }
                    
                    if (Test-Path "$OSDCloudWorkspace\DriverPacks") {
                        Write-Verbose -Verbose "Copying $OSDCloudWorkspace\DriverPacks to $($OSDCloud):\OSDCloud\DriverPacks"
                        robocopy "$OSDCloudWorkspace\DriverPacks" "$($OSDCloud):\OSDCloud\DriverPacks" *.* /e /mt /ndl /njh /njs /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
                    }
                    
                    if (Test-Path "$OSDCloudWorkspace\ODT") {
                        Write-Verbose -Verbose "Copying $OSDCloudWorkspace\ODT to $($OSDCloud):\OSDCloud\ODT"
                        robocopy "$OSDCloudWorkspace\ODT" "$($OSDCloud):\OSDCloud\ODT" *.* /e /mt /ndl /njh /njs /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
                    }
                    
                    if (Test-Path "$OSDCloudWorkspace\OS") {
                        Write-Verbose -Verbose "Copying $OSDCloudWorkspace\OS to $($OSDCloud):\OSDCloud\OS"
                        robocopy "$OSDCloudWorkspace\OS" "$($OSDCloud):\OSDCloud\OS" *.* /e /mt /ndl /njh /njs /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
                    }
                    
                    if (Test-Path "$OSDCloudWorkspace\PowerShell") {
                        Write-Verbose -Verbose "Copying $OSDCloudWorkspace\PowerShell to $($OSDCloud):\OSDCloud\PowerShell"
                        robocopy "$OSDCloudWorkspace\PowerShell" "$($OSDCloud):\OSDCloud\PowerShell" *.* /e /mt /ndl /njh /njs /r:0 /w:0 /zb /xd "$RECYCLE.BIN" "System Volume Information"
                    }
                }
            }
        }
        #=======================================================================
    }
    else {
        Write-Warning "Could not find the path to OSDCloud.workspace"
    }
    #=======================================================================
}