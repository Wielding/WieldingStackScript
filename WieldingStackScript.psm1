function Get-MachineInfo {
    Write-Host "Linode ID: $env:LINODE_ID"
    Write-Host "Lish User: $env:LINODE_LISHUSERNAME"
    Write-Host "Linode RAM: $env:LINODE_RAM"
    Write-Host "Linode Data Center: $env:LINODE_DATACENTERID"
}

function Install-Go {
    if (-not (Test-Path "./downloads/go1.15.7.linux-amd64.tar.gz" -PathType Leaf)) {
        Write-Host "Downloading Go"
        . wget -P downloads https://golang.org/dl/go1.15.7.linux-amd64.tar.gz
    }

    sudo tar -C /usr/local -xzf downloads/go1.15.7.linux-amd64.tar.gz
    sudo sh -c 'echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile'
    $env:PATH += ":/usr/local/go/bin"
}

function Install-Nginx {    
    sudo add-apt-repository ppa:certbot/certbot -y
    sudo apt-get update
    sudo apt-get install nginx certbot python3-certbot-nginx -y    
    sudo service nginx start
}

function Test-Package {
    param (
        [string]$Package
    )

    dpkg -l $Package 2>&1 | out-null

    return $LASTEXITCODE -eq 0
}

Export-ModuleMember -Function Out-Default, 'Get-MachineInfo'
Export-ModuleMember -Function Out-Default, 'Install-Go'
Export-ModuleMember -Function Out-Default, 'Install-Nginx'
Export-ModuleMember -Function Out-Default, 'Test-Package'