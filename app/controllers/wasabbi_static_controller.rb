class WasabbiStaticController < ApplicationController
  def method_missing meth, *args
    #do nothing, allow it to render the appropriate template.
  end

  def denied_member
    @forum_name = WasabbiForum.find(params[:forum_id]).name
  end

  def cant_delete_not_last
    @post = WasabbiPost.find(params[:post_id])
  end
end
