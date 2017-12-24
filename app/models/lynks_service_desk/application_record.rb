module LynksServiceDesk
  class ApplicationRecord < ActiveRecord::Base

    self.abstract_class = true

    CONFIG = LynksServiceDesk::Formatters::Config

	def hash_format
		LynksServiceDesk::Formatters::Model.hash_format(self)
	end

	def json_format
		LynksServiceDesk::Formatters::Model.hash_format(self).to_json
	end

  end

end
