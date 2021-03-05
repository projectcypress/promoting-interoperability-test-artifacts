require 'byebug'
require 'g1g2-exports'

namespace :g1g2 do

  task :generate_who do
    criteria_paths = ['resources/WHO/WHO_AUDIT_L2.json'
                     ]
      criteria_paths.each do |criteria_path|
      puts criteria_path
      source = JSON.parse(File.read(criteria_path), max_nesting: 100)

      title = source['title']
      test_number = source['test_number']
      File.write("exports/who_data/#{title}.html", WhoExport.new(source).render)
    end
  end
end
