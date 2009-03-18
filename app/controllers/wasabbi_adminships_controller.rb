class WasabbiAdminshipsController < ApplicationController
  # GET /wasabbi_adminships
  # GET /wasabbi_adminships.xml
  def index
    @wasabbi_adminships = WasabbiAdminship.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wasabbi_adminships }
    end
  end

  # GET /wasabbi_adminships/1
  # GET /wasabbi_adminships/1.xml
  def show
    @wasabbi_adminship = WasabbiAdminship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wasabbi_adminship }
    end
  end

  # GET /wasabbi_adminships/new
  # GET /wasabbi_adminships/new.xml
  def new
    @wasabbi_adminship = WasabbiAdminship.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wasabbi_adminship }
    end
  end

  # GET /wasabbi_adminships/1/edit
  def edit
    @wasabbi_adminship = WasabbiAdminship.find(params[:id])
  end

  # POST /wasabbi_adminships
  # POST /wasabbi_adminships.xml
  def create
    @wasabbi_adminship = WasabbiAdminship.new(params[:wasabbi_adminship])

    respond_to do |format|
      if @wasabbi_adminship.save
        flash[:notice] = 'WasabbiAdminship was successfully created.'
        format.html { redirect_to(@wasabbi_adminship) }
        format.xml  { render :xml => @wasabbi_adminship, :status => :created, :location => @wasabbi_adminship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wasabbi_adminship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wasabbi_adminships/1
  # PUT /wasabbi_adminships/1.xml
  def update
    @wasabbi_adminship = WasabbiAdminship.find(params[:id])

    respond_to do |format|
      if @wasabbi_adminship.update_attributes(params[:wasabbi_adminship])
        flash[:notice] = 'WasabbiAdminship was successfully updated.'
        format.html { redirect_to(@wasabbi_adminship) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wasabbi_adminship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wasabbi_adminships/1
  # DELETE /wasabbi_adminships/1.xml
  def destroy
    @wasabbi_adminship = WasabbiAdminship.find(params[:id])
    @wasabbi_adminship.destroy

    respond_to do |format|
      format.html { redirect_to(wasabbi_adminships_url) }
      format.xml  { head :ok }
    end
  end
end
