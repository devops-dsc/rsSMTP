function Get-TargetResource
{
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]$ListenerPort
    )

    if(!(Get-WindowsFeature -Name SMTP-Server).Installed)
    {
        Throw "Please ensure that SMTP-Server feature is installed."
    }
    if(!(Get-WindowsFeature -Name Web-WMI).Installed)
    {
        Throw "Please ensure that Web-WMI feature is installed."
    }
    $SMTPServer = Get-WmiObject -class IISSmtpServerSetting -namespace "ROOT\MicrosoftIISv2"
    $returnvalue = @{
        ListenerPort = $SMTPServer.ServerBindings.Port
        SmartHost = $SMTPServer.SmartHost
        FQDN = $SMTPServer.FullyQualifiedDomainName
        RouteUsername = $SMTPServer.RouteUserName
        RoutePassword = $SMTPServer.RoutePassword
        RouteAction = $SMTPServer.RouteAction
        RemoteSMTPPort = $SMTPServer.RemoteSMTPPort
        LogFileDirectory = $SMTPServer.LogFileDirectory
        LogType = $SMTPServer.LogType
        LogExtFileBytesRecv = $SMTPServer.LogExtFileBytesRecv
        LogExtFileBytesSent = $SMTPServer.LogExtFileBytesSent
        LogExtFileClientIp = $SMTPServer.LogExtFileClientIp
        LogExtFileComputerName = $SMTPServer.LogExtFileComputerName
        LogExtFileCookie = $SMTPServer.LogExtFileCookie
        LogExtFileDate = $SMTPServer.LogExtFileDate
        LogExtFileHost = $SMTPServer.LogExtFileHost
        LogExtFileHttpStatus = $SMTPServer.LogExtFileHttpStatus
        LogExtFileHttpSubStatus = $SMTPServer.LogExtFileHttpSubStatus
        LogExtFileMethod = $SMTPServer.LogExtFileMethod
        LogExtFileProtocolVersion = $SMTPServer.LogExtFileProtocolVersion
        LogExtFileReferer = $SMTPServer.LogExtFileReferer
        LogExtFileServerIp = $SMTPServer.LogExtFileServerIp
        LogExtFileServerPort = $SMTPServer.LogExtFileServerPort
        LogExtFileSiteName = $SMTPServer.LogExtFileSiteName
        LogExtFileTime = $SMTPServer.LogExtFileTime
        LogExtFileTimeTaken = $SMTPServer.LogExtFileTimeTaken
        LogExtFileUriQuery = $SMTPServer.LogExtFileUriQuery
        LogExtFileUriStem = $SMTPServer.LogExtFileUriStem
        LogExtFileUserAgent = $SMTPServer.LogExtFileUserAgent
        LogExtFileUserName = $SMTPServer.LogExtFileUserName
        LogExtFileWin32Status = $SMTPServer.LogExtFileWin32Status
        RelayIpList = $SMTPServer.RelayIpList
    }

    $returnvalue
}

