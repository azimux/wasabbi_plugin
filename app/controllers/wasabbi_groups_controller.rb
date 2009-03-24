class WasabbiGroupsController < ApplicationController
  # GET /wasabbi_groups
  # GET /wasabbi_groups.xml
  def index
    @wasabbi_groups = WasabbiGroup.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wasabbi_groups }
    end
  end

  # GET /wasabbi_groups/1
  # GET /wasabbi_groups/1.xml
  def show
    @wasabbi_group = WasabbiGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wasabbi_group }
    end
  end

  # GET /wasabbi_groups/new
  # GET /wasabbi_groups/new.xml
  def new
    @wasabbi_group = WasabbiGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wasabbi_group }
    end
  end

  # GET /wasabbi_groups/1/edit
  def edit
    @wasabbi_group = WasabbiGroup.find(params[:id])
  end

  # POST /wasabbi_groups
  # POST /wasabbi_groups.xml
  def create
    @wasabbi_group = WasabbiGroup.new(params[:wasabbi_group])

    respond_to do |format|
      if @wasabbi_group.save
        flash[:notice] = 'WasabbiGroup was successfully created.'
        format.html { redirect_to(@wasabbi_group) }
        format.xml  { render :xml => @wasabbi_group, :status => :created, :location => @wasabbi_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wasabbi_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wasabbi_groups/1
  # PUT /wasabbi_groups/1.xml
  def update
    @wasabbi_group = WasabbiGroup.find(params[:id])

    respond_to do |format|
      if @wasabbi_group.update_attributes(params[:wasabbi_group])
        flash[:notice] = 'WasabbiGroup was successfully updated.'
        format.html { redirect_to(@wasabbi_group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wasabbi_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wasabbi_groups/1
  # DELETE /wasabbi_groups/1.xml
  def destroy
    @wasabbi_group = WasabbiGroup.find(params[:id])
    @wasabbi_group.destroy

    respond_to do |format|
      format.html { redirect_to(wasabbi_groups_url) }
      format.xml  { head :ok }
    end
  end
end
