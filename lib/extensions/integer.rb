Integer.class_eval do
  def to_forum
    WasabbiForum.find(self)
  end
end