function Set-TargetResource
{
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]$ListenerPort,

        [String]$SmartHost = $null,

        [String]$FQDN = $env:COMPUTERNAME + ".local",

        [String]$RouteUserName = $null,

        [String]$RoutePassword = $null,

        [String]$RouteAction = "0",

        [String]$RemoteSMTPPort = "25",

        [String]$LogFileDirectory = "C:\Windows\System32\LogFiles",

        [String]$LogType = "0",

        [Boolean] $LogExtFileBytesRecv = $False,

        [Boolean] $LogExtFileBytesSent = $False,

        [Boolean] $LogExtFileClientIp = $True,

        [Boolean] $LogExtFileComputerName = $False,

        [Boolean] $LogExtFileCookie = $False,

        [Boolean] $LogExtFileDate = $False,

        [Boolean] $LogExtFileHost = $False,

        [Boolean] $LogExtFileHttpStatus = $True,

        [Boolean] $LogExtFileHttpSubStatus = $False,

        [Boolean] $LogExtFileMethod = $True,

        [Boolean] $LogExtFileProtocolVersion = $False,

        [Boolean] $LogExtFileReferer = $False,

        [Boolean] $LogExtFileServerIp = $False,

        [Boolean] $LogExtFileServerPort = $False,

        [Boolean] $LogExtFileSiteName = $False,

        [Boolean] $LogExtFileTime = $True,

        [Boolean] $LogExtFileTimeTaken = $False,

        [Boolean] $LogExtFileUriQuery = $False,

        [Boolean] $LogExtFileUriStem = $True,

        [Boolean] $LogExtFileUserAgent = $False,

        [Boolean] $LogExtFileUserName = $False,

        [Boolean] $LogExtFileWin32Status = $False,

        [String[]] $RelayIpList = @("127.0.0.1")

    )
    if(!(Get-WindowsFeature -Name SMTP-Server).Installed)
    {
        Throw "Please ensure that SMTP-Server feature is installed."
    }
    if(!(Get-WindowsFeature -Name Web-WMI).Installed)
    {
        Throw "Please ensure that Web-WMI feature is installed."
    }
    $SMTPServer = Get-WmiObject -class IISSmtpServerSetting -namespace "ROOT\MicrosoftIISv2"
    $bindings = $SMTPServer.ServerBindings.Clone()
    $bindings[0].port = $ListenerPort
    $SMTPServer.SetPropertyValue("ServerBindings",$bindings); Write-Verbose "Listener Port Set"
    $SMTPServer.SmartHost = $SmartHost; Write-Verbose "SmartHost Set"
    $SMTPServer.FullyQualifiedDomainName = $FQDN; Write-Verbose "FQDN Set"
    $SMTPServer.RouteUsername = $RouteUsername; Write-Verbose "Route UserName Set"
    $SMTPServer.RoutePassword = $RoutePassword; Write-Verbose "Route Password Set"
    $SMTPServer.RouteAction = $RouteAction; Write-Verbose "Route Action Set"
    $SMTPServer.RemoteSMTPPort = $RemoteSMTPPort; Write-Verbose "Remote SMTP Port Set"
    $SMTPServer.LogType = $LogType; Write-Verbose "LogType Set"
    $SMTPServer.LogFileDirectory = $LogFileDirectory; Write-Verbose "LogFileDirectory Set"
    if (!(Test-Path $LogFileDirectory)) {New-Item -ItemType directory -Path $LogFileDirectory}

    $SMTPServer.LogExtFileBytesRecv = $LogExtFileBytesRecv; Write-Verbose "LogExtFileBytesRecv Set"
    $SMTPServer.LogExtFileBytesSent = $LogExtFileBytesSent; Write-Verbose "LogExtFileBytesSent Set"
    $SMTPServer.LogExtFileClientIp = $LogExtFileClientIp; Write-Verbose "LogExtFileClientIp Set"
    $SMTPServer.LogExtFileComputerName = $LogExtFileComputerName; Write-Verbose "LogExtFileComputerName Set"
    $SMTPServer.LogExtFileCookie = $LogExtFileCookie; Write-Verbose "LogExtFileCookie Set"
    $SMTPServer.LogExtFileDate = $LogExtFileDate; Write-Verbose "LogExtFileDate Set"
    $SMTPServer.LogExtFileHost = $LogExtFileHost; Write-Verbose "LogExtFileHost Set"
    $SMTPServer.LogExtFileHttpStatus = $LogExtFileHttpStatus; Write-Verbose "LogExtFileHttpStatus Set"
    $SMTPServer.LogExtFileHttpSubStatus = $LogExtFileHttpSubStatus; Write-Verbose "LogExtFileHttpSubStatus Set"
    $SMTPServer.LogExtFileMethod = $LogExtFileMethod; Write-Verbose "LogExtFileMethod Set"
    $SMTPServer.LogExtFileProtocolVersion = $LogExtFileProtocolVersion; Write-Verbose "LogExtFileProtocolVersion Set"
    $SMTPServer.LogExtFileReferer = $LogExtFileReferer; Write-Verbose "LogExtFileReferer Set"
    $SMTPServer.LogExtFileServerIp = $LogExtFileServerIp; Write-Verbose "LogExtFileServerIp Set"
    $SMTPServer.LogExtFileServerPort = $LogExtFileServerPort; Write-Verbose "LogExtFileServerPort Set"
    $SMTPServer.LogExtFileSiteName = $LogExtFileSiteName; Write-Verbose "LogExtFileSiteName Set"
    $SMTPServer.LogExtFileTime = $LogExtFileTime; Write-Verbose "LogExtFileTime Set"
    $SMTPServer.LogExtFileTimeTaken = $LogExtFileTimeTaken; Write-Verbose "LogExtFileTimeTaken Set"
    $SMTPServer.LogExtFileUriQuery = $LogExtFileUriQuery; Write-Verbose "LogExtFileUriQuery Set"
    $SMTPServer.LogExtFileUriStem = $LogExtFileUriStem; Write-Verbose "LogExtFileUriStem Set"
    $SMTPServer.LogExtFileUserAgent = $LogExtFileUserAgent; Write-Verbose "LogExtFileUserAgent Set"
    $SMTPServer.LogExtFileUserName = $LogExtFileUserName; Write-Verbose "LogExtFileUserName Set"
    $SMTPServer.LogExtFileWin32Status = $LogExtFileWin32Status; Write-Verbose "LogExtFileWin32Status Set"

    $bytes = [byte[]]($RelayIpList -split '\.')
    $IPGrant = [byte[]](24,0,0,128,32,0,0,128,60,0,0,128,68,0,0,128,1,0,0,0,76,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,2,0,0,0,2,0,0,0,4,0,0,0,0,0,0,0,76,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255)
    $IPGrant = $IPGrant + $bytes
    $IPGrant[36] = $RelayIpList.count
    $IPGrant[44] = $RelayIpList.count + 1
    $SMTPServer.SetPropertyValue("RelayIpList",$IPGrant);Write-Verbose "RelayIPList Set"

    $SMTPServer.Put()
}

