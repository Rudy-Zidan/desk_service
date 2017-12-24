module LynksServiceDesk
  class ApplicationRecord < ActiveRecord::Base

    self.abstract_class = true

    CONFIG_FORMATTER = LynksServiceDesk::Formatters::Config

    [:hash_format, :json_format].each do |format_type|
      define_method format_type do
        LynksServiceDesk::Formatters::Model.send(format_type, self)
      end
    end

  end

end
