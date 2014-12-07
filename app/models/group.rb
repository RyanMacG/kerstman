class Group < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates_presence_of :user_id, :name
end
