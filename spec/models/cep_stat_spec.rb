require 'rails_helper'

RSpec.describe CepStat, type: :model do
  describe '#valid' do
    it 'missing params' do
      cep_stat = CepStat.new cep: '', address: '', state: '', city: '', district: '', latitude: '',
                             longitude: '', ddd: ''

      expect(cep_stat).not_to be_valid
      expect(cep_stat.errors).to include :cep
      expect(cep_stat.errors).to include :address
      expect(cep_stat.errors).to include :state
      expect(cep_stat.errors).to include :city
      expect(cep_stat.errors).to include :district
      expect(cep_stat.errors).to include :latitude
      expect(cep_stat.errors).to include :longitude
      expect(cep_stat.errors).to include :ddd
    end

    it 'cep should be formatted' do
      cep_stat = CepStat.new cep: '12345678'

      expect(cep_stat).not_to be_valid
      expect(cep_stat.errors).to include :cep
      expect(cep_stat.errors.full_messages).to include 'CEP deve estar no formato (XXXXX-XXX)'
    end

    it 'ddd should have two numbers' do
      cep_stat = CepStat.new ddd: '8o7'

      expect(cep_stat).not_to be_valid
      expect(cep_stat.errors).to include :ddd
      expect(cep_stat.errors.full_messages).to include 'DDD deve ter exatamente dois dígitos numéricos'
    end
  end

  describe '#coordinates' do
    it 'show formatted coordinates' do
      cep_stat = CepStat.new latitude: 22.456, longitude: -75.461

      expect(cep_stat.coordinates).to eq '(22.456, -75.461)'
    end
  end
end
