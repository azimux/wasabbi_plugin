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
    concat("<table>
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
end
