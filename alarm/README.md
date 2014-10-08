### Assignment 2: Incident Alarm with Ruby and PacketFu
___

1. I think that the heuristics for detecting Xmas and Null scans are pretty good: by inspecting each packet and its flags, you are definitely going to catch when these types of scans happens. On the other hand, the heuristics for detecting credit card leaks are pretty bad: by just using the Sans regex to flag leaks I see many false positives since many sequences of numbers will match but not necessarily be credit card numbers.

2. If I had time in the future, I would definitely tighten up the credit card leak detection. I would do a secondary analysis on the number to verify that it is indeed a credit card (someone in class mentioned a method to do this). I would also expand the live packet sniffing to alert for other types of "sneaky" scans.

---

I am fairly confident that I have implemented all aspects of the web log analysis correctly. If I had more time, I would do more rigorous testing on filtering out malformed shell code. For the live packet sniffing, the Nmap scans are implemented correctly but I had a hard time testing, especially for credit card leaks. My credit card leak detection gives many false positives.
  
**Note**: For the live packet scanning, I report an Nmap scan just once (i.e. when port 80 is scanned), not for each packet sent for the scan.

I talked very briefly with Inbar and Andrea about this assignment. I have spent about 8-10 hours working - mostly learning Ruby, familiarizing myself with the PacketFu library, and grappling with regex.
