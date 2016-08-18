#!/usr/bin/env ruby

require 'getopt/std'
require 'logger'

class Get_dns
  def initialize(domains=[],filename=nil)
    @domains = domains
    if !filename.nil?
      @logger = Logger.new(filename)
      @log_enabled = true
    end 
    start()
  end

  def start()
    printf "%-20s %s\n", "Domain", "Info"
    threads = []
    @domains.each do |dmn|
      threads << Thread.new do
        h_dns = run_geoiplookup(dmn)
      end
    end  
    threads.each { |t| t.join }
  end

  def run_geoiplookup(dmn)
    output = `geoiplookup #{dmn}`
    printf "%-20s %s", dmn, output
    if @log_enabled
      @logger.info("################################################################")
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
  opt = Getopt::Std.getopts("hd:f:")
rescue => e 
  printf "\t\n#{e.message}\n\n"
  usage
end

if opt['h'] or opt.empty? 
  usage
end

if !opt['d'].empty?
  domains = []
  domains = opt['d'].split(',')
end
filename = opt['f'] if !opt['f'].nil?

#Run get_dns class to get domains info using parallel threads
gdns = Get_dns.new(domains, filename)
