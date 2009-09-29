class WasabbiPostsController < ApplicationController
  wasabbi_require_login :if_public => {:except => [:index, :show]}
  wasabbi_require_mod :except => [:index, :show, :new, :edit, :update, :create],
    :if_owner => {:except => [:edit, :destroy, :update]}
  wasabbi_check_membership

  include Wasabbi::DetermineLayout

  # GET /wasabbi_posts
  # GET /wasabbi_posts.xml
  def index
    WasabbiPost.transaction do
      if params[:thread_id]
        @wasabbi_posts = WasabbiPost.find_all_by_thread_id(params[:thread_id])
      else
        @wasabbi_posts = WasabbiPost.find(:all)
      end

      respond_to do |format|
        format.html # index.html.erb
        #format.xml  { render :xml => @wasabbi_posts }
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
        #format.xml  { render :xml => @wasabbi_post }
      end
    end
  end

  # GET /wasabbi_posts/new
  # GET /wasabbi_posts/new.xml
  def new
    WasabbiPost.transaction do
      @wasabbi_post = WasabbiPost.new(params[:wasabbi_post])

      thread = WasabbiThread.find(@wasabbi_post.thread_id)

      if !wasabbi_user.can_post_in?(thread)
        redirect_to wasabbi_denied_member_url
      else
        if params[:quote]
          qpost = WasabbiPost.find(params[:quote])
          if !wasabbi_user.can_post_in?(qpost.thread)
            redirect_to wasabbi_denied_member_url
            return
          end

          @wasabbi_post.subject = "Re: #{qpost.subject}"
          @wasabbi_post.subject.gsub!(/^\s*(Re:\s*){2,}/i, "Re: ")
          @wasabbi_post.body ||= ""
          @wasabbi_post.body = "[quote=#{qpost.wasabbi_user.username}]" +
            qpost.body + "[/quote]" + @wasabbi_post.body
        end

        respond_to do |format|
          format.html
          #format.xml  { render :xml => @wasabbi_post }
        end
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
      @wasabbi_post.wasabbi_user = wasabbi_user

      if params[:commit] !~ /preview/i
        wasabbi_user.post_count = wasabbi_user.post_count + 1

        respond_to do |format|
          if @wasabbi_post.save && wasabbi_user.save && @wasabbi_post.thread.recalc_replies!
            flash[:notice] = 'New post was successfully created.'
            format.html { redirect_to(wasabbi_thread_url(@wasabbi_post.thread,
                  :post_id => @wasabbi_post.id,
                  :anchor => @wasabbi_post.id)) }
            #format.xml  { render :xml => @wasabbi_post, :status => :created, :location => @wasabbi_post }
          else
            rollback_db_transaction
            format.html { render :action => "new" }
            #format.xml  { render :xml => @wasabbi_post.errors, :status => :unprocessable_entity }
          end
        end
      else

        render :action => "new"
      end
    end
  end

  # PUT /wasabbi_posts/1
  # PUT /wasabbi_posts/1.xml
  def update
    ActiveRecord::Base.transaction do
      @wasabbi_post = WasabbiPost.find(params[:id])

      if wasabbi_user.owns? @wasabbi_post
        @wasabbi_post.modification_quantity += 1
        @wasabbi_post.last_modified_at = Time.now
      else
        @wasabbi_post.modified_by_others = true

        mod = WasabbiModification.find_by_wasabbi_user_id(wasabbi_user.id)

        mod ||= WasabbiModification.new(
          :wasabbi_user => wasabbi_user
        )

        mod.quantity += 1
        mod.updated_at = Time.now
        mod.save!
      end

      respond_to do |format|
        if @wasabbi_post.update_attributes(params[:wasabbi_post])
          flash[:notice] = 'Your post was successfully edited.'
          format.html { redirect_to(wasabbi_thread_url(@wasabbi_post.thread,
                :post_id => @wasabbi_post.id,
                :anchor => @wasabbi_post.id)) }
          #format.xml  { head :ok }
        else
          rollback_db_transaction
          format.html { render :action => "edit" }
          #format.xml  { render :xml => @wasabbi_post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /wasabbi_posts/1
  # DELETE /wasabbi_posts/1.xml
  def destroy
    WasabbiPost.transaction do
      @wasabbi_post = WasabbiPost.find(params[:id])
      thread = @wasabbi_post.thread
      forum = thread.forum

      if thread.last_post != @wasabbi_post
        redirect_to(wasabbi_not_last_url(:post_id => @wasabbi_post.id))
      else
        @wasabbi_post.destroy
        thread.recalc_replies!

        if thread.posts(true).count == 0
          thread.thread_list_entries.destroy_all
          thread.destroy
          url = wasabbi_forum_url(forum)
        end

        respond_to do |format|
          if !url
            post = thread.posts.last
            url = wasabbi_thread_url(thread,
              :post_id => post.id,
              :anchor => post.id)
          end

          format.html { redirect_to(url) }
          #format.xml  { head :ok }
        end
      end
    end
  end
end