function Test-TargetResource
{
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]$ListenerPort,

        [String]$SmartHost = $null,

        [String]$FQDN = $env:COMPUTERNAME + ".local",

        [String]$RouteUserName = $null,

        [String]$RoutePassword = $null,

        [String]$RouteAction = "0",

        [String]$RemoteSMTPPort = "25",

        [String]$LogFileDirectory = "C:\Windows\System32\LogFiles",

        [String]$LogType = "0",

        [Boolean] $LogExtFileBytesRecv = $False,

        [Boolean] $LogExtFileBytesSent = $False,

        [Boolean] $LogExtFileClientIp = $True,

        [Boolean] $LogExtFileComputerName = $False,

        [Boolean] $LogExtFileCookie = $False,

        [Boolean] $LogExtFileDate = $False,

        [Boolean] $LogExtFileHost = $False,

        [Boolean] $LogExtFileHttpStatus = $True,

        [Boolean] $LogExtFileHttpSubStatus = $False,

        [Boolean] $LogExtFileMethod = $True,

        [Boolean] $LogExtFileProtocolVersion = $False,

        [Boolean] $LogExtFileReferer = $False,

        [Boolean] $LogExtFileServerIp = $False,

        [Boolean] $LogExtFileServerPort = $False,

        [Boolean] $LogExtFileSiteName = $False,

        [Boolean] $LogExtFileTime = $True,

        [Boolean] $LogExtFileTimeTaken = $False,

        [Boolean] $LogExtFileUriQuery = $False,

        [Boolean] $LogExtFileUriStem = $True,

        [Boolean] $LogExtFileUserAgent = $False,

        [Boolean] $LogExtFileUserName = $False,

        [Boolean] $LogExtFileWin32Status = $False,

        [String[]] $RelayIpList = @("127.0.0.1")

    )
    if(!(Get-WindowsFeature -Name SMTP-Server).Installed)
    {
        Throw "Please ensure that SMTP-Server feature is installed."
    }
    if(!(Get-WindowsFeature -Name Web-WMI).Installed)
    {
        Throw "Please ensure that Web-WMI feature is installed."
    }
    $testresult = $true
    
    $SMTPServer = Get-WmiObject -class IISSmtpServerSetting -namespace "ROOT\MicrosoftIISv2"

    if($SMTPServer.ServerBindings.Port -ne $ListenerPort) {Write-Verbose "ServerBinding Needs to be updated";$testresult = $false}
    if($SMTPServer.SmartHost -ne $SmartHost) {Write-Verbose "SmartHost Needs to be updated";$testresult = $false}
    if($SMTPServer.FullyQualifiedDomainName -ne $FQDN) {Write-Verbose "FQDN Needs to be updated";$testresult = $false}
    if($SMTPServer.RouteUserName -ne $RouteUsername) {Write-Verbose "RouteUsername Needs to be updated";$testresult = $false}
    if($SMTPServer.RoutePassword -ne $RoutePassword) {Write-Verbose "RoutePassword Needs to be updated";$testresult = $false}
    if($SMTPServer.RouteAction -ne $RouteAction) {Write-Verbose "RouteAction Needs to be updated";$testresult = $false}
    if($SMTPServer.RemoteSMTPPort -ne $RemoteSMTPPort) {Write-Verbose "RemoteSMTPPort Needs to be updated";$testresult = $false}
    if($SMTPServer.LogFileDirectory -ne $LogFileDirectory) {Write-Verbose "LogFileDirectory Needs to be updated";$testresult = $false}
    if($SMTPServer.LogType -ne $LogType) {Write-Verbose "LogType Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileBytesRecv -ne $LogExtFileBytesRecv) {Write-Verbose "LogExtFileBytesRecv Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileBytesSent -ne $LogExtFileBytesSent) {Write-Verbose "LogExtFileBytesSent Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileClientIp -ne $LogExtFileClientIp) {Write-Verbose "LogExtFileClientIp Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileComputerName -ne $LogExtFileComputerName) {Write-Verbose "LogExtFileComputerName Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileCookie -ne $LogExtFileCookie) {Write-Verbose "LogExtFileCookie Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileDate -ne $LogExtFileDate) {Write-Verbose "LogExtFileDate Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileHost -ne $LogExtFileHost) {Write-Verbose "LogExtFileHost Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileHttpStatus -ne $LogExtFileHttpStatus) {Write-Verbose "LogExtFileHttpStatus Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileHttpSubStatus -ne $LogExtFileHttpSubStatus) {Write-Verbose "LogExtFileHttpSubStatus Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileMethod -ne $LogExtFileMethod) {Write-Verbose "LogExtFileMethod Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileProtocolVersion -ne $LogExtFileProtocolVersion) {Write-Verbose "LogExtFileProtocolVersion Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileReferer -ne $LogExtFileReferer) {Write-Verbose "LogExtFileReferer Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileServerIp -ne $LogExtFileServerIp) {Write-Verbose "LogExtFileServerIp Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileServerPort -ne $LogExtFileServerPort) {Write-Verbose "LogExtFileServerPort Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileSiteName -ne $LogExtFileSiteName) {Write-Verbose "LogExtFileSiteName Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileTime -ne $LogExtFileTime) {Write-Verbose "LogExtFileTime Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileTimeTaken -ne $LogExtFileTimeTaken) {Write-Verbose "LogExtFileTimeTaken Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileUriQuery -ne $LogExtFileUriQuery) {Write-Verbose "LogExtFileUriQuery Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileUriStem -ne $LogExtFileUriStem) {Write-Verbose "LogExtFileUriStem Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileUserAgent -ne $LogExtFileUserAgent) {Write-Verbose "LogExtFileUserAgent Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileUserName -ne $LogExtFileUserName) {Write-Verbose "LogExtFileUserName Needs to be updated";$testresult = $false}
    if($SMTPServer.LogExtFileWin32Status -ne $LogExtFileWin32Status) {Write-Verbose "LogExtFileWin32Status Needs to be updated";$testresult = $false}

    $bytes = [byte[]]($RelayIpList -split '\.')
    $IPGrant = [byte[]](24,0,0,128,32,0,0,128,60,0,0,128,68,0,0,128,1,0,0,0,76,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,2,0,0,0,2,0,0,0,4,0,0,0,0,0,0,0,76,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255)
    $IPGrant = $IPGrant + $bytes
    $IPGrant[36] = $RelayIpList.count
    $IPGrant[44] = $RelayIpList.count + 1
    if($SMTPServer.RelayIpList -ne $null -and (Compare-Object $SMTPServer.RelayIpList $IPGrant)) {Write-Verbose "IP Relay List Needs to be updated";$testresult = $false}

    $testresult
}
Export-ModuleMember -Function *-TargetResource