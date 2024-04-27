class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_people_pie_chart = {
      active: Person.active_people_count,
      inactive: Person.active.count - Person.active_people_count
    }

    @total_debts = Person.total_debts
    @total_payments = Person.total_payments
    @balance = @total_payments - @total_debts

    @last_debts = Person.last_debts
    @last_payments = Person.last_payments

    @my_people = Person.my_people(current_user)

    @top_person = Person.top_person
    @bottom_person = Person.bottom_person
  end
end
