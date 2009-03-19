class WasabbiThreadsController < ApplicationController
  # GET /wasabbi_threads
  # GET /wasabbi_threads.xml
  def index
    @wasabbi_threads = WasabbiThread.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wasabbi_threads }
    end
  end

  # GET /wasabbi_threads/1
  # GET /wasabbi_threads/1.xml
  def show
    @wasabbi_thread = WasabbiThread.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wasabbi_thread }
    end
  end

  # GET /wasabbi_threads/new
  # GET /wasabbi_threads/new.xml
  def new
    @wasabbi_thread = WasabbiThread.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wasabbi_thread }
    end
  end

  # GET /wasabbi_threads/1/edit
  def edit
    @wasabbi_thread = WasabbiThread.find(params[:id])
  end

  # POST /wasabbi_threads
  # POST /wasabbi_threads.xml
  def create
    @wasabbi_thread = WasabbiThread.new(params[:wasabbi_thread])

    respond_to do |format|
      if @wasabbi_thread.save
        flash[:notice] = 'WasabbiThread was successfully created.'
        format.html { redirect_to(@wasabbi_thread) }
        format.xml  { render :xml => @wasabbi_thread, :status => :created, :location => @wasabbi_thread }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wasabbi_thread.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wasabbi_threads/1
  # PUT /wasabbi_threads/1.xml
  def update
    @wasabbi_thread = WasabbiThread.find(params[:id])

    respond_to do |format|
      if @wasabbi_thread.update_attributes(params[:wasabbi_thread])
        flash[:notice] = 'WasabbiThread was successfully updated.'
        format.html { redirect_to(@wasabbi_thread) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wasabbi_thread.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wasabbi_threads/1
  # DELETE /wasabbi_threads/1.xml
  def destroy
    @wasabbi_thread = WasabbiThread.find(params[:id])
    @wasabbi_thread.thread_list_entries.each {|tle|tle.destroy}
    @wasabbi_thread.posts.each {|post| post.destroy}
    @wasabbi_thread.destroy

    respond_to do |format|
      format.html { redirect_to(wasabbi_threads_url) }
      format.xml  { head :ok }
    end
  end
end
