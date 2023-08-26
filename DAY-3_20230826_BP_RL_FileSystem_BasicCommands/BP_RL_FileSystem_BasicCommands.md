#### Session Video:
    https://drive.google.com/file/d/1iUI2APH4MRKpp_ZbdPNQ7VcGEY-IWRUw/view?usp=sharing    


#### 


| Windows PowerShell Command     | Example                       | Linux (Bash) Equivalent     | Example                       |
|---------------------------------|-------------------------------|-----------------------------|-------------------------------|
| Get-Process                     | Get-Process                   | ps                          | ps                            |
| Get-Service                     | Get-Service                   | systemctl status            | systemctl status sshd         |
| Set-Location / cd               | Set-Location C:\              | cd                          | cd /path/to/directory          |
| Get-ChildItem / ls              | Get-ChildItem C:\             | ls                          | ls /path/to/directory          |
| Copy-Item / cp                  | Copy-Item file.txt newfile.txt | cp                          | cp file.txt newfile.txt        |
| Move-Item / mv                  | Move-Item file.txt dir/       | mv                          | mv file.txt dir/               |
| Remove-Item / rm                | Remove-Item file.txt          | rm                          | rm file.txt                    |
| New-Item / touch                | New-Item newfile.txt          | touch                       | touch newfile.txt              |
| Rename-Item / ren               | Rename-Item file.txt newname.txt | mv                        | mv file.txt newname.txt        |
| Clear-Host                      | Clear-Host                    | clear                       | clear                         |
| Get-Content / gc                | Get-Content file.txt          | cat                         | cat file.txt                  |
| Set-Content / sc                | Set-Content file.txt "Hello"   | echo                        | echo "Hello" > file.txt        |
| Out-File                        | Get-Process | Out-File procs.txt | >                         | ps > procs.txt                |
| Test-Path                       | Test-Path file.txt            | -e                          | test -e file.txt              |
| Get-ItemProperty                | Get-ItemProperty file.txt     | grep                        | grep "pattern" file.txt       |
| Invoke-Item                     | Invoke-Item file.txt          | xdg-open                    | xdg-open file.txt             |
| Start-Process                   | Start-Process notepad         | xdg-open                    | xdg-open file.txt             |
| Compare-Object                  | Compare-Object file1.txt file2.txt | diff                    | diff file1.txt file2.txt      |
| Where-Object                    | Get-Process | Where-Object { $_.Name -like "chrome" } | grep                | ps aux | grep "chrome"          |
| Get-Help                        | Get-Help Get-Process          | man                         | man ls                        |
| Get-Command                     | Get-Command                   | which                       | which ls                      |
| Clear-Content                   | Clear-Content file.txt        | > (redirect) or truncate    | > file.txt                    |
| New-Service                     | New-Service -Name "MyService" -BinaryPathName "C:\path\service.exe" | systemctl or service | systemctl start/stop/restart myservice |
