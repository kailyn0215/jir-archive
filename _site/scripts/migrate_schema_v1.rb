#!/usr/bin/env ruby
# Schema Migration Script: v0.3 → v1.0
# Migrates all plush entries to the new schema format
# 
# Usage: ruby scripts/migrate_schema_v1.rb [--dry-run]
#
# This script:
# 1. Adds new optional fields (tags, confidence, dimensions, etc.)
# 2. Migrates 'links' to 'sources' with tier field
# 3. Parses price strings to structured format
# 4. Preserves all existing data

require 'yaml'
require 'fileutils'

PLUSHES_DIR = File.expand_path("../_plushes", __dir__)
DRY_RUN = ARGV.include?('--dry-run')

# Parse price string like "857 yen" or "¥1,320" into structured format
def parse_price(price_str)
  return nil if price_str.nil? || price_str.to_s.strip.empty?
  
  price_str = price_str.to_s.strip
  
  # Handle "Prize" or other non-numeric values
  return { 'display' => price_str } unless price_str =~ /\d/
  
  # Extract numeric value
  amount = price_str.gsub(/[^\d.]/, '').to_f
  amount = amount.to_i if amount == amount.to_i
  
  # Detect currency
  currency = case price_str.downcase
  when /yen|¥|jpy/i then 'JPY'
  when /\$|usd/i then 'USD'
  else 'JPY' # Default for this archive
  end
  
  {
    'amount' => amount,
    'currency' => currency
  }
end

# Migrate links array to sources array with tier
def migrate_links_to_sources(links)
  return [] if links.nil? || links.empty?
  
  links.map do |link|
    source = {
      'type' => link['type'] || 'listing',
      'tier' => guess_tier(link['url']),
      'url' => link['url']
    }
    source['notes'] = link['notes'] if link['notes'] && !link['notes'].to_s.strip.empty?
    source
  end
end

# Guess source tier based on URL
def guess_tier(url)
  return 'C' if url.nil?
  
  case url.downcase
  when /pokemoncenter-online|pokemon\.co\.jp|pokemon\.com/
    'S'
  when /myfigurecollection|mandarake|suruga-ya/
    'A'
  when /yahoo|mercari|rakuten|ebay/
    'B'
  else
    'C'
  end
end

# Infer tags from existing data
def infer_tags(data)
  tags = []
  
  # Infer size tags
  size = data['size'].to_s.downcase
  if size =~ /life.?size|等身大/
    tags << 'size:life-size'
  elsif size =~ /(\d+)/
    num = $1.to_i
    if size.include?('cm')
      tags << 'size:mini' if num < 10
      tags << 'size:small' if num >= 10 && num < 20
      tags << 'size:medium' if num >= 20 && num < 35
      tags << 'size:large' if num >= 35 && num < 60
      tags << 'size:jumbo' if num >= 60
    elsif size.include?('"') || size.include?('inch')
      tags << 'size:mini' if num < 4
      tags << 'size:small' if num >= 4 && num < 8
      tags << 'size:medium' if num >= 8 && num < 14
      tags << 'size:large' if num >= 14 && num < 24
      tags << 'size:jumbo' if num >= 24
    end
  end
  
  # Infer type tags from product line
  line = data['product_line'].to_s.downcase
  line_id = data['product_line_id'].to_s.downcase
  
  tags << 'type:pokedoll' if line.include?('doll') || line_id.include?('doll')
  tags << 'type:prize' if line.include?('prize') || line.include?('ufo') || line_id.include?('prize')
  tags << 'type:lottery' if line.include?('kuji') || line.include?('lottery') || line_id.include?('kuji')
  tags << 'type:keychain' if line.include?('keychain') || line.include?('mascot') || line_id.include?('keychain')
  
  # Infer event tags
  tags << 'event:movie' if line.include?('movie') || line_id.include?('movie')
  tags << 'event:anniversary' if line.include?('anniversary') || line_id.include?('anniversary')
  
  # Infer special tags from notes or name
  name = data['current_name'].to_s.downcase
  notes = data['notes'].to_s.downcase
  
  tags << 'special:sitting' if name.include?('sitting') || name.include?('fit') || line.include?('fit')
  tags << 'special:sleeping' if name.include?('sleeping') || name.include?('kuttari')
  tags << 'special:ditto' if name.include?('ditto') || name.include?('metamon') || line.include?('ditto')
  
  tags.uniq
end

