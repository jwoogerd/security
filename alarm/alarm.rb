#!/usr/local/bin/ruby

# Jayme Woogerd
# Comp 116 - Security
# Assignment 2: Incident Alarm
# October 7, 2014
# to run: sudo ruby alarm.rb || sudo ruby alarm.rb -r <web_server_log>

require 'packetfu'
require 'optparse'

def live_sniff(iface)
    # capture a live stream of network packets (and print the result, for now)
    iface ||= 'eth0'
    cap = PacketFu::Capture.new(:start => true, :iface => iface, :promisc => true)
    cap.stream.each do |p|
        pkt = PacketFu::Packet.parse p
        if pkt.is_ip?
            packet_info = [pkt.ip_saddr, pkt.ip_daddr, pkt.size, pkt.proto.last]
            print "#{packet_info}"
        end
    end
end


def log_sniff()
    print "log sniff"
end

def main()
    options = {:log => false}

    OptionParser.new do |opts|
        opts.banner = "Usage: alarm.rb [options]"
        opts.on("-r", "--file filename") do |filename| 
            options[:log] = true
            options[:filename] = filename
        end
    end.parse!

    if options[:log]
        log_sniff() 
    else 
        live_sniff('en0')
    end
end

main()