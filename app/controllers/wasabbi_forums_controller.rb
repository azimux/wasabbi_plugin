class WasabbiForumsController < ApplicationController
  wasabbi_require_login :if_public => {:except => [:show]}
  wasabbi_require_admin :except => [:show]
  wasabbi_check_membership

  # GET /forums
  # GET /forums.xml
  def index
    WasabbiForum.transaction do
      @wasabbi_forums = WasabbiForum.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @wasabbi_forums }
      end
    end
  end

  # GET /forums/1
  # GET /forums/1.xml
  def show
    WasabbiForum.transaction do
      @wasabbi_forum = WasabbiForum.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @wasabbi_forum }
      end
    end
  end

  # GET /forums/new
  # GET /forums/new.xml
  def new
    WasabbiForum.transaction do
      @wasabbi_forum = WasabbiForum.new(params[:wasabbi_forum])

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @wasabbi_forum }
      end
    end
  end

  # GET /forums/1/edit
  def edit
    WasabbiForum.transaction do
      @wasabbi_forum = WasabbiForum.find(params[:id])
    end
  end

  # POST /forums
  # POST /forums.xml
  def create
    WasabbiForum.transaction do
      @wasabbi_forum = WasabbiForum.new(params[:wasabbi_forum])
      #@wasabbi_forum.parents << WasabbiForum.find(params[:forum_id])
      raise "no parent!" unless @wasabbi_forum.parent

      respond_to do |format|
        if @wasabbi_forum.save
          flash[:notice] = 'WasabbiForum was successfully created.'
          format.html { redirect_to(@wasabbi_forum) }
          format.xml  { render :xml => @wasabbi_forum, :status => :created, :location => @wasabbi_forum }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @wasabbi_forum.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /forums/1
  # PUT /forums/1.xml
  def update
    WasabbiForum.transaction do
      @wasabbi_forum = WasabbiForum.find(params[:id])

      respond_to do |format|
        if @wasabbi_forum.update_attributes(params[:wasabbi_forum])
          flash[:notice] = 'WasabbiForum was successfully updated.'
          format.html { redirect_to(@wasabbi_forum) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @wasabbi_forum.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.xml
  def destroy
    WasabbiForum.transaction do
      @wasabbi_forum = WasabbiForum.find(params[:id])

      @wasabbi_forum.string_options.clear
      @wasabbi_forum.thread_list_entries.each {|tle| tle.destroy}
      [@wasabbi_forum.modships, @wasabbi_forum.adminships].flatten.compact.each {|ma| ma.destroy}
      @wasabbi_forum.destroy

      respond_to do |format|
        format.html { redirect_to(wasabbi_forums_url) }
        format.xml  { head :ok }
      end
    end
  end

  def first
    forum = WasabbiForum.find(:first, :order => "id")
    if forum
      redirect_to wasabbi_forum_url(forum)
    else
      redirect_to new_wasabbi_forum_url
    end
  end
end
