class WasabbiPostsController < ApplicationController
  # GET /wasabbi_posts
  # GET /wasabbi_posts.xml
  def index
    WasabbiPost.transaction do
      @wasabbi_posts = WasabbiPost.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @wasabbi_posts }
      end
    end
  end

  # GET /wasabbi_posts/1
  # GET /wasabbi_posts/1.xml
  def show
    WasabbiPost.transaction do
      @wasabbi_post = WasabbiPost.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @wasabbi_post }
      end
    end
  end

  # GET /wasabbi_posts/new
  # GET /wasabbi_posts/new.xml
  def new
    WasabbiPost.transaction do
      @wasabbi_post = WasabbiPost.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @wasabbi_post }
      end
    end
  end

  # GET /wasabbi_posts/1/edit
  def edit
    WasabbiPost.transaction do
      @wasabbi_post = WasabbiPost.find(params[:id])
    end
  end

  # POST /wasabbi_posts
  # POST /wasabbi_posts.xml
  def create
    WasabbiPost.transaction do
      @wasabbi_post = WasabbiPost.new(params[:wasabbi_post])

      respond_to do |format|
        if @wasabbi_post.save
          flash[:notice] = 'WasabbiPost was successfully created.'
          format.html { redirect_to(@wasabbi_post) }
          format.xml  { render :xml => @wasabbi_post, :status => :created, :location => @wasabbi_post }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @wasabbi_post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /wasabbi_posts/1
  # PUT /wasabbi_posts/1.xml
  def update
    WasabbiPost.transaction do
      @wasabbi_post = WasabbiPost.find(params[:id])

      respond_to do |format|
        if @wasabbi_post.update_attributes(params[:wasabbi_post])
          flash[:notice] = 'WasabbiPost was successfully updated.'
          format.html { redirect_to(@wasabbi_post) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @wasabbi_post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /wasabbi_posts/1
  # DELETE /wasabbi_posts/1.xml
  def destroy
    WasabbiPost.transaction do
      @wasabbi_post = WasabbiPost.find(params[:id])
      @wasabbi_post.destroy

      respond_to do |format|
        format.html { redirect_to(wasabbi_posts_url) }
        format.xml  { head :ok }
      end
    end
  end
end
