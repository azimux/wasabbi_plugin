class WasabbiModshipsController < ApplicationController
  before_filter do |controller|
    controller.instance_eval do
      if params[:id]
        params[:forum_id] ||= WasabbiModship.find(params[:id]).forum_id
      elsif params[:wasabbi_modship]
        params[:forum_id] ||= params[:wasabbi_modship][:forum_id]
      end
    end
  end

  wasabbi_require_login
  wasabbi_require_admin

  # GET /wasabbi_modships
  # GET /wasabbi_modships.xml
  def index
    WasabbiModship.transaction do
      @wasabbi_modships = WasabbiModship.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @wasabbi_modships }
      end
    end
  end

  # GET /wasabbi_modships/1
  # GET /wasabbi_modships/1.xml
  def show
    WasabbiModship.transaction do
      @wasabbi_modship = WasabbiModship.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @wasabbi_modship }
      end
    end
  end

  # GET /wasabbi_modships/new
  # GET /wasabbi_modships/new.xml
  def new
    WasabbiModship.transaction do
      @wasabbi_modship = WasabbiModship.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @wasabbi_modship }
      end
    end
  end

  # GET /wasabbi_modships/1/edit
  def edit
    WasabbiModship.transaction do
      @wasabbi_modship = WasabbiModship.find(params[:id])
    end
  end

  # POST /wasabbi_modships
  # POST /wasabbi_modships.xml
  def create
    WasabbiModship.transaction do
      @wasabbi_modship = WasabbiModship.new(params[:wasabbi_modship])

      respond_to do |format|
        if @wasabbi_modship.save
          flash[:notice] = 'WasabbiModship was successfully created.'
          format.html { redirect_to(@wasabbi_modship) }
          format.xml  { render :xml => @wasabbi_modship, :status => :created, :location => @wasabbi_modship }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @wasabbi_modship.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /wasabbi_modships/1
  # PUT /wasabbi_modships/1.xml
  def update
    WasabbiModship.transaction do
      @wasabbi_modship = WasabbiModship.find(params[:id])

      respond_to do |format|
        if @wasabbi_modship.update_attributes(params[:wasabbi_modship])
          flash[:notice] = 'WasabbiModship was successfully updated.'
          format.html { redirect_to(@wasabbi_modship) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @wasabbi_modship.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /wasabbi_modships/1
  # DELETE /wasabbi_modships/1.xml
  def destroy
    WasabbiModship.transaction do
      @wasabbi_modship = WasabbiModship.find(params[:id])
      @wasabbi_modship.destroy

      respond_to do |format|
        format.html { redirect_to(wasabbi_modships_url) }
        format.xml  { head :ok }
      end
    end
  end
end
