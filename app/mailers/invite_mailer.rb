class InviteMailer < ApplicationMailer
  default from: 'betrained@betrained.us'

  def invite_email(coach, email)
    @coach = coach
    @email = email
    @url  = "www.betrained.us/athletes/sign_up/#{@coach.id}"
    mail(to: @email, subject: 'You Coach has Invited You to BeTrained')
  end
end
