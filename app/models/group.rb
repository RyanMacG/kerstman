class Group < ActiveRecord::Base
  belongs_to :user
  has_many :participants, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates_presence_of :user_id, :name

  def all_matched
    self.participants.each do |part|
      if part.giftee.blank?
        all_matched = false
      end
      all_matched ||= true
      return all_matched
    end
  end
end
