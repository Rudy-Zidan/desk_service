module LynksServiceDesk
  class ApplicationRecord < ActiveRecord::Base

    self.abstract_class = true

    FORMATTER_CLASS = LynksServiceDesk::Formatters::Models::Ticket

    [:hash_format, :json_format].each do |format_type|
      define_method format_type do
        FORMATTER_CLASS.send(format_type, self)
      end
    end

  end

end
