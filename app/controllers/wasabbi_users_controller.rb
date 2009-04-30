class WasabbiUsersController < ApplicationController
  def show
    WasabbiUser.transaction do
      @wasabbi_user = WasabbiUser.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @wasabbi_user }
      end
    end
  end
end
