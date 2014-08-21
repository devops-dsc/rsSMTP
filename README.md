rsSMTP
======
<pre>
WindowsFeature SMTP-Server
{
   Ensure = "Present"
   Name = "SMTP-Server"
}
WindowsFeature Web-WMI
{
   Ensure = "Present"
   Name = "Web-WMI"
} 
rsSMTP SMTPconfig
{
    ListenerPort = "25"
    SmartHost = "smtp.mailenable.com"
    FQDN = $env:COMPUTERNAME + ".local"
    RouteUserName = "Admin"
    RoutePassword = "Me"
    RouteAction = "268"
    RemoteSMTPPort = "587"
    LogFileDirectory = "C:\IISLogs\smtp"
    LogType = "1"
    LogExtFileWin32Status = $True
    RelayIpList = @("127.0.0.1")
}
</pre>