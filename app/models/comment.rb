class Comment < ActiveRecord::Base
  belongs_to :post || :topic
  belongs_to :user
 
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
end
