add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@

$loop = $true
while ($loop -eq $true) {
    Write-Output -InputObject ''
    Write-Output -InputObject "What do you want to do?"
    Write-Output -InputObject "[1] rif to rap"
    Write-Output -InputObject "[2] PS3 Game patch lookup"
    Write-Output -InputObject "[q] Quit"
    Write-Output -InputObject ''
    $response = Read-Host -Prompt ('Number ')
    if ($response -eq "1") {
        if (-not (Test-Path -Path "data/")) {
            New-Item -ItemType "Directory" -Path "data" -ErrorAction "SilentlyContinue" | Out-Null
        }
        if (-not (Test-Path -Path "data/act.dat")) {
            Write-Output ''
            Read-Host -Prompt ((Get-Location).path + 'data\act.dat does not exist, press enter when the file is in place') | Out-Null
        }
        if (-not (Test-Path -Path "data/idps")) {
            Write-Output ''
            Read-Host -Prompt ((Get-Location).path + 'data\idps does not exist, press enter when the file is in place') | Out-Null
        }
        if (-not (Test-Path -Path "rif2rap.exe")) {
            Invoke-RestMethod -Uri "https://cdn.ljskatt.no/playstation-tools/rif2rap.exe" -OutFile "rif2rap.exe"
        }

        $files = Get-ChildItem "*.rif"
        if ($files.count -eq "0") {
            Write-Output -InputObject ''
            Write-Output -InputObject ('No .rif files found in path: ' + (Get-Location).Path)
        }
        else {
            foreach ($file in $files.Name) {
                .\rif2rap.exe "$file"
            }
            Write-Output ('Processed ' + $files.count + ' files')
            $loop = $false
        }
    }
    elseif ($response -eq "2") {
        Write-Output -InputObject ''
        $response = Read-Host -Prompt ('What game do you want to look up? (Example: NPEA00457) ')
        if ($response -match '[A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9]') {
            $patch = $null
            [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
            $patch = (Invoke-RestMethod -ErrorAction "SilentlyContinue" -Uri "https://a0.ww.np.dl.playstation.net/tpl/np/$response/$response-ver.xml").titlepatch.tag.package | Select-Object -Last 1
            if ($patch) {
                Write-Output ('Newest patch: ' + $patch.version)
                Write-Output ('Url: ' + $patch.url)
                $loop = $false
            }
            else {
                Write-Output -InputObject "Could not find patch, either game does not exist or no patches has been made..."
            }
        }
        elseif ($response -eq 'q') {
            $loop = $false
        }
    }
    elseif ($response -eq "q") {
        $loop = $false
    }
}
Write-Output -InputObject ''
Pause