def migrate_file(path)
  content = File.read(path)
  
  # Parse frontmatter
  if content =~ /\A---\n(.*?)\n---/m
    yaml_content = $1
    body = $'
  else
    puts "  SKIP: No frontmatter found"
    return false
  end
  
  begin
    data = YAML.safe_load(yaml_content, permitted_classes: [Date, Time])
  rescue => e
    puts "  ERROR: Failed to parse YAML: #{e.message}"
    return false
  end
  
  # Track changes
  changes = []
  
  # 1. Add tags field if missing
  unless data.key?('tags')
    inferred = infer_tags(data)
    data['tags'] = inferred
    changes << "Added tags: #{inferred.join(', ')}" unless inferred.empty?
    changes << "Added empty tags array" if inferred.empty?
  end
  
  # 2. Migrate links to sources
  if data.key?('links') && !data['links'].nil? && !data['links'].empty?
    unless data.key?('sources')
      data['sources'] = migrate_links_to_sources(data['links'])
      changes << "Migrated #{data['links'].size} links to sources"
    end
  end
  
  # 3. Parse price to structured format
  if data.key?('price') && data['price'].is_a?(String)
    parsed = parse_price(data['price'])
    if parsed && parsed['amount']
      data['price_display'] = data['price']
      data['price'] = parsed
      changes << "Structured price: #{parsed}"
    elsif parsed && parsed['display']
      data['price_display'] = parsed['display']
      data['price'] = nil
      changes << "Moved non-numeric price to price_display"
    end
  end
  
  # 4. Add confidence field for Research entries
  if data['status'] == 'Research' && !data.key?('confidence')
    # Derive from existing verification field
    if data['verification'] == 'Strong'
      data['confidence'] = 'Strong'
    else
      data['confidence'] = 'Possible'
    end
    changes << "Added confidence: #{data['confidence']}"
  end
  
  # 5. Add empty optional fields for consistency
  new_fields = {
    'japanese_name' => nil,
    'romaji_name' => nil,
    'manufacturer' => nil,
    'release_date' => nil,
    'dimensions' => nil,
    'materials' => [],
    'sculpt_id' => nil,
    'variant_of' => nil,
    'variant_type' => nil,
    'availability' => nil
  }
  
  new_fields.each do |field, default|
    unless data.key?(field)
      data[field] = default
      # Don't report adding nil/empty fields as changes
    end
  end
  
  if changes.empty?
    puts "  No changes needed"
    return false
  end
  
  # Rebuild file with ordered fields
  ordered_data = reorder_fields(data)
  
  new_content = "---\n#{ordered_data.to_yaml.sub(/\A---\n/, '')}---#{body}"
  
  if DRY_RUN
    puts "  [DRY RUN] Would apply:"
    changes.each { |c| puts "    - #{c}" }
  else
    File.write(path, new_content)
    puts "  Applied:"
    changes.each { |c| puts "    - #{c}" }
  end
  
  true
end

def reorder_fields(data)
  # Define field order matching SCHEMA.md
  field_order = %w[
    archive_id company_id company
    current_name official_name japanese_name romaji_name
    product_line product_line_id manufacturer
    year release_date region
    size dimensions materials
    price price_display
    tags search_terms
    sculpt_id variant_of variant_type
    status verification confidence availability
    sources links
    notes
  ]
  
  ordered = {}
  
  # Add fields in order
  field_order.each do |field|
    ordered[field] = data[field] if data.key?(field)
  end
  
  # Add any remaining fields not in our order list
  data.each do |key, value|
    ordered[key] = value unless ordered.key?(key)
  end
  
  # Remove nil values and empty arrays for cleaner output
  ordered.reject! { |k, v| v.nil? || (v.is_a?(Array) && v.empty?) || (v.is_a?(Hash) && v.empty?) }
  
  ordered
end

# Main execution
puts "Schema Migration v0.3 → v1.0"
puts "=" * 40
puts "Mode: #{DRY_RUN ? 'DRY RUN (no changes)' : 'LIVE'}"
puts

files = Dir.glob(File.join(PLUSHES_DIR, "*.md")).sort
puts "Found #{files.size} plush files"
puts

migrated = 0
files.each do |path|
  filename = File.basename(path)
  puts "Processing: #{filename}"
  migrated += 1 if migrate_file(path)
end

puts
puts "=" * 40
puts "Summary: #{migrated}/#{files.size} files #{DRY_RUN ? 'would be' : 'were'} modified"