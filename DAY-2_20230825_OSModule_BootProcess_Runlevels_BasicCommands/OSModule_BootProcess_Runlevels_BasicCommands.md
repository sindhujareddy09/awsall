#### Session Video:
    https://drive.google.com/file/d/1BuERx-oEkszicizgl0t14GDpJgZQqZbs/view?usp=sharing

| Task |	Linux Command | Windows Command | 
| ---|---|--|
| List files and directories |	ls	 |dir |
| Change directory |	cd |	cd |
| Create a directory |	mkdir |	mkdir |
| Remove a directory |	rmdir |	rmdir |
| Copy files and directories |	cp	 |copy |
| Move files and directories |	mv |	move |
| Delete files |	rm	 | del |
| Display file content |	cat or less	 | type |
| Find text in files |	grep | findstr |
| Change file permissions |	chmod | attrib |
| View network configuration |	ifconfig or ip addr	 | ipconfig or getmac |
| Ping a network host |	ping | ping |
| Check disk usage | df -h | dir |
| Mount a disk image | mount | diskpart |
| Format a disk	 | mkfs | format |
| Compress a file	 | gzip or tar	 | gzip or zip |
| Uncompress a file	 | gunzip or tar	 | gunzip or unzip |


#### Commands 

```
Here are examples of some common Linux commands:

1. cat (concatenate):
Display the contents of a file:

    $ cat file.txt

2. head:
Display the first few lines of a file (by default, the first 10 lines):

    $ head file.txt

3. tail:
Display the last few lines of a file (by default, the last 10 lines):

    $ tail file.txt

4. more:
Display the contents of a file one screen at a time (press the spacebar to scroll down, press 'q' to exit):

    $ more file.txt

5. less:
Display the contents of a file with backward and forward navigation (use the arrow keys to scroll, press 'q' to exit):

    $ less file.txt

6. touch:
Create an empty file:

    $ touch file.txt

7. mkdir (make directory):
Create a new directory:

    $ mkdir directory_name

8. cp (copy):
Copy a file from one location to another:

    $ cp source_file.txt destination_folder/

9. cd (change directory):
Change the current working directory:

$ cd /path/to/directory

10. pwd (print working directory):
Display the current working directory:

    $ pwd

11. ls (list):
List the files and directories in the current directory:

    $ ls

12. List all files and directories (including hidden ones):

    $ ls -a

13. List files with detailed information (permissions, size, owner, etc.):

    $ ls -l

These are just a few examples of commonly used Linux commands. 
Each command also has additional options and functionalities, which can be explored through their respective man pages (man command_name).
```

| Windows PowerShell              | Linux (Bash)                  |
|---------------------------------|-------------------------------|
| Get-Process                     | ps                            |
| Get-Service                     | systemctl status              |
| Set-Location / cd               | cd                            |
| Get-ChildItem / ls              | ls                            |
| Copy-Item / cp                  | cp                            |
| Move-Item / mv                  | mv                            |
| Remove-Item / rm                | rm                            |
| New-Item / touch                | touch                         |
| Rename-Item / ren               | mv                            |
| Clear-Host                      | clear                         |
| Get-Content / gc                | cat                           |
| Set-Content / sc                | echo                          |
| Out-File                        | >                             |
| Out-String                      | cat                           |
| Test-Path                       | -e                            |
| New-ItemProperty                | touch or echo into a file     |
| Remove-ItemProperty             | sed                           |
| Get-ItemProperty                | grep                          |
| Invoke-Item                     | xdg-open                      |
| New-Object                      | -                             |
| Start-Process                   | xdg-open                      |
| Measure-Object                  | wc                            |
| Compare-Object                  | diff                          |
| Where-Object                    | grep                          |
| ForEach-Object                  | -                             |
| Get-Help                        | man                           |
| Get-Command                     | which                         |
| Clear-Content                   | > (redirect) or truncate      |
| New-Service                     | systemctl or service          |
| Stop-Service                    | systemctl stop or service     |
| Start-Service                   | systemctl start or service    |
| Restart-Service                 | systemctl restart or service  |
| Set-Service                     | systemctl enable or disable  |


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
