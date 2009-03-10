class WasabbiForumStringOptionsController < ApplicationController
  # GET /wasabbi_forum_string_options
  # GET /wasabbi_forum_string_options.xml
  def index
    @wasabbi_forum_string_options = WasabbiForumStringOption.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wasabbi_forum_string_options }
    end
  end

  # GET /wasabbi_forum_string_options/1
  # GET /wasabbi_forum_string_options/1.xml
  def show
    @wasabbi_forum_string_option = WasabbiForumStringOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wasabbi_forum_string_option }
    end
  end

  # GET /wasabbi_forum_string_options/new
  # GET /wasabbi_forum_string_options/new.xml
  def new
    @wasabbi_forum_string_option = WasabbiForumStringOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wasabbi_forum_string_option }
    end
  end

  # GET /wasabbi_forum_string_options/1/edit
  def edit
    @wasabbi_forum_string_option = WasabbiForumStringOption.find(params[:id])
  end

  # POST /wasabbi_forum_string_options
  # POST /wasabbi_forum_string_options.xml
  def create
    @wasabbi_forum_string_option = WasabbiForumStringOption.new(params[:wasabbi_forum_string_option])

    respond_to do |format|
      if @wasabbi_forum_string_option.save
        flash[:notice] = 'WasabbiForumStringOption was successfully created.'
        format.html { redirect_to(@wasabbi_forum_string_option) }
        format.xml  { render :xml => @wasabbi_forum_string_option, :status => :created, :location => @wasabbi_forum_string_option }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wasabbi_forum_string_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wasabbi_forum_string_options/1
  # PUT /wasabbi_forum_string_options/1.xml
  def update
    @wasabbi_forum_string_option = WasabbiForumStringOption.find(params[:id])

    respond_to do |format|
      if @wasabbi_forum_string_option.update_attributes(params[:wasabbi_forum_string_option])
        flash[:notice] = 'WasabbiForumStringOption was successfully updated.'
        format.html { redirect_to(@wasabbi_forum_string_option) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wasabbi_forum_string_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wasabbi_forum_string_options/1
  # DELETE /wasabbi_forum_string_options/1.xml
  def destroy
    @wasabbi_forum_string_option = WasabbiForumStringOption.find(params[:id])
    @wasabbi_forum_string_option.destroy

    respond_to do |format|
      format.html { redirect_to(wasabbi_forum_string_options_url) }
      format.xml  { head :ok }
    end
  end
end
