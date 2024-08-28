require 'rails_helper'

describe 'User visit homepage' do
  context 'and searches a cep' do
    it 'successfully' do
      json_data = Rails.root.join('spec/support/json/cep_result.json').read
      fake_response = double('faraday_response', status: 200, body: json_data)
      allow(Faraday).to receive(:get).with('https://cep.awesomeapi.com.br/json/01153000').and_return(fake_response)

      visit root_path
      fill_in 'Insira um CEP', with: '01153-000'
      click_on 'Pesquisar'

      expect(CepStat.count).to eq 1
      expect(current_path).to eq cep_stat_path(CepStat.last)
      expect(page).to have_content '01153-000'
      expect(page).to have_content 'Rua Vitorino Carmilo'
      expect(page).to have_content 'Bairro: Barra Funda'
      expect(page).to have_content 'Cidade: São Paulo'
      expect(page).to have_content 'Estado: SP'
      expect(page).to have_content 'DDD: 11'
      expect(page).to have_content 'Coordenadas: (-23.53115, -46.65271)'
    end

    it 'that doesn\'t exist' do
      json_data = Rails.root.join('spec/support/json/cep_not_found.json').read
      fake_response = double('faraday_response', status: 404, body: json_data)
      allow(Faraday).to receive(:get).with('https://cep.awesomeapi.com.br/json/12345678').and_return(fake_response)

      visit root_path
      fill_in 'Insira um CEP', with: '12345-678'
      click_on 'Pesquisar'

      expect(page).to have_content 'Este CEP não foi encontrado! Verifique o código.'
    end

    it 'with less than 8 numbers' do
      json_data = Rails.root.join('spec/support/json/invalid_cep.json').read
      fake_response = double('faraday_response', status: 400, body: json_data)
      allow(Faraday).to receive(:get).with('https://cep.awesomeapi.com.br/json/12345').and_return(fake_response)

      visit root_path
      fill_in 'Insira um CEP', with: '12345'
      click_on 'Pesquisar'

      expect(page).to have_content 'CEP inválido! Siga o formato (XXXXX-XXX).'
    end

    it 'that is already in the database' do
      cep = CepStat.create! cep: '01153-000', address: 'Rua Vitorino Carmilo', state: 'SP', city: 'São Paulo',
                            district: 'Barra Funda', latitude: '-23.53115', longitude: '-46.65271', ddd: 11

      visit root_path
      fill_in 'Insira um CEP', with: '01153-000'
      click_on 'Pesquisar'

      cep.reload
      expect(cep.search_quantity).to eq 2
      expect(current_path).to eq cep_stat_path cep
      expect(page).to have_content '01153-000'
      expect(page).to have_content 'Rua Vitorino Carmilo'
    end
  end
end
