#!/usr/bin/env ruby
# Usage: ruby scripts/new_plush.rb COMPANY_ID [--status STATUS]
# Example: ruby scripts/new_plush.rb JPPC
# Example: ruby scripts/new_plush.rb BAN --status Master
#
# Creates a new plush entry with the next sequential ID for the given company.
# Valid company IDs: BAN, BNS, JPPC, TOMY, USPC
# Valid statuses: Master, Research, Missing (default: Research)
#
# Schema version: 1.0 (see SCHEMA.md)

require 'fileutils'
require 'date'

COMPANIES = {
  "BAN"  => { name: "Banpresto", region: "Japan" },
  "BNS"  => { name: "Bandai Spirits", region: "Japan" },
  "JPPC" => { name: "Pokémon Center Japan", region: "Japan" },
  "TOMY" => { name: "TOMY", region: "Japan" },
  "USPC" => { name: "Pokémon Center US", region: "North America" },
}

VALID_STATUSES = %w[Master Research Missing]

PLUSHES_DIR = File.expand_path("../_plushes", __dir__)
IMAGES_DIR = File.expand_path("../assets/images/plushes", __dir__)

def usage
  puts "Usage: ruby scripts/new_plush.rb COMPANY_ID [--status STATUS]"
  puts ""
  puts "Valid company IDs: #{COMPANIES.keys.join(', ')}"
  puts "Valid statuses: #{VALID_STATUSES.join(', ')} (default: Research)"
  puts ""
  puts "Examples:"
  puts "  ruby scripts/new_plush.rb JPPC"
  puts "  ruby scripts/new_plush.rb BAN --status Master"
  exit 1
end

def get_next_id(company_id)
  prefix = "JIR-#{company_id}-"
  existing = Dir.glob(File.join(PLUSHES_DIR, "#{prefix}*.md"))
  
  max_num = 0
  existing.each do |path|
    basename = File.basename(path, ".md")
    if basename =~ /#{prefix}(\d+)$/
      num = $1.to_i
      max_num = num if num > max_num
    end
  end
  
  next_num = max_num + 1
  sprintf("JIR-#{company_id}-%04d", next_num)
end

def create_plush(company_id, new_id, status)
  company = COMPANIES[company_id]
  
  # Build status-specific fields
  status_fields = case status
  when "Master"
    "verification: Verified"
  when "Research"
    "verification: Possible\nconfidence: Possible"
  when "Missing"
    "verification: Unverified"
  end
  
  template = <<~YAML
    ---
    # === IDENTITY ===
    archive_id: #{new_id}
    company_id: #{company_id}
    company: #{company[:name]}
    
    # === NAMES ===
    current_name: 
    official_name: 
    japanese_name: 
    romaji_name: 
    
    # === CLASSIFICATION ===
    product_line: 
    product_line_id: 
    manufacturer: 
    
    # === RELEASE INFO ===
    year: 
    release_date: 
    region: #{company[:region]}
    
    # === PHYSICAL ATTRIBUTES ===
    size: 
    dimensions:
      height: 
      width: 
      depth: 
    materials: []
    
    # === PRICING ===
    price:
      amount: 
      currency: JPY
    price_display: 
    
    # === TAXONOMY ===
    tags: []
    search_terms: []
    
    # === VARIANTS & RELATIONSHIPS ===
    sculpt_id: 
    variant_of: 
    variant_type: 
    
    # === STATUS & VERIFICATION ===
    status: #{status}
    #{status_fields}
    availability: 
    
    # === PROVENANCE ===
    sources:
      - type: 
        tier: 
        url: 
        accessed: 
        notes: 
    
    # === DOCUMENTATION ===
    notes: 
    last_updated: #{Date.today.strftime('%Y-%m-%d')}
    ---
  YAML
  
  # Create plush file
  path = File.join(PLUSHES_DIR, "#{new_id}.md")
  File.write(path, template)
  
  # Create image directory
  image_dir = File.join(IMAGES_DIR, new_id)
  FileUtils.mkdir_p(image_dir)
  FileUtils.touch(File.join(image_dir, ".gitkeep"))
  
  path
end

# Parse arguments
company_id = nil
status = "Research"

args = ARGV.dup
while args.any?
  arg = args.shift
  case arg
  when "--status"
    status = args.shift&.capitalize
    unless status && VALID_STATUSES.include?(status)
      puts "Error: Invalid status. Valid options: #{VALID_STATUSES.join(', ')}"
      exit 1
    end
  when /^-/
    puts "Error: Unknown option: #{arg}"
    usage
  else
    company_id = arg.upcase
  end
end

usage unless company_id && COMPANIES.key?(company_id)

new_id = get_next_id(company_id)
path = create_plush(company_id, new_id, status)

puts "Created: #{path}"
puts "New ID: #{new_id}"
puts "Status: #{status}"
puts "Image directory: assets/images/plushes/#{new_id}/"
puts ""
puts "Next steps:"
puts "  1. Fill in the entry details"
puts "  2. Add images to assets/images/plushes/#{new_id}/"
puts "  3. See SCHEMA.md for field reference"