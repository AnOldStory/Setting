<#
    ddns-requester.ps1
    - Request for DDNS 
#>
function SendGetRequest([string]$url) {
    try { 
        iwr -Uri $url
    } catch {
        echo "request failed $url"
    }
}

SendGetRequest("https://anoldstory.com/ping")
SendGetRequest("https://anoldstory.net/ping")
SendGetRequest("https://www.duckdns.org/update?domains=anoldstory&token=$Env:a_ddns&ip=")
