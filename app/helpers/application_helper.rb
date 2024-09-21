module ApplicationHelper

  def user_avatar(user, size: 100)
    if user.avatar.attached?
      image_tag user.avatar.variant(resize_to_fill: [size, size]), class: "rounded-full"
    else
      image_tag "default_avatar.png", width: size, height: size, class: "rounded-full"
    end
  end

  def current_page_class(path)
    current_page?(path) ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'
  end
end
