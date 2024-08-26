require 'rails_helper'

describe 'User visit homepage' do
  it 'and seaches a cep' do
    json_data = File.read(Rails.root.join('spec/support/json/cep_result.json'))
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('https://cep.awesomeapi.com.br/json/01153000').and_return(fake_response)

    visit root_path
    fill_in 'Insira um CEP', with: '01153000'
    click_on 'Pesquisar'

    expect(current_path).to eq cep_path(CEP.last)
    expect(page).to have_content '01153000'
    expect(page).to have_content 'Rua Victorino Carmilo'
    expect(page).to have_content 'Bairro: Barra Funda'
    expect(page).to have_content 'Cidade: São Paulo'
    expect(page).to have_content 'Estado: SP'
    expect(page).to have_content 'DDD: 11'
    expect(page).to have_content 'Coord.: (-23.53115, -46.65271)'
  end
end
