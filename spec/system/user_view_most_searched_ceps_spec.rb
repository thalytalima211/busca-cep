require 'rails_helper'

describe 'User view most searched ceps' do
  it 'from the navbar' do
    create :cep_stat, cep: '01001-000', city: 'São Paulo', state: 'SP', search_quantity: 5
    create :cep_stat, cep: '20010-000', city: 'Rio de Janeiro', state: 'RJ', search_quantity: 1
    create :cep_stat, cep: '30110-000', city: 'Belo Horizonte', state: 'MG', search_quantity: 3
    create :cep_stat, cep: '60010-000', city: 'Fortaleza', state: 'CE', search_quantity: 6
    create :cep_stat, cep: '70040-010', city: 'Brasília', state: 'DF', search_quantity: 2
    create :cep_stat, cep: '80010-000', city: 'Curitiba', state: 'PR', search_quantity: 4

    visit root_path
    within('nav') { click_on 'Mais buscados' }

    within('tbody tr:nth-child(1)'){
      expect(page).to have_content '60010-000'
      expect(page).to have_content 'Fortaleza'
      expect(page).to have_content 'CE'
    }
    within('tbody tr:nth-child(2)'){
      expect(page).to have_content '01001-000'
      expect(page).to have_content 'São Paulo'
      expect(page).to have_content 'SP'
    }
    within('tbody tr:nth-child(3)'){
      expect(page).to have_content '80010-000'
      expect(page).to have_content 'Curitiba'
      expect(page).to have_content 'PR'
    }
    within('tbody tr:nth-child(4)'){
      expect(page).to have_content '30110-000'
      expect(page).to have_content 'Belo Horizonte'
      expect(page).to have_content 'MG'
    }
    within('tbody tr:nth-child(5)'){
      expect(page).to have_content '70040-010'
      expect(page).to have_content 'Brasília'
      expect(page).to have_content 'DF'
    }
    expect(page).not_to have_content '20010-000'
    expect(page).not_to have_content 'Rio de Janeiro'
  end

  it 'and views if there are no ceps searched' do
    visit root_path
    within('nav') { click_on 'Mais buscados' }

    within('#most-searched-for-all') { expect(page).to have_content 'Não há CEPs pesquisados' }
  end
end
