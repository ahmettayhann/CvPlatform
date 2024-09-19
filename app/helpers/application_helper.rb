module ApplicationHelper

  def current_page_class(path)
    current_page?(path) ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'
  end
end
