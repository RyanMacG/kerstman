class Participant < ActiveRecord::Base
  belongs_to :group
  belongs_to :gifter,
              foreign_key: 'gifter_id',
              class_name: 'Participant'
  belongs_to :giftee,
              foreign_key: 'giftee_id',
              class_name: 'Participant'

  validates_presence_of :name, :email, :group_id
end
