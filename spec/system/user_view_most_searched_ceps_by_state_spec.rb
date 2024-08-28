require 'rails_helper'

describe 'User view most searched ceps by state' do
  it 'from the navbar' do
    create :cep_stat, cep: '60060-000', city: 'Fortaleza', state: 'CE', search_quantity: 5
    create :cep_stat, cep: '62010-000', city: 'Sobral', state: 'CE', search_quantity: 1
    create :cep_stat, cep: '63100-000', city: 'Crato', state: 'CE', search_quantity: 3
    create :cep_stat, cep: '63100-000', city: 'Aracati', state: 'CE', search_quantity: 6
    create :cep_stat, cep: '62040-050', city: 'Tianguá', state: 'CE', search_quantity: 2
    create :cep_stat, cep: '63502-005', city: 'Iguatu', state: 'CE', search_quantity: 4
    create :cep_stat, cep: '30110-000', city: 'Belo Horizonte', state: 'MG'

    visit root_path
    within('nav') { click_on 'Mais buscados' }
    within('#most-searched-by-state') { select 'Ceará', from: 'Estado' }

    within('#most-searched-by-state') do
      within('tbody tr:nth-child(1)') do
        expect(page).to have_content '63100-000'
        expect(page).to have_content 'Aracati'
      end
      within('tbody tr:nth-child(2)') do
        expect(page).to have_content '60060-000'
        expect(page).to have_content 'Fortaleza'
      end
      within('tbody tr:nth-child(3)') do
        expect(page).to have_content '63502-005'
        expect(page).to have_content 'Iguatu'
      end
      within('tbody tr:nth-child(4)') do
        expect(page).to have_content '63100-000'
        expect(page).to have_content 'Crato'
      end
      within('tbody tr:nth-child(5)') do
        expect(page).to have_content '62040-050'
        expect(page).to have_content 'Tianguá'
      end
      expect(page).not_to have_content '62010-000'
      expect(page).not_to have_content 'Sobral'
      expect(page).not_to have_content '30110-000'
      expect(page).not_to have_content 'Belo Horizonte'
    end
  end

  it 'and views if there are no ceps for state' do
    visit root_path
    click_on 'Mais buscados'
    select 'Ceará', from: 'Estado'

    within('#most-searched-by-state') { expect(page).to have_content 'Não há CEPs para o estado selecionado' }
  end

  it 'and views details' do
    cep_stat = create :cep_stat, cep: '01001-000', city: 'São Paulo', state: 'SP'

    visit root_path
    click_on 'Mais buscados'
    select 'São Paulo', from: 'Estado'
    within('tbody tr:nth-child(1)') { click_on 'Visualizar' }

    expect(current_path).to eq cep_stat_path cep_stat
    expect(page).to have_content '01001-000'
    expect(page).to have_content 'São Paulo'
  end
end
