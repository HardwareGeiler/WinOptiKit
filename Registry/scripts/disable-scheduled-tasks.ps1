function Is-Admin() {
    $current_principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $current_principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Toggle-Task($task, $enable) {
    $toggle = if ($enable) { "/enable" } else { "/disable" }

    $minsudoPath = Join-Path -Path $PSScriptRoot -ChildPath "MinSudo.exe"

    $user_task_result = (Start-Process "schtasks.exe" -ArgumentList "/change $($toggle) /tn `"$($task)`"" -PassThru -Wait -WindowStyle Hidden).ExitCode
    $trustedinstaller_task_result = [int](& $minsudoPath --NoLogo --TrustedInstaller --Privileged cmd /c "schtasks.exe /change $($toggle) /tn `"$($task)`" > nul 2>&1 && echo 0 || echo 1")

    return $user_task_result -band $trustedinstaller_task_result
}

function main() {
    if (-not (Is-Admin)) {
        Write-Host "error: administrator privileges required"
        return 1
    }

    Write-Host "info: please wait..."

    $wildcards = @(
        "update",
        "helloface",
        "customer experience improvement program",
        "microsoft compatibility appraiser",
        "startupapptask",
        "dssvccleanup",
        "bitlocker",
        "chkdsk",
        "data integrity scan",
        "defrag",
        "languagecomponentsinstaller",
        "upnp",
        "windows filtering platform",
        "tpm",
        "systemrestore",
        "speech",
        "spaceport",
        "power efficiency",
        "cloudexperiencehost",
        "diagnosis",
        "file history",
        "bgtaskregistrationmaintenancetask",
        "autochk\proxy",
        "siuf",
        "device information",
        "edp policy manager",
        "defender",
        "marebackup"
    )

    $task_names = @(schtasks /query /fo list | Where-Object { $_ -match "TaskName:" } | ForEach-Object { $_.Split(":")[1].Trim().ToLower() })

    foreach ($wildcard in $wildcards) {
        Write-Host "info: searching for $($wildcard)"
        foreach ($task in $task_names) {
            if ($task -like "*$wildcard*") {
                if ((Toggle-Task -task $task -enable $false) -ne 0) {
                    Write-Host "warning: failed toggling task: $task"
                }
            }
        }
    }

    return 0
}

exit (main)
