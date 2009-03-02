
class WasabbiForumCategoriesController < ApplicationController
  # GET /forum_categories
  # GET /forum_categories.xml
  def index
    @wasabbi_forum_categories = WasabbiForumCategory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wasabbi_forum_categories }
    end
  end

  # GET /forum_categories/1
  # GET /forum_categories/1.xml
  def show
    @wasabbi_forum_category = WasabbiForumCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wasabbi_forum_category }
    end
  end

  # GET /forum_categories/new
  # GET /forum_categories/new.xml
  def new
    @wasabbi_forum_category = WasabbiForumCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wasabbi_forum_category }
    end
  end

  # GET /forum_categories/1/edit
  def edit
    @wasabbi_forum_category = WasabbiForumCategory.find(params[:id])
  end

  # POST /forum_categories
  # POST /forum_categories.xml
  def create
    @wasabbi_forum_category = WasabbiForumCategory.new(params[:forum_category])

    respond_to do |format|
      if @wasabbi_forum_category.save
        flash[:notice] = 'WasabbiForumCategory was successfully created.'
        format.html { redirect_to(@wasabbi_forum_category) }
        format.xml  { render :xml => @wasabbi_forum_category, :status => :created, :location => @wasabbi_forum_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wasabbi_forum_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forum_categories/1
  # PUT /forum_categories/1.xml
  def update
    @wasabbi_forum_category = WasabbiForumCategory.find(params[:id])

    respond_to do |format|
      if @wasabbi_forum_category.update_attributes(params[:forum_category])
        flash[:notice] = 'WasabbiForumCategory was successfully updated.'
        format.html { redirect_to(@wasabbi_forum_category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wasabbi_forum_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_categories/1
  # DELETE /forum_categories/1.xml
  def destroy
    @wasabbi_forum_category = WasabbiForumCategory.find(params[:id])
    @wasabbi_forum_category.destroy

    respond_to do |format|
      format.html { redirect_to(wasabbi_forum_categories_url) }
      format.xml  { head :ok }
    end
  end
end
