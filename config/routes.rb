Rails.application.routes.draw do
  scope :path => "/#{Wasabbi.path_prefix}" do
    [
      ["forum_string_options"],
      ["forums", {}, proc {collection {get :top}}],
      ["threads"],
      ["posts"],
      ["adminships"],
      ["modships"],
      ["users", {:only => [:show]}],
      ["ranks"]
    ].each do |resource, options, block|
      resources "wasabbi_#{resource}",
        (options || {}),
        &(block || proc{})
    end
  end

  scope :controller => "wasabbi_static" do
    get "wasabbi_static/denied_admin" => :denied_admin,
      :as => :wasabbi_denied_admin
    get "wasabbi_static/denied_mod" => :denied_mod,
      :as => :wasabbi_denied_mod
    get "wasabbi_static/denied_member" => :denied_member,
      :as => :wasabbi_denied_member
    get "wasabbi_static/cant_delete_not_last" => :cant_delete_not_last,
      :as => :wasabbi_not_last
  end

  get "vendor/plugins/wasabbi_plugin/*file_parts" =>
    "wasabbi_file#send_file_data",
    :as => :wasabbi_file

  get "wasabbi_problem" => "wasabbi_problems#",
    :as => "wasabbi_problem"
end