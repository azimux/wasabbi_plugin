class WasabbiFileController < ApplicationController


  def send_file_data
    file_parts = params[:file_parts]
    if !file_parts
      raise render(:file => "#{RAILS_ROOT}/public/404.html", :layout => false, :status => 404)
    end

    path = File.join [RAILS_ROOT] +
      %w(vendor plugins wasabbi_plugin) +
      file_parts

    extension = /\.([^.]*)$/.match(file_parts.last)[1]

    unless %w(css).include?(extension)
      raise "bad extension: #{extension}"
    end

    if !File.exists? path
      render :file => "#{RAILS_ROOT}/public/404.html", :layout => false, :status => 404
    else
      File.open(path) do |f|
        send_data(f.read,
          :filename => file_parts.last,
          :type => "text/css", #XXX
          :disposition => 'inline')
      end
    end
  end
end
