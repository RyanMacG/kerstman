class Group < ActiveRecord::Base
  belongs_to :user
  has_many :participants, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates_presence_of :user_id, :name
end
