Jayme Woogerd  
Comp 116 - Security  
Assignment 1: Packet Sniffing  

###Set 1
---

1. There are 1,503 packets in this set.

1. Protocol: FTP (on port 20)

1. FTP is insecure because credentials and all transferred files are sent to the server in plaintext. Therefore, anyone intercepting network packets can read the username and password and reconstruct the files.

1. A secure alternative to FTP for file transfer is SFTP, which uses an underlying SSH tunnel to transfer the files.  With SSH, all communication is encrypted. (Source: http://engineering.deccanhosts.com/2013/02/why-is-ftp-insecure.html)

1. Username: ihackpinapples  
Password: rockyou1
1. Server IP: 67.23.79.113

1. Four files were transferred to the server.

1. File names:  
BjN-O1hCAAAZbiq.jpg  
BvgT9p2IQAEEoHu.jpg  
BvzjaN-IQAA3XG7.jpg  
smash.txt


###Set 2
---

1. There are 77,873 packets in this set.

1.      
            username: chris@digitalinterlude.com
            password: Volrathw69
            server IP: 75.126.75.131
            domain: http://mail.si-sv3231.com
            port: 110
            valid

            username: cisco
            password: 185 12345d
            server IP: 200.60.17.1
            domain:
            port: 23
            invalid

            username: cisco
            password: 185 122333
            server IP: 200.60.17.1
            domain:
            port: 23
            invalid