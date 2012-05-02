# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

require 'fastercsv'

puts "\n\nLoading seeds..."

load 'db/seed_files/codes.rb'

load 'db/seed_files/cost_categories.rb'

load 'db/seed_files/other_cost_codes.rb'

load 'db/seed_files/beneficiaries.rb'

puts "...seeding DONE\n\n"
