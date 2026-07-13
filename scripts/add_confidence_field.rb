#!/usr/bin/env ruby
# Script to add confidence field to all plush files that don't have it

require 'fileutils'

PLUSH_DIR = File.join(__dir__, '..', '_plushes')

Dir.glob(File.join(PLUSH_DIR, '*.md')).each do |file|
  content = File.read(file)
  
  # Skip if already has confidence field
  if content =~ /^confidence:/
    puts "SKIP (has confidence): #{File.basename(file)}"
    next
  end
  
  # Find a good place to insert confidence field
  # Insert after status field if it exists, otherwise after verification
  if content =~ /^(status:.*?)(\n)/m
    # Insert after status line
    new_content = content.sub(/^(status:.*?)(\n)/m, "\\1\\2confidence:\n")
    File.write(file, new_content)
    puts "ADDED confidence after status: #{File.basename(file)}"
  elsif content =~ /^(verification:.*?)(\n)/m
    # Insert after verification line
    new_content = content.sub(/^(verification:.*?)(\n)/m, "\\1\\2confidence:\n")
    File.write(file, new_content)
    puts "ADDED confidence after verification: #{File.basename(file)}"
  else
    puts "WARN: No status or verification field found: #{File.basename(file)}"
  end
end

puts "\nDone!"