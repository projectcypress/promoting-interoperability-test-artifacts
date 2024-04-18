require 'byebug'
require 'g1g2-exports'

namespace :g1g2 do

  desc %(
    Add an admin user
  )
  task :generate_artifacts do
    criteria_paths = [# 'resources/RT1/EH_RT1_G1.json',
                      # 'resources/RT1/EH_RT1_G2.json',
                      # 'resources/RT1/EP_RT1_G1.json',
                      # 'resources/RT1/EP_RT1_G2.json',
                      # 'resources/RT2/EH_RT2a_G1.json',
                      # 'resources/RT2/EH_RT2a_G2.json',
                      # 'resources/RT2/EP_RT2a_G1.json',
                      # 'resources/RT2/EP_RT2a_G2.json',
                      # 'resources/RT2/EH_RT2b_G1.json',
                      # 'resources/RT2/EH_RT2b_G2.json',
                      # 'resources/RT2/EP_RT2b_G1.json',
                      # 'resources/RT2/EP_RT2b_G2.json',
                      # 'resources/RT2/EH_RT2c_G1.json',
                      # 'resources/RT2/EH_RT2c_G2.json',
                      # 'resources/RT2/EP_RT2c_G1.json',
                      # 'resources/RT2/EP_RT2c_G2.json',
                      # 'resources/RT7/EH_RT7_G1.json',
                      # 'resources/RT7/EH_RT7_G2.json',
                      # 'resources/RT7/EP_RT7_G1.json',
                      # 'resources/RT7/EP_RT7_G2.json',
                      # 'resources/RT15/EH_RT15_G1.json',
                      # 'resources/RT15/EH_RT15_G2.json',
                      # 'resources/RT15/EP_RT15_G1.json',
                      # 'resources/RT15/EP_RT15_G2.json',
                      'resources/Start/EH_GeneralNotes_G1.json',
                      'resources/Start/EH_GeneralNotes_G2.json',
                      'resources/Start/EP_GeneralNotes_G1.json',
                      'resources/Start/EP_GeneralNotes_G2.json'
                     ]
      criteria_paths.each do |criteria_path|
      puts criteria_path
      source = JSON.parse(File.read(criteria_path), max_nesting: 100)

      test_deck_name = source['test_deck']
      test_number = source['test_number']
      File.write("exports/test_data/#{test_deck_name.gsub(" ","_")}_#{test_number.split('-')[0].gsub(" ","_")}.html", G1G2Export.new(source).render)
      File.write("index.html", IndexExport.new.render)
    end
  end
end
