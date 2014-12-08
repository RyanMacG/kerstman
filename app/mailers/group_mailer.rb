# encoding: UTF-8
class GroupMailer < ActionMailer::Base
  default from: 'ryan@tictocfamily.com'

  def gifting_confirmation(participant, giftee, group)
    @participant = participant
    @giftee = giftee
    @group = group
    mail to: participant.email, subject: "You've been matched!"
  end
end
