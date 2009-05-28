class WasabbiRanksController < ApplicationController
  wasabbi_require_login
  wasabbi_require_admin

  def index
    @wasabbi_ranks = WasabbiRank.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wasabbi_ranks }
    end
  end

  # GET /wasabbi_ranks/1
  # GET /wasabbi_ranks/1.xml
  def show
    @wasabbi_rank = WasabbiRank.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wasabbi_rank }
    end
  end

  # GET /wasabbi_ranks/new
  # GET /wasabbi_ranks/new.xml
  def new
    @wasabbi_rank = WasabbiRank.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wasabbi_rank }
    end
  end

  # GET /wasabbi_ranks/1/edit
  def edit
    @wasabbi_rank = WasabbiRank.find(params[:id])
  end

  # POST /wasabbi_ranks
  # POST /wasabbi_ranks.xml
  def create
    @wasabbi_rank = WasabbiRank.new(params[:wasabbi_rank])

    respond_to do |format|
      if @wasabbi_rank.save
        flash[:notice] = 'WasabbiRank was successfully created.'
        format.html { redirect_to(@wasabbi_rank) }
        format.xml  { render :xml => @wasabbi_rank, :status => :created, :location => @wasabbi_rank }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wasabbi_rank.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wasabbi_ranks/1
  # PUT /wasabbi_ranks/1.xml
  def update
    @wasabbi_rank = WasabbiRank.find(params[:id])

    respond_to do |format|
      if @wasabbi_rank.update_attributes(params[:wasabbi_rank])
        flash[:notice] = 'WasabbiRank was successfully updated.'
        format.html { redirect_to(@wasabbi_rank) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wasabbi_rank.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wasabbi_ranks/1
  # DELETE /wasabbi_ranks/1.xml
  def destroy
    @wasabbi_rank = WasabbiRank.find(params[:id])
    @wasabbi_rank.destroy

    respond_to do |format|
      format.html { redirect_to(wasabbi_ranks_url) }
      format.xml  { head :ok }
    end
  end
end
