class PersonMailer < ApplicationMailer
    default from: 'notificacoes@exemplo.com'
  
    def balance_report(user)
      mail to: user.email, subject: 'Boas vindas ao nosso incrível site!'
    end
end
