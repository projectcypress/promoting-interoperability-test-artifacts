require 'mustache'
class WhoExport < Mustache

  self.template_path = __dir__

  def initialize(raw_test_data)
    @raw_test_data = JSON.parse(raw_test_data.to_json)
    @test_data_hash = {}
    @test_data_hash['what'] = @raw_test_data
  end

  def test_data
    JSON.parse(@test_data_hash.values.to_json)
  end

  def data_string
    data = ""
    self['cell_data'].each do |statement|
      data += statement + "\n"
    end
    data
  end
end
