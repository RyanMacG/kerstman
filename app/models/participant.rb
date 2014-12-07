class Participant < ActiveRecord::Base
  belongs_to :group
  belongs_to :partner,
              foreign_key: 'partner_id',
              class_name: 'Participant'
  belongs_to :giftee,
              foreign_key: 'giftee_id',
              class_name: 'Participant'

  validates_presence_of :name, :email, :group_id

  class << self
    def suitable_partners(participant:)
      where(group_id: participant.group_id).where.not(id: participant.id)
    end
  end
end
