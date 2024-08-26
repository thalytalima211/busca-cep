require 'rails_helper'

describe 'User visit homepage' do
  it 'and seaches a cep' do
    json_data = File.read(Rails.root.join('spec/support/json/cep_result.json'))
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('https://cep.awesomeapi.com.br/json/01153000').and_return(fake_response)

    visit root_path
    fill_in 'Insira um CEP', with: '01153000'
    click_on 'Pesquisar'

    expect(CepStat.count).to eq 1
    expect(current_path).to eq cep_stat_path(CepStat.last)
    expect(page).to have_content '01153000'
    expect(page).to have_content 'Rua Vitorino Carmilo'
    expect(page).to have_content 'Bairro: Barra Funda'
    expect(page).to have_content 'Cidade: São Paulo'
    expect(page).to have_content 'Estado: SP'
    expect(page).to have_content 'DDD: 11'
    expect(page).to have_content 'Coord.: (-23.53115, -46.65271)'
  end

  it 'and searches a cep that doesn\'t exist' do
    json_data = File.read(Rails.root.join('spec/support/json/cep_not_found.json'))
    fake_response = double('faraday_response', status: 404, body: json_data)
    allow(Faraday).to receive(:get).with('https://cep.awesomeapi.com.br/json/12345678').and_return(fake_response)

    visit root_path
    fill_in 'Insira um CEP', with: '12345678'
    click_on 'Pesquisar'

    expect(page).to have_content 'O CEP 12345678 não foi encontrado! Verifique o código e tente novamente.'
  end
end
