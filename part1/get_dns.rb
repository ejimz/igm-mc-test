#!/usr/bin/env ruby

require 'getopt/std'
require 'logger'

# Class to launch geoiplookup in parallel iterating on domain list
class GetDns
  def initialize(domains = [], filename = nil)
    @domains = domains
    unless filename.nil?
      @logger = Logger.new(filename)
      @log_enabled = true
    end
    start()
  end

  def start()
    printf "%-20s %s\n", 'Domain', 'Info'
    threads = []
    @domains.each do |dmn|
      threads << Thread.new do
        run_geoiplookup(dmn)
      end
    end
    threads.each { |t| t.join }
  end

  def run_geoiplookup(dmn)
    output = `geoiplookup #{dmn}`
    printf "%-20s %s", dmn, output
    if @log_enabled
      @logger.info('##########################################################')
      @logger.info("Domain: #{dmn}")
      @logger.info("Info: #{output}")
    end
  end
end

def usage
  printf "Usage: get_dns.rb -d domain1,domain2 [-f filename]\n"
  printf "Options:\n"
  printf "\t -h show this help.\n"
  printf "\t -d comma separated list domain \n"
  printf "\t -f [OPTIONAL] store output in a logfile \n"
  printf "\n"
  printf "\n"
  printf "Example: get_dns.rb -d domain1.com,domain2.com -f /tmp/dns_output \n"
  printf "\n"
  exit 1
end

begin
  opt = Getopt::Std.getopts('hd:f:')
rescue => e
  printf "\t\n#{e.message}\n\n"
  usage
end

if opt['h'] || opt.empty?
  usage
end

domains = opt['d'].split(',') unless opt['d'].empty?
filename = opt['f'] unless opt['f'].nil?

# Run get_dns class to get domains info
GetDns.new(domains, filename)
