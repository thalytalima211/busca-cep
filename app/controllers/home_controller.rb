class HomeController < ApplicationController
  def index
    if params[:cep]
      cep_number = params[:cep].gsub('-', '')
      cep = CepStat.find_by cep: params[:cep]
      if cep
        cep.search_quantity = cep.search_quantity + 1
        cep.save!
        redirect_to cep_stat_path cep
      else
        response = Faraday.get("https://cep.awesomeapi.com.br/json/#{cep_number}")
        if response.status == 200
          data = JSON.parse response.body
          new_cep = CepStat.create! cep: params[:cep], address: data['address'], state: data['state'],
                                    city: data['city'], district: data['district'], latitude: data['lat'],
                                    longitude: data['lng'], ddd: data['ddd']
          redirect_to cep_stat_path new_cep
        elsif response.status == 404
          redirect_to root_path, notice: "O CEP #{params[:cep]} não foi encontrado! Verifique o código."
        elsif response.status == 400
          redirect_to root_path, notice: 'CEP inválido! Siga o formato (XXXXX-XXX).'
        end
      end
    end
  end
end
