require 'mustache'
require 'date'
class IndexExport < Mustache

  self.template_path = __dir__

  def initialize

  end

  def today_date
    Date.today.to_s
  end
end
