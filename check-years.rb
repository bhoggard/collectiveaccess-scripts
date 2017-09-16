#!/usr/bin/env ruby

require 'collectiveaccess'
require 'csv'

ADMIN_HOST = ENV['CA_ADMIN_HOST']

def check_year(work_id, year)
  r = CollectiveAccess.get hostname: ADMIN_HOST, 
                           table_name: 'ca_objects', 
                           path: "idno/#{work_id}"
  puts r
  exit
end

def blank?(s)
  s.nil? || s.to_s.strip.empty?
end

CSV.foreach(File.expand_path('~/Desktop/works.csv')) do |row|
  work_id = row[0]
  title = row[1]
  year = row[3]
  puts "#{work_id}\t#{title}\t#{year}"
  check_year(work_id, year) if blank?(year)
end
