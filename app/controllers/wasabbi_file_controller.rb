class WasabbiFileController < ApplicationController

  def send_file_data
    file_parts = params[:file_parts]
    if file_parts.is_a? String
      file_parts = file_parts.split "/"
    end

    if !file_parts
      raise render(:file => "#{Rails.root}/public/404.html", :layout => false, :status => 404)
    end

    path = File.expand_path(File.join(File.dirname(__FILE__), "..", "public", *file_parts))

    file_name, extension = if file_parts.last =~ /\.([^.]*)$/
      [file_parts.last, $1]
    else
      [[file_parts.last, params[:format]].join("."), params[:format]]
    end

    path.gsub!(/\.([^.]*)$/, "")

    path = [path, extension].join(".")

    unless %w(css).include?(extension)
      raise "bad extension: #{extension}"
    end

    if !File.exists? path
      render :file => "#{Rails.root}/public/404.html", :layout => false, :status => 404
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
