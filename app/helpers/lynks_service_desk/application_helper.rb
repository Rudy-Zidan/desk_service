module LynksServiceDesk
  module ApplicationHelper

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

	def format_sub_category_params(params)
		params.require(:sub_category)
	end
  end
end
