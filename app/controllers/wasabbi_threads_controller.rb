class WasabbiThreadsController < ApplicationController
  wasabbi_require_login :if_public => {:except => [:index, :show]}
  wasabbi_require_mod :except => [:index, :show, :create, :new],
    :if_owner => {:except => [:edit, :destroy, :update]}
  wasabbi_check_membership

  # GET /wasabbi_threads
  # GET /wasabbi_threads.xml
  def index
    WasabbiThread.transaction do
      forum = WasabbiForum.find(params[:forum_id])
      @wasabbi_threads = forum.threads

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @wasabbi_threads }
      end
    end
  end

  # GET /wasabbi_threads/1
  # GET /wasabbi_threads/1.xml
  def show
    WasabbiThread.transaction do
      @wasabbi_thread = WasabbiThread.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @wasabbi_thread }
      end
    end
  end

  # GET /wasabbi_threads/new
  # GET /wasabbi_threads/new.xml
  def new
    WasabbiThread.transaction do
      @wasabbi_thread = WasabbiThread.new
      @wasabbi_thread.forum_id = params[:wasabbi_thread][:forum_id]

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @wasabbi_thread }
      end
    end
  end

  # GET /wasabbi_threads/1/edit
  def edit
    WasabbiThread.transaction do
      @wasabbi_thread = WasabbiThread.find(params[:id])
    end
  end

  # POST /wasabbi_threads
  # POST /wasabbi_threads.xml
  def create
    WasabbiThread.transaction do
      forum_id = params[:wasabbi_thread].delete(:forum_id)
      @wasabbi_thread = WasabbiThread.new(params[:wasabbi_thread])
      @wasabbi_thread.forum_id = forum_id
      @wasabbi_thread.wasabbi_user = wasabbi_user
      @wasabbi_thread.bumped_at = Time.now

      respond_to do |format|
        if @wasabbi_thread.save
          WasabbiThreadListEntry.create!(:thread_id => @wasabbi_thread.id,
            :forum_id => @wasabbi_thread.forum_id,
            :bumped_at => @wasabbi_thread.bumped_at
          )
          flash[:notice] = 'WasabbiThread was successfully created.'
          format.html { redirect_to(@wasabbi_thread) }
          format.xml  { render :xml => @wasabbi_thread, :status => :created, :location => @wasabbi_thread }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @wasabbi_thread.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /wasabbi_threads/1
  # PUT /wasabbi_threads/1.xml
  def update
    WasabbiThread.transaction do
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
  end

  # DELETE /wasabbi_threads/1
  # DELETE /wasabbi_threads/1.xml
  def destroy
    WasabbiThread.transaction do
      @wasabbi_thread = WasabbiThread.find(params[:id])

      if @wasabbi_thread.posts.size == 1
        @wasabbi_thread.thread_list_entries.each {|tle|tle.destroy}
        @wasabbi_thread.posts.first.destroy
        @wasabbi_thread.destroy

        respond_to do |format|
          format.html { redirect_to(wasabbi_threads_url) }
          format.xml  { head :ok }
        end
      else
        flash[:error] = "You can't delete threads that have been replied to."

        respond_to do |format|
          format.html { redirect_to(@wasabbi_thread) }
          format.xml  { render :xml => "Can't delete threads that have been replied to.", :status => :unprocessable_entity }
        end
      end
    end
  end
end
