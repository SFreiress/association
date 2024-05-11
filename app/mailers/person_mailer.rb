class PersonMailer < ApplicationMailer
    default from: 'notificacoes@exemplo.com'
  
    def balance_report(current_user)
    #   @user = params[:user]
    #   @url  = 'http://exemplo.com/login'
    #   mail user.email, subject: 'Boas vindas ao nosso incrível site!'
    end
end
