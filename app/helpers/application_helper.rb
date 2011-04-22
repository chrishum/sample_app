module ApplicationHelper

  # Return a title on a per-page basis
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    logo_file = "logo.png"
    logo_alt = "sample App"
    image_tag(logo_file, :alt => logo_alt, :class => 'round')
  end
end
