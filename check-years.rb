#!/usr/bin/env ruby

require 'mysql2'
require 'csv'

$client = Mysql2::Client.new(
  host: 'localhost', 
  username: ENV['DB_USER'], 
  password: ENV['DB_PASS'], 
  database: ENV['DATABASE']
)

# get year in CA database for an ID
def ca_year(id) 
  results = $client.query("select work_year from ca_objects where object_id = #{id}")
  results.first['work_year']
end

def blank?(s)
  s.nil? || s.to_s.strip.empty?
end

CSV.foreach(File.expand_path('~/works.csv')) do |row|
  work_id = row[0]
  title = row[1]
  year = row[3]
  puts "#{work_id}\t#{title}\t#{year}"
  puts ca_year(work_id)
end

