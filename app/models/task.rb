class Task < ApplicationRecord
    belongs_to :user
    with_options presence: true do
        validates :title
        validates :start_time
    end
    def already_followinged?(user)
      self.reverse_of_relationships.find_by(following_id: user.id).present? 
    end
    def already_followed?(user)
      self.relationships.find_by(follower_id: user.id).present? 
    end
end
