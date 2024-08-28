class CepStat < ApplicationRecord
  STATES = { 'AC' => 'Acre', 'AL' => 'Alagoas', 'AP' => 'Amapá', 'AM' => 'Amazonas', 'BA' => 'Bahia', 'CE' => 'Ceará',
              'DF' => 'Distrito Federal', 'ES' => 'Espírito Santo', 'GO' => 'Goiás', 'MA' => 'Maranhão',
              'MT' => 'Mato Grosso', 'MS' => 'Mato Grosso do Sul', 'MG' => 'Minas Gerais', 'PA' => 'Pará',
              'PB' => 'Paraíba', 'PR' => 'Paraná', 'PE' => 'Pernambuco', 'PI' => 'Piauí', 'RJ' => 'Rio de Janeiro',
              'RN' => 'Rio Grande do Norte', 'RS' => 'Rio Grande do Sul', 'RO' => 'Rondônia', 'RR' => 'Roraima',
              'SC' => 'Santa Catarina', 'SP' => 'São Paulo', 'SE' => 'Sergipe', 'TO' => 'Tocantins' }.freeze

  validates :cep, :address, :state, :city, :district, :latitude, :longitude, :ddd, presence: true
  validates :cep, format: { with: /\A\d{5}-\d{3}\z/, message: I18n.t('errors.cep_stat.invalid_cep') }
  validates :ddd, format: { with: /\A\d{2}\z/, message: I18n.t('errors.cep_stat.invalid_ddd') }

  def coordinates
    "(#{latitude}, #{longitude})"
  end
end
