require 'socket'

class WasabbiThreadsController < ApplicationController
  wasabbi_require_login :if_public => {:except => [:index, :show]}
  wasabbi_require_mod :except => [:index, :show, :create, :new],
    :if_owner => {:except => [:edit, :destroy, :update]}
  wasabbi_check_membership

  include Wasabbi::DetermineLayout

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

      page = (params[:page] || 1).to_i
      items_per_page = session[:items_per_page] || 20
      total_items = @wasabbi_thread.post_count

      if params[:post_id]
        post = WasabbiPost.find(params[:post_id])

        raise "no such post in this thread" if post.thread != @wasabbi_thread

        item_page = (@wasabbi_thread.posts_in_front_of(post) / items_per_page) + 1

        if item_page != page
          wrong_page = true
          redirect_to wasabbi_thread_url(@wasabbi_thread,
            :page => item_page,
            :anchor => params[:post_id])
        end
      end

      if !wrong_page
        @page_of_posts = Wasabbi::Page.new(
          @wasabbi_thread.page_of_posts(page, items_per_page),
          total_items,
          page,
          items_per_page
        )

        #let's see if we should increase the view count.
        #don't increase it if it's a known bot.
        #only increase it if the REFERER url is from this site.
        host = Socket.getaddrinfo(request.remote_ip, nil).last[2]

        masks = [
          /googlebot.com$/,
          /cuill.com$/,
        ]

        unless masks.map {|p| host =~ p}.any?
          ref = request.env['HTTP_REFERER']
          req = request.env['REQUEST_URI']

          if !ref.nil? && !req.nil?
            begin
              if URI.parse(ref).host == URI.parse(req).host
                path = Rails.application.routes.recognize_path(
                  URI.parse(ref).path,
                  :method => :get
                )

                if path.nil? || path[:controller] != controller_name
                  #=~ /wasabbi_threads\/#{@wasabbi_thread.id}\s*([;\/&]|$)/
                  @wasabbi_thread.views += 1
                  @wasabbi_thread.save!
                end
              end
            rescue URI::InvalidURIError => e
              puts e
            end
          end


        end

        respond_to do |format|
          format.html # show.html.erb
          #format.xml  { render :xml => @wasabbi_thread }
        end
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
      wasabbi_user.post_count += 1

      respond_to do |format|
        if @wasabbi_thread.save && wasabbi_user.save
          WasabbiThreadListEntry.create!(:thread_id => @wasabbi_thread.id,
            :forum_id => @wasabbi_thread.forum_id
          )
          WasabbiPost.create!(:thread_id => @wasabbi_thread.id,
            :subject => @wasabbi_thread.subject,
            :body => @wasabbi_thread.body,
            :wasabbi_user_id => @wasabbi_thread.wasabbi_user_id
          )

          flash[:notice] = 'New thread successfully created.'
          format.html { redirect_to(@wasabbi_thread) }
          format.xml  { render :xml => @wasabbi_thread, :status => :created, :location => @wasabbi_thread }
        else
          rollback_db_transaction
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
          flash[:notice] = 'Your thread was successfully edited.'
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

      if @wasabbi_thread.posts.size == 1 || wasabbi_user.mod?(@wasabbi_thread.forum)
        @wasabbi_thread.thread_list_entries.each {|tle|tle.destroy}
        @wasabbi_thread.posts.destroy_all
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
