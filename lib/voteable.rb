module Voteable
  def vote_up
    self.increment(:votes)
    self.save!
  end
end
