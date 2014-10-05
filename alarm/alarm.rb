#!/usr/local/bin/ruby

# Jayme Woogerd
# Comp 116 - Security
# Assignment 2: Incident Alarm
# October 7, 2014
# to run: sudo ruby alarm.rb || sudo ruby alarm.rb -r <web_server_log>

require 'packetfu'
require 'optparse'

def live_sniff(iface = 'eth0')
    # capture a live stream of network packets (and print the result, for now)
    cap = PacketFu::Capture.new(:start => true, :iface => iface, :promisc => true)
    cap.stream.each do |p|
        pkt = PacketFu::Packet.parse p
        if pkt.is_ip?
            packet_info = [pkt.ip_saddr, pkt.ip_daddr, pkt.size, pkt.proto.last]
            print "#{packet_info}"
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
        print_incident("HTTP error", incident[:source], incident[:protocol],
            incident[:payload])
    end
    if incident[:nmap]
        print_incident("Nmap scan", incident[:source], incident[:protocol],
            incident[:payload])
    end
    if incident[:payload][/\\x[0-9,A-F][0-9, A-F]/] 
        # TODO filter out none shell code
        puts incident[:payload]
    end
end

$incident_number = 0
def print_incident(attack, source, protocol, payload)
    print "#{$incident_number}. ALERT: #{attack} is detected from " +
          "#{source} (#{protocol}) (#{payload})!\n"
    $incident_number += 1
end

def main()
    options = {:log => false, :filename => nil}

    OptionParser.new do |opts|
        opts.banner = "Usage: alarm.rb [options]"
        opts.on("-r", "--file filename") do |filename| 
            options[:log] = true
            options[:filename] = filename
        end
    end.parse!

    if options[:log]
        log_sniff(options[:filename]) 
    else 
        live_sniff()
    end
end

main()
