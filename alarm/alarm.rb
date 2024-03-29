#!/usr/local/bin/ruby

# Jayme Woogerd
# Comp 116 - Security
# Assignment 2: Incident Alarm
# October 8, 2014
# to run: sudo ruby alarm.rb || sudo ruby alarm.rb -r <web_server_log>

require 'packetfu'
require 'base64'

def live_sniff(iface)
    # capture a live stream of network packets (and print the result, for now)
    cap = PacketFu::Capture.new(:start => true, :iface => iface, :promisc => true)
    cap.stream.each do |p|
        pkt = PacketFu::Packet.parse p
        if pkt.is_tcp?
            flags = pkt.tcp_flags
            proto = pkt.proto[-1]
            payload = pkt.payload
    	    if flags.urg == 0 && flags.ack == 0 && flags.psh == 0 &&
    	       flags.rst == 0 && flags.syn == 0 && flags.fin == 0 && pkt.tcp_dport == 80 
                print_incident("NULL scan is detected", pkt.ip_saddr, proto, payload)
    	    end
    	    if flags.urg == 1 && flags.psh == 1 && flags.fin == 1 && pkt.tcp_dport == 80
                print_incident("XMAS scan is detected", pkt.ip_saddr, proto, payload)
    	    end
            if pkt.payload[/4\d{3}(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}/] ||
                pkt.payload[/5\d{3}(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}/] ||
                pkt.payload[/6011(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}/] ||
                pkt.payload[/3\d{3}(\s|-)?\d{6}(\s|-)?\d{5}/]
                print_incident("Credit card leaked in the clear", pkt.ip_saddr, proto, payload)
            end
        end
    end
end


def log_sniff(filename)
    File.open(filename, "r") do |f|
        f.each_line do |line|
            check_line(line)
        end
    end
end

def check_line(line)
    # regex between quotes from this so: http://stackoverflow.com/questions/171480/
    incident = {
        :source   => line[/[^ ]*/], # matches up to first whitespace
        :payload  => line[/(["'])(?:(?=(\\?))\2.)*?\1/], # matches between quotes 
        :status   => line[/ [1-5][0-9][0-9] /],
        :nmap     => line[/Nmap/]
    }
    incident[:protocol] = incident[:payload].lines(" ")[-1][/[A-Z]*/]

    if incident[:status][/4[0-9][0-9]/]
        print_incident("HTTP error is detected", incident[:source], incident[:protocol],
            incident[:payload])
    end
    if incident[:nmap]
        print_incident("Nmap scan is detected", incident[:source], incident[:protocol],
            incident[:payload])
    end
    if incident[:payload][/\\x[0-9, A-F][0-9, A-F]/] && incident[:payload][/^((?!HTTP).)*$/]
        # TODO: protocol for shellcode?
        print_incident("Shellcode is detected", incident[:source], "TCP",
            Base64.encode64(incident[:payload]))
    end
end

$incident_number = 0
def print_incident(attack, source, protocol, payload)
    print "#{$incident_number}. ALERT: #{attack} " +
          "from #{source} (#{protocol}) (#{payload})!\n"
    $incident_number += 1
end

def main()
    option = ARGV[0]
    filename = ARGV[1]
    if option == nil
        iface = PacketFu::Config.new().config[:iface]
        live_sniff(iface = iface)
    end
    if option == '-r'
        if filename == nil
            puts "Usage: sudo ruby alarm.rb || sudo ruby alarm.rb -r <web_server_log>"
            return
        end
        log_sniff(filename)
    else 
        puts "Usage: sudo ruby alarm.rb || sudo ruby alarm.rb -r <web_server_log>"
    end
end

main()
