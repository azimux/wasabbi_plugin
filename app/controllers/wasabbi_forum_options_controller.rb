class WasabbiForumOptionsController < ApplicationController
  # GET /forum_options
  # GET /forum_options.xml
  def index
    @wasabbi_forum_options = WasabbiForumOption.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wasabbi_forum_options }
    end
  end

  # GET /forum_options/1
  # GET /forum_options/1.xml
  def show
    @wasabbi_forum_option = WasabbiForumOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wasabbi_forum_option }
    end
  end

  # GET /forum_options/new
  # GET /forum_options/new.xml
  def new
    @wasabbi_forum_option = WasabbiForumOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wasabbi_forum_option }
    end
  end

  # GET /forum_options/1/edit
  def edit
    @wasabbi_forum_option = WasabbiForumOption.find(params[:id])
  end

  # POST /forum_options
  # POST /forum_options.xml
  def create
    @wasabbi_forum_option = WasabbiForumOption.new(params[:forum_option])

    respond_to do |format|
      if @wasabbi_forum_option.save
        flash[:notice] = 'WasabbiForumOption was successfully created.'
        format.html { redirect_to(@wasabbi_forum_option) }
        format.xml  { render :xml => @wasabbi_forum_option, :status => :created, :location => @wasabbi_forum_option }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wasabbi_forum_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forum_options/1
  # PUT /forum_options/1.xml
  def update
    @wasabbi_forum_option = WasabbiForumOption.find(params[:id])

    respond_to do |format|
      if @wasabbi_forum_option.update_attributes(params[:forum_option])
        flash[:notice] = 'WasabbiForumOption was successfully updated.'
        format.html { redirect_to(@wasabbi_forum_option) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wasabbi_forum_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_options/1
  # DELETE /forum_options/1.xml
  def destroy
    @wasabbi_forum_option = WasabbiForumOption.find(params[:id])
    @wasabbi_forum_option.destroy

    respond_to do |format|
      format.html { redirect_to(wasabbi_forum_options_url) }
      format.xml  { head :ok }
    end
  end
end
