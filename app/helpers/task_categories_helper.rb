module TaskCategoriesHelper

  def is_active_category(page_name)
    if params[:controller] == "task_categories" && params[:action] == "show" && params[:id] == page_name
      "active"
    end
  end

end
