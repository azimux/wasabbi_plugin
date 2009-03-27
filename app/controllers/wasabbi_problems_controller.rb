class WasabbiProblemsController < ApplicationController
  def show
    @wasabbi_level = (params[:level] || :error).to_sym
    @wasabbi_message = (params[:message] || params[:msg])

    flash.now[@wasabbi_level] = @wasabbi_message
  end
end
