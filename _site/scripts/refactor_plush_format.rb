#!/usr/bin/env ruby
# Refactors all plush files to canonical format with section comments
# Usage: ruby scripts/refactor_plush_format.rb

require 'yaml'
require 'fileutils'

PLUSH_DIR = File.join(__dir__, '..', '_plushes')

def get_value(data, *keys)
  keys.each do |key|
    return data[key] if data.key?(key) && data[key] != nil && data[key] != ''
  end
  nil
end

def format_sources(sources)
  return "sources: []" if sources.nil? || sources.empty?
  
  lines = ["sources:"]
  sources.each do |source|
    lines << "  - type: #{source['type'] || ''}"
    lines << "    tier: #{source['tier'] || source['reliability'] || ''}"
    lines << "    url: #{source['url'] || ''}"
    lines << "    accessed: #{source['accessed'] || ''}"
    lines << "    notes: #{source['notes'] || source['description'] || ''}"
  end
  lines.join("\n")
end

def format_array(arr)
  return "[]" if arr.nil? || arr.empty?
  arr.inspect
end

def format_dimensions(dims)
  if dims.nil? || dims.empty?
    return <<~YAML.chomp
dimensions:
  height: 
  width: 
  depth: 
    YAML
  end
  
  <<~YAML.chomp
dimensions:
  height: #{dims['height'] || ''}
  width: #{dims['width'] || ''}
  depth: #{dims['depth'] || ''}
  YAML
end

def format_price(price, price_display)
  if price.nil? || price.empty?
    return <<~YAML.chomp
price:
  amount: 
  currency: 
price_display: #{price_display || ''}
    YAML
  end
  
  <<~YAML.chomp
price:
  amount: #{price['amount'] || ''}
  currency: #{price['currency'] || ''}
price_display: #{price_display || ''}
  YAML
end

def refactor_file(filepath)
  content = File.read(filepath)
  
  # Extract frontmatter and body
  if content =~ /\A---\s*\n(.*?)\n---\s*\n?(.*)/m
    frontmatter = $1
    body = $2.strip
  else
    puts "  SKIP: No frontmatter found"
    return false
  end
  
  begin
    data = YAML.safe_load(frontmatter, permitted_classes: [Date, Time]) || {}
  rescue => e
    puts "  ERROR: #{e.message}"
    return false
  end
  
  # Build canonical format
  output = <<~YAML
---
# === IDENTITY ===
archive_id: #{data['archive_id'] || ''}
company_id: #{data['company_id'] || ''}
company: #{data['company'] || ''}

# === NAMES ===
current_name: #{data['current_name'] || ''}
official_name: #{data['official_name'] || ''}
japanese_name: #{data['japanese_name'] || ''}
romaji_name: #{data['romaji_name'] || ''}

# === CLASSIFICATION ===
product_line: #{data['product_line'] || ''}
product_line_id: #{data['product_line_id'] || ''}
manufacturer: #{data['manufacturer'] || ''}

# === RELEASE INFO ===
year: #{data['year'] || ''}
release_date: #{data['release_date'] || ''}
region: #{data['region'] || ''}

# === PHYSICAL ATTRIBUTES ===
size: #{data['size'] || ''}
#{format_dimensions(data['dimensions'])}
materials: #{format_array(data['materials'])}

# === PRICING ===
#{format_price(data['price'], data['price_display'])}

# === TAXONOMY ===
tags: #{format_array(data['tags'])}
search_terms: #{format_array(data['search_terms'])}

# === VARIANTS & RELATIONSHIPS ===
sculpt_id: #{data['sculpt_id'] || ''}
variant_of: #{data['variant_of'] || ''}
variant_type: #{data['variant_type'] || ''}

# === STATUS & VERIFICATION ===
status: #{data['status'] || 'Master'}
verification: #{data['verification'] || ''}
availability: #{data['availability'] || ''}

# === PROVENANCE ===
#{format_sources(data['sources'] || data['links'])}

# === DOCUMENTATION ===
notes: #{data['notes'] || ''}
last_updated: #{data['last_updated'] || Date.today.to_s}
---
  YAML
  
  # Add body content if present
  output += "\n#{body}" unless body.empty?
  output += "\n"
  
  File.write(filepath, output)
  true
end

# Process all files
files = Dir.glob(File.join(PLUSH_DIR, '*.md')).sort
puts "Refactoring #{files.length} plush files to canonical format..."
puts

success = 0
failed = 0

files.each do |filepath|
  filename = File.basename(filepath)
  print "Processing #{filename}... "
  
  if refactor_file(filepath)
    puts "✓"
    success += 1
  else
    failed += 1
  end
end

puts
puts "Done! #{success} files refactored, #{failed} failed."