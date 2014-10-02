#!/usr/local/bin/ruby

# Jayme Woogerd
# Comp 116 - Security
# Assignment 2: Incident Alarm
# October 7, 2014
# to run: sudo ruby alarm.rb || sudo ruby alarm.rb -r <web_server_log>

require 'packetfu'

stream = PacketFu::Capture.new(:start => true, :iface => 'en0', :promisc => true)
sleep 10
stream.save
first_packet = stream.array[0]
print "#{first_packet}"
# stream.show_live()