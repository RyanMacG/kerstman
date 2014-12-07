class Group < ActiveRecord::Base
  belongs_to :user
  has_many :participants, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates_presence_of :user_id, :name

  def self.matched
    binding.pry
    p 'foo'
    participants.each do |part|
      if part.giftee.blank?
        matched = false
      end
      return matched
    end
  end
end
