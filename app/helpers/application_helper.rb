# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def wasabbi_theme_stylesheet
    stylesheet_link_tag Wasabbi.theme.resource_url('stylesheet.css')
  end

  def wasabbi_logo
    #XXX
    ""
  end

  def thread_table_tag(&block)
    concat("<table class='w_thread_table'>
  <th>
    Threads
  </th>
  <th>
    Replies
  </th>
  <th>
    Author
  </th>
  <th>
    Views
  </th>
  <th>
    Last Post
  </th>
  <tbody>
    #{capture(&block)}
  </tbody>
</table>")
  end

  def wasabbi_button name, url, image_path = nil, options = {}
    if image_path.is_a?({}.class) && options == {}
      options = image_path
      image_path = nil
    end

    image_path ||= "#{name.downcase.gsub(/\s*/,"_")}.img"

    image_exists = Wasabbi.theme.image_exists?(image_path)

    link_text = if image_exists
      image_tag(Wasabbi.theme.resource_url(image_path),
        :alt => name)
    else
      name
    end

    "<span class='w_#{image_exists ? 'image' : 'text'}_button'>
      #{link_to(link_text, url, options)}
    </span>"
  end
end
