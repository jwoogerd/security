Jayme Woogerd  
Comp 116 - Security  
Assignment 1: Packet Sniffing  

###Set 1
---

1. There are 1,503 packets in this set.

1. Protocol: FTP (on port 20)

1. FTP is insecure because credentials and all transferred files are sent to the server in plaintext. Therefore, anyone intercepting network packets can read the username and password and reconstruct the files.

1. A secure alternative to FTP for file transfer is SFTP, which uses SSH (Secure Shell) protocol to encrypt all communication. (Source: http://engineering.deccanhosts.com/2013/02/why-is-ftp-insecure.html)

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

1. There are 9 username/password pairs in this set.

1. First, I did some research to come up with a list of protocols that transfer data in the clear. I came up with HTTP, POP3, FTP, TELNET, SMTP, IMAP, NetBIOS, and SNMP. Then I set a Wireshark filter for each of these protocols and followed the resulting TCP stream(s), if applicable. The filters that bore results were POP3 and TELNET.

1.     

|     | Username | Password | Server IP | Domain | Port | Valid? |
| :-: | :------: | :------: | :--------:| :----: | :--: | :----: |
| 1.  | chris@digitalinterlude.com | Volrathw69 | 75.126.75.131 | http://mail.si-sv3231.com | 110 | Yes |
| 2.  | cisco | 185 august23 | 200.60.17.1 |  - | 23 | No |
| 3.  | cisco | 185 anthony7 | 200.60.17.1 | - | 23 | No |
| 4.  | cisco | 185 allahu | 200.60.17.1 |  - | 23 | No |
| 5.  | cisco | 185 alannah | 200.60.17.1 |  - | 23 | No |
| 6.  | cisco | 185 BASKETBALL | 200.60.17.1 |  - | 23 | No |
| 7.  | cisco | 185 12345d | 200.60.17.1 |  - | 23 | No |
| 8.  | cisco | 185 122333 | 200.60.17.1 |  - | 23 | No |
| 9.  | cisco | 184 yomama1 | 200.60.17.1 |  - | 23 | - |  

5. Of the username/password pairs, one is legitimate, seven are invalid, and one
may be valid (the stream gets cut off).

1. It's clear that the first pair is valid from the server response:

        USER chris@digitalinterlude.com
        +OK User:'chris@digitalinterlude.com' ok
        PASS Volrathw69
        +OK Password ok

    For pairs 2-8, the server responds with `% Login invalid`; these pairs are not
    legitimate. For number 9, it's ambiguous whether the login is valid or not as
    the stream is cut off before the server response.

1. I would say...
