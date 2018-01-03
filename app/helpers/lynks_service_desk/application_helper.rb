module LynksServiceDesk
  module ApplicationHelper

  	CONFIG = LynksServiceDesk::Formatters::Config

  	def find_sub_category(params)
      sub_category_params = params.require(:sub_category).permit(:name, :slug)
      sub_category_slug = sub_category_params[:name].try(:parameterize).try(:underscore)
      sub_category_slug ||= sub_category_params[:slug]
      sub_category = LynksServiceDesk::SubCategory.find_by_slug(sub_category_slug)
      if sub_category.blank?
        raise ActionController::RoutingError.new("Could not find sub category with slug #{sub_category_slug}")
      end
      sub_category
  	end

  	def format_sub_category_options(params, sub_category)
      options = params.require(:sub_category).require(:options)
      results_hash = {}
      sub_category.options["parameters"].each do |param_name, param_type|
        param_value = options.fetch(param_name)
        param_type_class = param_type.constantize
        case param_type_class.constantize
        when Date
          param_value = Date.parse(param_value)
        when DateTime
          param_value = DateTime.parse(param_value)
        when Integer
          param_value = param_value.to_i
        when Float
          param_value = param_value.to_f
        end

        results_hash[param_name] = param_value
      end
      return results_hash
    rescue ArgumentError => e
      raise "#{param_value} is not a valid #{param_type}"
    rescue NameError => e
      raise "'#{param_type}' is not supported. Only Date, DateTime, Integer, Float, and String are."
  	end

  end
end
