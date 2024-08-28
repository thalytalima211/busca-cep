FactoryBot.define do
  factory :cep_stat do
    cep { '01153-000' }
    address { 'Rua Vitorino Carmilo' }
    state { 'SP' }
    city { 'São Paulo' }
    district { 'Barra Funda' }
    latitude { -23.53115 }
    longitude { -46.65271 }
    ddd { 11 }
  end
end
