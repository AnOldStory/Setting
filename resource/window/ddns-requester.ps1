<# ddns-requester.ps1 #>
# get request for ddns 

function SendGetRequest([string]$url) {
    try { 
        iwr -Uri $url
    } catch {
        echo "request failed $url"
    }
}

function EncodeMSG([string]$txt) {
    #how to handle additional querystring
    $msg = Read-Host -Prompt "Enter message"
    $encmsg = [System.Web.HttpUtility]::UrlEncode($msg)
    return $encmsg
}

SendGetRequest("https://anoldstory.com/ping")
SendGetRequest("https://anoldstory.net/ping")
SendGetRequest("https://www.duckdns.org/update?domains=anoldstory-$Env:a_device&token=$Env:a_ddns&ip=")
