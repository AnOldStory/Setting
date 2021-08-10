<###### Elevate for admin  ######>
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) 
  { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

<###### Configure ######>
$username = "thesky"
$program_name = "Setting-Manager_anoldstory" # program name for schdueler & path 
$program_path = "$($Env:ProgramData)\$($program_name)" # program path
$cdn = "https://raw.githubusercontent.com/AnOldStory/Setting/master/resource/window/"
$shortcutList = "https://api.github.com/repos/AnOldStory/Setting/contents/resource/window/Links?ref=master"

$wantDDNS = $True # ddns-requester -5min
$wantWSL = $True # wsl-connect-external -atlogin
$wantWSLSSH = $True # wsl-ssh-starter -atlogin
$wantShortcut = $True # make shortcut at run

<###### Log ######>
#check directory 
If(!(test-path $program_path)) 
  { New-Item -ItemType Directory -Force -Path $program_path }

If(!(test-path "$($program_path)\Scheduler")) 
  { New-Item -ItemType Directory -Force -Path "$($program_path)\Scheduler" }

If(!(test-path "$($program_path)\Shortcut")) 
  { New-Item -ItemType Directory -Force -Path "$($program_path)\Shortcut" }

#start logging 
start-Transcript -path "$($program_path)\log.txt" -Force


<###### DDNS task schedule register ######>
function DDNS_ON() {
  #Check environment variable 
  if (!$Env:a_ddns){
    echo "Plz set Envitonment variable duckdns token with [a_ddns]"
    exit;
  }
  
  #download file from cdn
  wget "$($cdn)ddns-requester.ps1" -OutFile "$($program_path)\Scheduler\ddns-requester.ps1"

  #Create Scheduler for ddns 
  $taskName = "Dynamic DNS by $($program_name)"
  $taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName }

  #Check Not Exist Scheduler 
  if(!$taskExists) {
    #create schedule
    try { 
      $description = $taskName +" | "+"DDNS for this computer"+" | "+ (Get-Date) + " | github: @anoldstory"
      $taskPath = $program_name
      $taskTime = New-ScheduledTaskTrigger -Once -At (Get-Date) `
                                          -RepetitionDuration (New-TimeSpan -Days (365 * 20))  `
                                          -RepetitionInterval (New-TimeSpan -Minutes 5)
      $credentials = Get-Credential -Credential $env:USERNAME
      $password = $credentials.GetNetworkCredential().Password
      # $User = "thesky\Administrator"
      $PS = New-ScheduledTaskAction -Execute "PowerShell.exe" `
                                    -Argument "-noprofile -ExecutionPolicy bypass -File $($program_path)\Scheduler\ddns-requester.ps1"
      Register-ScheduledTask -TaskName $taskName `
                            -TaskPath $taskPath `
                            -Trigger $taskTime `
                            -User "$env:USERDOMAIN\$env:USERNAME" `
                            -Password $password `
                            -Action $PS `
                            -Description $description
                            # -User $User 
    } catch {
        echo "Error in DDNS register" `n`$_.ScriptStackTrace `n`echo $_.Exception `n`$_.ErrorDetails 
    }
  } else {
      echo "already DDNS registered"
  }
}

<###### wsl-connect-external ######>
function WSL_External_ON(){
    #download file from cdn
    wget "$($cdn)wsl-connect-external.ps1" -OutFile "$($program_path)\Scheduler\wsl-connect-external.ps1"

    #Create Scheduler for ddns 
    $taskName = "WSL 2 Firewall Unlock by $($program_name)"
    $taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName }

    #Check Not Exist Scheduler 
    if(!$taskExists) {
      #create schedule
      try { 
        $description = $taskName +" | "+"link computer port to inner wsl (22,80,443,8080)"+" | "+ (Get-Date) + " | github: @anoldstory"
        $taskPath = $program_name
        $taskTime = New-ScheduledTaskTrigger -AtStartup
        $credentials = Get-Credential -Credential $env:USERNAME
        $password = $credentials.GetNetworkCredential().Password
        # $User = "thesky\Administrator"
        $PS = New-ScheduledTaskAction -Execute "PowerShell.exe" `
                                      -Argument "-noprofile -ExecutionPolicy bypass -File $($program_path)\Scheduler\wsl-connect-external.ps1"
        Register-ScheduledTask -TaskName $taskName `
                              -TaskPath $taskPath `
                              -Trigger $taskTime `
                              -User "$($env:USERDOMAIN)\$($env:USERNAME)" `
                              -Password $password `
                              -Action $PS `
                              -Description $description

      } catch {
          echo "Error in WSL register" `n`
          echo $_.ScriptStackTrace `n`
          echo $_.Exception `n`
          echo $_.ErrorDetails 
      }
    } else {
        echo "already WSL registered"
    }
}

<###### wsl-ssh-starter ######>
function WSL_SSH_ON(){
    #download file from cdn
    wget "$($cdn)wsl-ssh-starter.ps1" -OutFile "$($program_path)\Scheduler\wsl-ssh-starter.ps1"

    #Create Scheduler for ddns 
    $taskName = "WSL ssh start by $($program_name)"
    $taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName }

    #Check Not Exist Scheduler 
    if(!$taskExists) {
      #create schedule
      try { 
        $description = $taskName +" | "+"run ssh in wsl "+" | "+ (Get-Date) + " | github: @anoldstory"
        $taskPath = $program_name
        $taskTime = New-ScheduledTaskTrigger -AtStartup
        $credentials = Get-Credential -Credential $env:USERNAME
        $password = $credentials.GetNetworkCredential().Password
        # $User = "thesky\Administrator"
        $PS = New-ScheduledTaskAction -Execute "PowerShell.exe" `
                                      -Argument "-noprofile -ExecutionPolicy bypass -File $($program_path)\Scheduler\wsl-ssh-starter.ps1"
        Register-ScheduledTask -TaskName $taskName `
                              -TaskPath $taskPath `
                              -Trigger $taskTime `
                              -User "$($env:USERDOMAIN)\$($env:USERNAME)" `
                              -Password $password `
                              -Action $PS `
                              -Description $description

      } catch {
          echo "Error in WSL-SSH register" `n`
          echo $_.ScriptStackTrace `n`
          echo $_.Exception `n`
          echo $_.ErrorDetails 
      }
    } else {
        echo "already WSL-SSH registered"
    }
}


<###### Run Shortcut ######>
function Shortcut_ON(){
  #download shortcut list
  $response = (Invoke-WebRequest -Uri $shortcutList).Content | ConvertFrom-Json
  foreach ($file in $response){
    wget $file.download_url -OutFile "$($program_path)\Shortcut\$($file.name)"
  }

  #backup
  $env:path > $program_path\backup_env.txt
  if (!($env:Path -like "*$($program_path)\Shortcut*"))
  {
    #if not PATH exist
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($program_path)\Shortcut", "User")
  }
}

<###### Script Run  ######>
if ($wantDDNS) { DDNS_ON }
if ($wantWSL) { WSL_External_ON }
if ($wantWSLSSH) { WSL_SSH_ON }
if ($wantShortcut) { Shortcut_ON }


# stop logging
Stop-Transcript
