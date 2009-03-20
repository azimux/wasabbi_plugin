class WasabbiStaticController < ApplicationController
  def method_missing meth, *args
    #do nothing, allow it to render the appropriate template.
  end
end
