class CepStat < ApplicationRecord
  validates :cep, :address, :state, :city, :district, :latitude, :longitude, :ddd, presence: true
  validates :cep, format: { with: /\A\d{5}-\d{3}\z/, message: I18n.t('errors.cep_stat.invalid_cep') }
  validates :ddd, format: { with: /\A\d{2}\z/, message: I18n.t('errors.cep_stat.invalid_ddd') }

  def coordinates
    "(#{latitude}, #{longitude})"
  end
end
