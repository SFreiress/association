class Person < ApplicationRecord
  belongs_to :user, optional: true

  has_many :debts, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, :national_id, presence: true
  validates :national_id, uniqueness: true
  validate :cpf_or_cnpj

  scope :active, -> { where(active: true) }
  scope :with_positive_balance, -> { where('balance > 0') }

  def self.active_people_count
    Rails.cache.fetch("active_people_count", expires_in: 1.hour) do
      active.count
    end
  end

  def self.total_debts
    Rails.cache.fetch("total_debts", expires_in: 1.hour) do
      Debt.where(person_id: active.select(:id)).sum(:amount)
    end
  end

  def self.total_payments
    Rails.cache.fetch("total_payments", expires_in: 1.hour) do
      Payment.where(person_id: active.select(:id)).sum(:amount)
    end
  end

  def self.last_debts(limit = 10)
    Rails.cache.fetch("last_debts", expires_in: 1.hour) do
      Debt.order(created_at: :desc).limit(limit).pluck(:id, :amount)
    end
  end

  def self.last_payments(limit = 10)
    Rails.cache.fetch("last_payments", expires_in: 1.hour) do
      Payment.order(created_at: :desc).limit(limit).pluck(:id, :amount)
    end
  end

  def self.my_people(user)
    Rails.cache.fetch("my_people_#{user.id}", expires_in: 1.hour) do
      where(user: user).order(:created_at).limit(10)
    end
  end

  def self.top_person
    Rails.cache.fetch("top_person", expires_in: 1.hour) do
      with_positive_balance.order(:balance).last
    end
  end

  def self.bottom_person
    Rails.cache.fetch("bottom_person", expires_in: 1.hour) do
      with_positive_balance.order(:balance).first
    end
  end

  def update_balance
    update! balance: payments.sum(:amount) - debts.sum(:amount)
  end
end

private

  def cpf_or_cnpj
    unless CPF.valid?(national_id) || CNPJ.valid?(national_id)
      errors.add(:national_id, :invalid)
    end
  end

